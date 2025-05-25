cmake_minimum_required(VERSION 3.13.4)
project(CD-LLVM)

# C++ settings
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find LLVM package
find_package(LLVM REQUIRED CONFIG)
message(STATUS "Found LLVM ${LLVM_PACKAGE_VERSION}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

# LLVM settings
include_directories(${LLVM_INCLUDE_DIRS})
add_definitions(${LLVM_DEFINITIONS})

# Main JIT compiler executable
add_executable(jit_compiler
    lljit/JITD.cpp
    lljit/main.cpp)

target_link_libraries(jit_compiler LLVM)

# Optional test suite if Boost is available
find_package(Boost COMPONENTS unit_test_framework)
if(Boost_FOUND)
    add_executable(testsuite
        lljit/JITD.cpp
        lljit/testsuite.cpp)
    target_link_libraries(testsuite LLVM ${Boost_LIBRARIES})
    target_include_directories(testsuite PRIVATE ${Boost_INCLUDE_DIRS})
    message(STATUS "Building test suite with Boost ${Boost_VERSION}")
else()
    message(STATUS "Boost not found - test suite will not be built")
endif()

# Install targets
install(TARGETS jit_compiler
    RUNTIME DESTINATION bin)
if(Boost_FOUND)
    install(TARGETS testsuite
        RUNTIME DESTINATION bin)
endif()

# Copy examples to build directory
file(COPY ${CMAKE_SOURCE_DIR}/lljit/examples DESTINATION ${CMAKE_BINARY_DIR})

# Add custom target for Python setup
add_custom_target(python_setup
    COMMAND ${CMAKE_COMMAND} -E env PYTHONPATH=${CMAKE_SOURCE_DIR} 
            ${Python_EXECUTABLE} -m pip install -r requirements.txt
    COMMAND ${CMAKE_COMMAND} -E env PYTHONPATH=${CMAKE_SOURCE_DIR} 
            ${Python_EXECUTABLE} setup.py build_ext --inplace
    WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
    COMMENT "Setting up Python environment and building Cython extensions") 