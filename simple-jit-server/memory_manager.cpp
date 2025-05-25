#include "memory_manager.h"
#include <sys/mman.h>
#include <unistd.h>
#include <cstring>

SimpleMemoryManager::SimpleMemoryManager() {}

SimpleMemoryManager::~SimpleMemoryManager() {
    freePages();
}

uint8_t* SimpleMemoryManager::allocatePage() {
    // Allocate a page with read, write, and execute permissions
    void* page = mmap(nullptr, PAGE_SIZE, 
                      PROT_READ | PROT_WRITE | PROT_EXEC,
                      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    
    if (page == MAP_FAILED) {
        return nullptr;
    }
    
    return static_cast<uint8_t*>(page);
}

uint8_t* SimpleMemoryManager::allocateCode(size_t size) {
    // Calculate number of pages needed
    size_t numPages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
    
    // Allocate pages
    for (size_t i = 0; i < numPages; ++i) {
        uint8_t* page = allocatePage();
        if (!page) {
            // If allocation fails, free all previously allocated pages
            freePages();
            return nullptr;
        }
        codePages.push_back(page);
    }
    
    return codePages.empty() ? nullptr : codePages[0];
}

uint8_t* SimpleMemoryManager::allocateData(size_t size) {
    // Similar to allocateCode but for data
    size_t numPages = (size + PAGE_SIZE - 1) / PAGE_SIZE;
    
    for (size_t i = 0; i < numPages; ++i) {
        uint8_t* page = allocatePage();
        if (!page) {
            freePages();
            return nullptr;
        }
        dataPages.push_back(page);
    }
    
    return dataPages.empty() ? nullptr : dataPages[0];
}

void SimpleMemoryManager::registerSymbol(const std::string& name, void* address) {
    symbolTable[name] = address;
}

void* SimpleMemoryManager::lookupSymbol(const std::string& name) {
    auto it = symbolTable.find(name);
    return it != symbolTable.end() ? it->second : nullptr;
}

void SimpleMemoryManager::freePages() {
    // Free all code pages
    for (auto page : codePages) {
        munmap(page, PAGE_SIZE);
    }
    codePages.clear();
    
    // Free all data pages
    for (auto page : dataPages) {
        munmap(page, PAGE_SIZE);
    }
    dataPages.clear();
    
    // Clear symbol table
    symbolTable.clear();
} 