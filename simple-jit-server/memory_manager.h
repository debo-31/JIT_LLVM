#pragma once
#include <cstdint>
#include <vector>
#include <unordered_map>
#include <string>

class SimpleMemoryManager {
public:
    SimpleMemoryManager();
    ~SimpleMemoryManager();

    // Allocate memory for code
    uint8_t* allocateCode(size_t size);
    
    // Allocate memory for data
    uint8_t* allocateData(size_t size);
    
    // Register a symbol (function or variable)
    void registerSymbol(const std::string& name, void* address);
    
    // Lookup a symbol
    void* lookupSymbol(const std::string& name);

private:
    // Memory pools for code and data
    std::vector<uint8_t*> codePages;
    std::vector<uint8_t*> dataPages;
    
    // Symbol table
    std::unordered_map<std::string, void*> symbolTable;
    
    // Page size (4KB)
    static const size_t PAGE_SIZE = 4096;
    
    // Allocate a new page
    uint8_t* allocatePage();
    
    // Free all allocated pages
    void freePages();
}; 