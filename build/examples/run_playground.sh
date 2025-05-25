#!/bin/bash

# 1. Kill any process using port 8001
echo "Killing any process using port 8001..."
PID=$(lsof -ti :8001)
if [ ! -z "$PID" ]; then
  kill $PID
  echo "Killed process $PID"
fi

# 2. Start FastAPI backend in the background
echo "Starting FastAPI backend on port 8001..."
uvicorn lljit.web_playground_backend:app --reload --port 8001 &

# Wait a few seconds for the server to start
sleep 3

# 3. Open the web playground in the default browser
echo "Opening web playground in browser..."
open lljit/examples/web_playground.html

# 4. Test backend with a minimal C program
echo "Testing backend with a minimal C program..."
curl -F 'code=#include <stdio.h>
int jitentry() { printf("hi\\n"); return 0; }' -F "filename=test" http://127.0.0.1:8001/run_c_code

echo "If you see 'hi' above, everything is working!"
echo "Now use the web playground in your browser."