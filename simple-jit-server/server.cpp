#include <iostream>
#include <string>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <unistd.h>
#include "memory_manager.h"
#include "code_generator.h"

using FunctionPtr = int (*)(int, int);

class SimpleJITServer {
public:
    SimpleJITServer(int port) : port(port) {
        std::cout << "Initializing JIT server..." << std::endl;
        memoryManager = std::make_unique<SimpleMemoryManager>();
        codeGenerator = std::make_unique<SimpleCodeGenerator>(*memoryManager);
        std::cout << "JIT server initialized successfully" << std::endl;
    }

    void run() {
        // Create socket
        int server_fd = socket(AF_INET, SOCK_STREAM, 0);
        if (server_fd < 0) {
            std::cerr << "Failed to create socket: " << strerror(errno) << std::endl;
            return;
        }
        std::cout << "Socket created successfully" << std::endl;

        // Set socket options
        int opt = 1;
        if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt))) {
            std::cerr << "Failed to set socket options: " << strerror(errno) << std::endl;
            return;
        }
        std::cout << "Socket options set successfully" << std::endl;

        // Bind socket
        struct sockaddr_in address;
        address.sin_family = AF_INET;
        address.sin_addr.s_addr = INADDR_ANY;
        address.sin_port = htons(port);

        if (bind(server_fd, (struct sockaddr*)&address, sizeof(address)) < 0) {
            std::cerr << "Failed to bind socket: " << strerror(errno) << std::endl;
            return;
        }
        std::cout << "Socket bound successfully" << std::endl;

        // Listen for connections
        if (listen(server_fd, 3) < 0) {
            std::cerr << "Failed to listen: " << strerror(errno) << std::endl;
            return;
        }

        std::cout << "Server listening on port " << port << std::endl;

        // Accept connections
        while (true) {
            std::cout << "Waiting for connection..." << std::endl;
            int client_fd = accept(server_fd, nullptr, nullptr);
            if (client_fd < 0) {
                std::cerr << "Failed to accept connection: " << strerror(errno) << std::endl;
                continue;
            }
            std::cout << "New connection accepted" << std::endl;

            handleClient(client_fd);
            close(client_fd);
            std::cout << "Connection closed" << std::endl;
        }
    }

private:
    void handleClient(int client_fd) {
        char buffer[1024] = {0};
        int valread = read(client_fd, buffer, 1024);
        
        if (valread <= 0) {
            std::cerr << "Failed to read from client: " << strerror(errno) << std::endl;
            return;
        }

        std::string request(buffer);
        std::cout << "Received request: " << request << std::endl;
        
        // Simple protocol: "ADD" or "MULTIPLY"
        if (request == "ADD") {
            std::cout << "Generating ADD function..." << std::endl;
            void* addFunc = codeGenerator->generateAddFunction();
            if (addFunc) {
                std::cout << "ADD function generated successfully" << std::endl;
                memoryManager->registerSymbol("add", addFunc);
                if (send(client_fd, "OK", 2, 0) < 0) {
                    std::cerr << "Failed to send response: " << strerror(errno) << std::endl;
                }
            } else {
                std::cerr << "Failed to generate ADD function" << std::endl;
                if (send(client_fd, "ERROR", 5, 0) < 0) {
                    std::cerr << "Failed to send error response: " << strerror(errno) << std::endl;
                }
            }
        }
        else if (request == "MULTIPLY") {
            std::cout << "Generating MULTIPLY function..." << std::endl;
            void* mulFunc = codeGenerator->generateMultiplyFunction();
            if (mulFunc) {
                std::cout << "MULTIPLY function generated successfully" << std::endl;
                memoryManager->registerSymbol("multiply", mulFunc);
                if (send(client_fd, "OK", 2, 0) < 0) {
                    std::cerr << "Failed to send response: " << strerror(errno) << std::endl;
                }
            } else {
                std::cerr << "Failed to generate MULTIPLY function" << std::endl;
                if (send(client_fd, "ERROR", 5, 0) < 0) {
                    std::cerr << "Failed to send error response: " << strerror(errno) << std::endl;
                }
            }
        }
        else {
            std::cout << "Unknown request received" << std::endl;
            if (send(client_fd, "UNKNOWN", 7, 0) < 0) {
                std::cerr << "Failed to send unknown response: " << strerror(errno) << std::endl;
            }
        }
    }

    int port;
    std::unique_ptr<SimpleMemoryManager> memoryManager;
    std::unique_ptr<SimpleCodeGenerator> codeGenerator;
};

int main(int argc, char* argv[]) {
    if (argc != 2) {
        std::cerr << "Usage: " << argv[0] << " <port>" << std::endl;
        return 1;
    }

    int port = std::stoi(argv[1]);
    SimpleJITServer server(port);
    server.run();
    return 0;
} 