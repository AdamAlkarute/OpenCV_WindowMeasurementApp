README.md
OpenCV_WindowMeasurementApp
PainlessPrep App
A Flutter-based mobile application designed to capture images of windows, process them using a Python backend, and provide accurate size measurements.

🚀 Overview
PainlessPrep simplifies the process of measuring windows through image capture and backend processing. It uses Flutter for the frontend and Python Flask for the backend, with OpenCV for image analysis.

Key Features:

Real-time camera preview for image capture.
Backend integration for image analysis and processing.
Display processed image results within the app.
Clean and intuitive user interface.

🛠️ Tech Stack
Frontend (Flutter)
Language: Dart
Framework: Flutter
State Management: Stateful Widgets
Dependencies:
camera: For accessing device camera.
http: For communicating with the backend.
Backend (Python Flask)
Language: Python
Framework: Flask
Image Processing: OpenCV
Endpoint: /upload

📱 App Workflow
Main Page:
Welcome screen with a button to start camera functionality.
Camera Page:
Live camera preview.
Capture image and send it to the backend for processing.

Processing Backend:
Receives Base64-encoded images.
Processes them with OpenCV.
Returns the processed image in Base64 format.
Results Page:

Displays the processed image with measurement results.
📥 Installation
Prerequisites:
Flutter SDK installed (Installation Guide)
Python installed (Python Installation)
Backend dependencies installed (Flask, OpenCV)
Clone the Repository:
bash
Copy code
git clone https://github.com/your-username/OpenCV_WindowMeasurementApp.git
cd OpenCV_WindowMeasurementApp
Run the Backend:
bash
Copy code
cd backend
pip install -r requirements.txt
python app.py
Ensure the backend is running at http://192.168.56.1:5000.

Run the Frontend:
bash
Copy code
cd frontend
flutter pub get
flutter run

⚙️ Configuration
Update the backend URL in camera_page.dart:
dart
Copy code
const String baseUrl = 'http://192.168.56.1:5000';
Ensure your backend is accessible from the mobile device.

📂 Project Structure
less
Copy code
lib/
├── main.dart          // Entry point for the Flutter app
├── main_page.dart     // Main landing page
├── camera_page.dart   // Camera functionality
├── results_page.dart  // Display processed image results
├── api_service.dart   // API communication logic
assets/
└── logo.png           // App logo
backend/
├── server.py             // Flask backend logic
├── color_detector.py    //opencv backend
└── requirements.txt   // Backend dependencies

🧠 Key Learning Points
Integration of Flutter with Python Flask backend.
Real-time image capture and transmission.
Image processing with OpenCV.
Navigation and UI/UX design in Flutter.

🚀 Future Improvements
Dynamic backend configuration in-app.
Advanced image analysis features.
Deployment of backend on scalable cloud platforms.
Offline mode for image storage.

🤝 Contributing
We welcome contributions!
Fork the repository.
Create a feature branch: git checkout -b feature-branch-name.
Commit your changes: git commit -m "Add new feature".
Push to the branch: git push origin feature-branch-name.
Open a Pull Request.

🛡️ License
This project is licensed under the MIT License.

📞 Support
For support or feedback, reach out at:
adamalkarute14@gmail.com

Made with using Flutter, Flask, and OpenCV 🚀













