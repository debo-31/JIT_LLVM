

#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <memory>
#include <mutex>

#include "llvm/ADT/StringRef.h"
#include "llvm/ExecutionEngine/JITEventListener.h"
#include "llvm/ExecutionEngine/JITSymbol.h"
#include "llvm/ExecutionEngine/ObjectCache.h"
#include "llvm/ExecutionEngine/Orc/CompileUtils.h"
#include "llvm/ExecutionEngine/Orc/Core.h"
#include "llvm/ExecutionEngine/Orc/ExecutionUtils.h"
#include "llvm/ExecutionEngine/Orc/JITTargetMachineBuilder.h"
#include "llvm/ExecutionEngine/Orc/LLJIT.h"
#include "llvm/ExecutionEngine/Orc/RTDyldObjectLinkingLayer.h"
#include "llvm/ExecutionEngine/SectionMemoryManager.h"
#include "llvm/IR/DataLayout.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/LegacyPassManager.h"
#include "llvm/IRReader/IRReader.h"
#include "llvm/Support/SourceMgr.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/Transforms/InstCombine/InstCombine.h"
#include "llvm/Transforms/Scalar.h"
#include "llvm/Transforms/Scalar/GVN.h"
#include "llvm/Transforms/Utils.h"

#include "JITD.h"

using namespace llvm;

namespace {

struct FunctionsMap {
  const char *FName;
  void *FAddr;
};

std::vector<FunctionsMap> getFunctions() {
  static const FunctionsMap m[] = {
    {"printf", reinterpret_cast<void*>(static_cast<int(*)(const char*, ...)>(printf))},
    {"malloc", reinterpret_cast<void*>(static_cast<void*(*)(size_t)>(malloc))},
    {"free", reinterpret_cast<void*>(static_cast<void(*)(void*)>(free))},
    {"scanf", reinterpret_cast<void*>(static_cast<int(*)(const char*, ...)>(scanf))},
    {"strlen", reinterpret_cast<void*>(static_cast<size_t(*)(const char*)>(strlen))},
    {"puts", reinterpret_cast<void*>(static_cast<int(*)(const char*)>(puts))},
    {"fgets", reinterpret_cast<void*>(static_cast<char*(*)(char*, int, FILE*)>(fgets))},
    {"strcpy", reinterpret_cast<void*>(static_cast<char*(*)(char*, const char*)>(strcpy))},
    {"strncpy", reinterpret_cast<void*>(static_cast<char*(*)(char*, const char*, size_t)>(strncpy))},
    {"strcat", reinterpret_cast<void*>(static_cast<char*(*)(char*, const char*)>(strcat))},
    {"strncat", reinterpret_cast<void*>(static_cast<char*(*)(char*, const char*, size_t)>(strncat))},
    {"strcmp", reinterpret_cast<void*>(static_cast<int(*)(const char*, const char*)>(strcmp))},
    {"strchr", reinterpret_cast<void*>(static_cast<char*(*)(const char*, int)>(strchr))},
    {"strcspn", reinterpret_cast<void*>(static_cast<size_t(*)(const char*, const char*)>(strcspn))},
    {"exit", reinterpret_cast<void*>(static_cast<void(*)(int)>(exit))}
  };

  return std::vector<FunctionsMap>(std::begin(m), std::end(m));
}

// Add functions in SRTL that the JIT'ed code can access.
Error addExampleBuiltins(orc::LLJIT &LLJitter, const DataLayout &DL) {
  orc::SymbolMap M;
  orc::MangleAndInterner Mangle(LLJitter.getExecutionSession(), DL);
  
  // Register every symbol that can be accessed from the JIT'ed code.
  auto ExampleFuncs = getFunctions();
  for (const auto &fa : ExampleFuncs) {
    M[Mangle(fa.FName)] = orc::ExecutorSymbolDef(
        orc::ExecutorAddr::fromPtr(fa.FAddr), JITSymbolFlags::Exported);
  }

  return LLJitter.getMainJITDylib().define(absoluteSymbols(std::move(M)));
}

// Add optimization passes
void addOptimizationPasses(legacy::PassManager &PM) {
  PM.add(createInstructionCombiningPass());
  PM.add(createReassociatePass());
  PM.add(createGVNPass());
  PM.add(createCFGSimplificationPass());
}

} // end of anonymous namespace

namespace ExampleVM {

using namespace orc;

namespace {
std::once_flag InitFlag;
}

void ExampleJIT::init() {
  std::call_once(InitFlag, []() {
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();
  });
}

Expected<std::unique_ptr<ExampleJIT>>
ExampleJIT::create(const std::string &Filename, ObjectCache *OC) {
  // Create an LLJIT instance with a custom CompileFunction and ObjectLinkingLayer.
  auto J = orc::LLJITBuilder()
    .setCompileFunctionCreator(
      [OC](JITTargetMachineBuilder JTMB)
          -> Expected<std::unique_ptr<IRCompileLayer::IRCompiler>> {
        auto TM = JTMB.createTargetMachine();
        if (!TM)
          return TM.takeError();
        auto Compiler = std::make_unique<TMOwningSimpleCompiler>(std::move(*TM), OC);
        // NOTE: Optimization passes can be added here by running a legacy::PassManager on the module before JITing, if needed.
        return std::move(Compiler);
      })
    .setObjectLinkingLayerCreator(
      [](ExecutionSession &ES, const Triple &TT) -> std::unique_ptr<ObjectLayer> {
        auto GetMemMgr = []() {
          return std::make_unique<SectionMemoryManager>();
        };
        
        auto ObjLinkingLayer = std::make_unique<RTDyldObjectLinkingLayer>(
            ES, std::move(GetMemMgr));
            
        if (TT.isOSBinFormatCOFF()) {
          ObjLinkingLayer->setOverrideObjectFlagsWithResponsibilityFlags(true);
          ObjLinkingLayer->setAutoClaimResponsibilityForObjectSymbols(true);
        }
        
        // Add GDB support
        if (auto *GDBListener = JITEventListener::createGDBRegistrationListener()) {
          ObjLinkingLayer->setNotifyLoaded(
            [GDBListener](orc::MaterializationResponsibility &MR,
                         const object::ObjectFile &Obj,
                         const RuntimeDyld::LoadedObjectInfo &Info) {
              GDBListener->notifyObjectLoaded(
                static_cast<uint64_t>(reinterpret_cast<uintptr_t>(&MR)), Obj, Info);
            });
        }
        
        return ObjLinkingLayer;
      })
    .create();

  if (!J) {
    errs() << "[JIT ERROR] Failed to create JIT instance.\n";
    return J.takeError();
  }

  if (auto Err = addExampleBuiltins(**J, (*J)->getDataLayout())) {
    errs() << "[JIT ERROR] Failed to add built-in functions.\n";
    return std::move(Err);
  }

  // Create context and load module
  auto Ctx = std::make_unique<LLVMContext>();
  SMDiagnostic Smd;
  auto M = parseIRFile(Filename, Smd, *Ctx);
  if (!M) {
    std::string ErrMsg;
    raw_string_ostream OS(ErrMsg);
    Smd.print("lljit", OS);
    errs() << "[JIT ERROR] Could not parse IR file: " << Filename << "\n" << OS.str();
    return createStringError(inconvertibleErrorCode(), "Could not parse IR file: %s\n%s", Filename.c_str(), OS.str().c_str());
  }

  // Create JIT instance and add module
  auto JIT = std::unique_ptr<ExampleJIT>(new ExampleJIT(std::move(*J)));
  ThreadSafeModule TSM(std::move(M), std::move(Ctx));
  if (auto Err = JIT->Jitter->addIRModule(std::move(TSM))) {
    errs() << "[JIT ERROR] Failed to add IR module to JIT.\n";
    JIT.reset(); // Clean up
    return std::move(Err);
  }

  return JIT;
}

Expected<void *> ExampleJIT::getAddressFor(const std::string &Symbol) {
  auto SA = Jitter->lookup(Symbol);
  if (!SA) {
    errs() << "[JIT ERROR] Could not find symbol: " << Symbol << "\n";
    return SA.takeError();
  }
  return reinterpret_cast<void *>(SA->getValue());
}

} // namespace ExampleVM
 