from flask import Flask, request, jsonify
import subprocess
import os

app = Flask(__name__)

# Directory where `.ll` files are stored
EXAMPLES_DIR = "/Users/debo/Desktop/purrsonal/CD-LLVM/examples"

@app.route('/run', methods=['POST'])
def run_file():
    data = request.json
    filename = data.get('filename')
    filepath = os.path.join(EXAMPLES_DIR, filename)

    if not os.path.exists(filepath):
        return jsonify({'error': f'File {filename} not found'}), 404

    try:
        # Execute LLVM IR files using `lli`
        result = subprocess.run(['lli', filepath], capture_output=True, text=True)
        output = result.stdout.strip() if result.returncode == 0 else result.stderr.strip()
        return jsonify({'output': output})
    except Exception as e:
        return jsonify({'error': str(e)}), 500

if __name__ == '__main__':
    app.run(debug=True)

