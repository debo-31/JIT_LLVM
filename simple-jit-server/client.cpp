#include <iostream>
#include <string>
#include <cstring>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>

class SimpleJITClient {
public:
    SimpleJITClient(const std::string& host, int port) : host(host), port(port) {}

    bool connect() {
        // Create socket
        sock = socket(AF_INET, SOCK_STREAM, 0);
        if (sock < 0) {
            std::cerr << "Failed to create socket" << std::endl;
            return false;
        }

        // Set up server address
        struct sockaddr_in server_addr;
        server_addr.sin_family = AF_INET;
        server_addr.sin_port = htons(port);
        
        if (inet_pton(AF_INET, host.c_str(), &server_addr.sin_addr) <= 0) {
            std::cerr << "Invalid address" << std::endl;
            return false;
        }

        // Connect to server
        if (::connect(sock, (struct sockaddr*)&server_addr, sizeof(server_addr)) < 0) {
            std::cerr << "Connection failed" << std::endl;
            return false;
        }

        return true;
    }

    std::string sendRequest(const std::string& request) {
        if (send(sock, request.c_str(), request.length(), 0) < 0) {
            return "ERROR";
        }

        char buffer[1024] = {0};
        int valread = read(sock, buffer, 1024);
        if (valread <= 0) {
            return "ERROR";
        }

        return std::string(buffer, valread);
    }

    ~SimpleJITClient() {
        if (sock >= 0) {
            close(sock);
        }
    }

private:
    std::string host;
    int port;
    int sock = -1;
};

int main(int argc, char* argv[]) {
    if (argc != 3) {
        std::cerr << "Usage: " << argv[0] << " <host> <port>" << std::endl;
        return 1;
    }

    std::string host = argv[1];
    int port = std::stoi(argv[2]);

    SimpleJITClient client(host, port);
    
    if (!client.connect()) {
        return 1;
    }

    // Test ADD function
    std::cout << "Requesting ADD function..." << std::endl;
    std::string response = client.sendRequest("ADD");
    std::cout << "Response: " << response << std::endl;

    // Test MULTIPLY function
    std::cout << "Requesting MULTIPLY function..." << std::endl;
    response = client.sendRequest("MULTIPLY");
    std::cout << "Response: " << response << std::endl;

    return 0;
} 