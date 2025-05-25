 

#include "llvm/Support/CommandLine.h"
#include "llvm/Support/raw_ostream.h"

#include "JITD.h"

using namespace llvm;
using namespace ExampleVM;

namespace {

// Command line arguments parsed using LLVM's command line parser.
cl::opt<std::string> InputFilename(cl::Positional, cl::desc("<input file>"),
                                   cl::Required);
cl::opt<std::string> OutputFilename("o", cl::desc("Specify output filename"),
                                    cl::value_desc("filename"));
void versionPrinter(llvm::raw_ostream &OS) { OS << "lljit: v0.0.0\n"; }

ExitOnError ExitOnErr;

} // end of anonymous namespace

int main(int argc, char *argv[]) {
  cl::SetVersionPrinter(versionPrinter);
  cl::ParseCommandLineOptions(argc, argv);

  ExampleJIT::init();
  auto SJ = ExitOnErr(ExampleJIT::create(InputFilename));
  // Look for function named "jitentry" in LLVM-IR and run it.
  auto ExampleMainAddr = ExitOnErr(SJ->getAddressFor("jitentry"));
  auto ExampleMain = reinterpret_cast<void (*)()>(ExampleMainAddr);

  ExampleMain();

  return EXIT_SUCCESS;
}
