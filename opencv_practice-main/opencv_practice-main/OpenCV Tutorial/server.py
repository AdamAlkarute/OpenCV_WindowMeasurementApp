from flask import Flask, request, jsonify
from flask_cors import CORS
from PIL import Image
import io
import base64
import os
import subprocess  
import logging

app = Flask("Measurement Server")
CORS(app)  

@app.route('/')
def hello_world():
    return 'Hello World!'

@app.route('/upload', methods=['POST'])
def upload_file():
    if not request.is_json:
        return jsonify({'error': 'Invalid input format, expecting JSON'}), 400

    data = request.get_json()
    if 'image' not in data:
        return jsonify({'error': 'No image provided'}), 400

    try:
        # Save the input image
        image_data = base64.b64decode(data['image'])
        image = Image.open(io.BytesIO(image_data))
        uploads_dir = os.path.join(os.getcwd(), 'uploads')
        os.makedirs(uploads_dir, exist_ok=True)
        input_image_path = os.path.join(uploads_dir, 'input_image.png')
        output_image_path = os.path.join(uploads_dir, 'output_image.png')
        image.save(input_image_path)

        # Run color_detector.py with properly quoted paths
        command = [
            'python',
            'color_detector.py',
            '--input', input_image_path,
            '--output', output_image_path
        ]
        subprocess.run(command, check=True)

        # Read the processed image
        with open(output_image_path, "rb") as f:
            processed_image_data = base64.b64encode(f.read()).decode('utf-8')

        return jsonify({
            'processed_image': processed_image_data
        })

    except Exception as e:
        return jsonify({'error': str(e)}), 500


if __name__ == '__main__':
    logging.basicConfig(level=logging.DEBUG)
    app.run(host='0.0.0.0', port=5000, debug=True)

