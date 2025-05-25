from fastapi import FastAPI, Form
from fastapi.responses import HTMLResponse, PlainTextResponse
from fastapi.middleware.cors import CORSMiddleware
import subprocess
import os
import uuid

app = FastAPI()

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

EXAMPLES_DIR = "lljit/examples"

@app.post("/run_c_code")
async def run_c_code(code: str = Form(...), filename: str = Form("userprog")):
    # Save code to a temporary .c file
    base = os.path.join(EXAMPLES_DIR, f"{filename}_{uuid.uuid4().hex[:8]}")
    c_file = f"{base}.c"
    ll_file = f"{base}.ll"
    with open(c_file, "w") as f:
        f.write(code)
    # Compile to LLVM IR
    compile_cmd = ["clang", "-S", "-emit-llvm", "-o", ll_file, c_file]
    try:
        compile_proc = subprocess.run(compile_cmd, capture_output=True, text=True, timeout=10)
        if compile_proc.returncode != 0:
            os.remove(c_file)
            return PlainTextResponse(f"Compilation error:\n{compile_proc.stderr}", status_code=400)
    except Exception as e:
        os.remove(c_file)
        return PlainTextResponse(f"Compilation failed: {e}", status_code=500)
    # Run with JIT
    run_cmd = ["./build/jit_compiler", ll_file]
    try:
        run_proc = subprocess.run(run_cmd, capture_output=True, text=True, timeout=10, input="")
        output = run_proc.stdout + run_proc.stderr
    except Exception as e:
        output = f"Execution failed: {e}"
    # Clean up
    os.remove(c_file)
    if os.path.exists(ll_file):
        os.remove(ll_file)
    return PlainTextResponse(output)