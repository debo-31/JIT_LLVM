cmake_minimum_required(VERSION 3.10)
project(SimpleJITServer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(jit_server
    server.cpp
    memory_manager.cpp
    code_generator.cpp
)

add_executable(jit_client
    client.cpp
)

target_include_directories(jit_server PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(jit_client PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}) 