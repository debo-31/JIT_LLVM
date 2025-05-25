#pragma once
#include <cstdint>
#include <vector>
#include <string>
#include "memory_manager.h"

class SimpleCodeGenerator {
public:
    SimpleCodeGenerator(SimpleMemoryManager& memoryManager);
    
    // Generate a simple function that adds two integers
    void* generateAddFunction();
    
    // Generate a simple function that multiplies two integers
    void* generateMultiplyFunction();
    
    // Generate a function that calls another function
    void* generateFunctionCall(const std::string& functionName);

private:
    SimpleMemoryManager& memoryManager;
    std::vector<uint8_t> codeBuffer;
    
    // Helper functions for x86-64 code generation
    void emitByte(uint8_t byte);
    void emitInt32(int32_t value);
    void emitInt64(int64_t value);
    
    // x86-64 instruction encodings
    void emitMovRaxImm64(int64_t value);
    void emitAddRaxRbx();
    void emitMulRbx();
    void emitRet();
    void emitCall(void* target);
}; 