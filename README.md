# CD-LLVM Playground

A web-based playground for C and LLVM code with live lexical and syntax analysis, AST visualization, and code execution.

## Features

- **Lexical Analysis:** Tokenizes C code and highlights all C token types (keywords, identifiers, constants, operators, etc.).
- **Syntax Analysis:** Builds and displays a collapsible, color-coded AST for C code, including functions, loops, conditionals, and more.
- **Live Analysis:** AST and tokens update as you type.
- **Run Code:** Execute C code in a sandboxed backend.
- **Beautiful UI:** Modern, responsive, and easy to use.

## Getting Started

### Prerequisites

- Python 3.x
- GCC (for C code execution)

### Setup

1. Clone the repository:
   ```sh
   git clone https://github.com/YOUR_USERNAME/CD-LLVM.git
   cd CD-LLVM
   ```

2. Install Python dependencies (if any):
   ```sh
   pip install -r requirements.txt
   ```

3. Start the servers:
   - In one terminal:
     ```sh
     cd examples
     python3 server.py
     ```
   - In another terminal:
     ```sh
     python3 web_playground_backend.py
     ```

4. Open your browser and go to [http://localhost:8000/](http://localhost:8000/)

## Project Structure

- `examples/` — Contains C examples, HTML playground, and server scripts.
- `web_playground_backend.py` — Backend for code execution.
- `README.md` — This file.

## License

MIT

---

## Screenshots

(Add screenshots of your playground UI here!) 