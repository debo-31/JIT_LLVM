#include "code_generator.h"

SimpleCodeGenerator::SimpleCodeGenerator(SimpleMemoryManager& memManager)
    : memoryManager(memManager) {}

void SimpleCodeGenerator::emitByte(uint8_t byte) {
    codeBuffer.push_back(byte);
}

void SimpleCodeGenerator::emitInt32(int32_t value) {
    for (int i = 0; i < 4; ++i) {
        emitByte(value & 0xFF);
        value >>= 8;
    }
}

void SimpleCodeGenerator::emitInt64(int64_t value) {
    for (int i = 0; i < 8; ++i) {
        emitByte(value & 0xFF);
        value >>= 8;
    }
}

void SimpleCodeGenerator::emitMovRaxImm64(int64_t value) {
    // mov rax, imm64
    emitByte(0x48);  // REX.W prefix
    emitByte(0xB8);  // mov rax, imm64
    emitInt64(value);
}

void SimpleCodeGenerator::emitAddRaxRbx() {
    // add rax, rbx
    emitByte(0x48);  // REX.W prefix
    emitByte(0x01);  // add
    emitByte(0xD8);  // rax, rbx
}

void SimpleCodeGenerator::emitMulRbx() {
    // mul rbx
    emitByte(0x48);  // REX.W prefix
    emitByte(0xF7);  // mul
    emitByte(0xE3);  // rbx
}

void SimpleCodeGenerator::emitRet() {
    // ret
    emitByte(0xC3);
}

void SimpleCodeGenerator::emitCall(void* target) {
    // call target
    emitByte(0xE8);  // call rel32
    int64_t offset = reinterpret_cast<int64_t>(target) - 
                    (reinterpret_cast<int64_t>(codeBuffer.data()) + codeBuffer.size() + 4);
    emitInt32(static_cast<int32_t>(offset));
}

void* SimpleCodeGenerator::generateAddFunction() {
    codeBuffer.clear();
    
    // Function that adds two numbers:
    // int add(int a, int b) { return a + b; }
    
    // mov rax, [rsp+8]  ; get first argument
    emitByte(0x48);
    emitByte(0x8B);
    emitByte(0x44);
    emitByte(0x24);
    emitByte(0x08);
    
    // add rax, [rsp+16] ; add second argument
    emitByte(0x48);
    emitByte(0x03);
    emitByte(0x44);
    emitByte(0x24);
    emitByte(0x10);
    
    emitRet();
    
    // Allocate memory and copy the generated code
    uint8_t* code = memoryManager.allocateCode(codeBuffer.size());
    if (!code) return nullptr;
    
    memcpy(code, codeBuffer.data(), codeBuffer.size());
    return code;
}

void* SimpleCodeGenerator::generateMultiplyFunction() {
    codeBuffer.clear();
    
    // Function that multiplies two numbers:
    // int multiply(int a, int b) { return a * b; }
    
    // mov rax, [rsp+8]  ; get first argument
    emitByte(0x48);
    emitByte(0x8B);
    emitByte(0x44);
    emitByte(0x24);
    emitByte(0x08);
    
    // mov rbx, [rsp+16] ; get second argument
    emitByte(0x48);
    emitByte(0x8B);
    emitByte(0x5C);
    emitByte(0x24);
    emitByte(0x10);
    
    emitMulRbx();
    emitRet();
    
    // Allocate memory and copy the generated code
    uint8_t* code = memoryManager.allocateCode(codeBuffer.size());
    if (!code) return nullptr;
    
    memcpy(code, codeBuffer.data(), codeBuffer.size());
    return code;
}

void* SimpleCodeGenerator::generateFunctionCall(const std::string& functionName) {
    codeBuffer.clear();
    
    // Look up the function address
    void* target = memoryManager.lookupSymbol(functionName);
    if (!target) return nullptr;
    
    // Generate a call to the function
    emitCall(target);
    emitRet();
    
    // Allocate memory and copy the generated code
    uint8_t* code = memoryManager.allocateCode(codeBuffer.size());
    if (!code) return nullptr;
    
    memcpy(code, codeBuffer.data(), codeBuffer.size());
    return code;
} 