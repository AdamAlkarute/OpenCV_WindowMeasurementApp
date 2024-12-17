import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'results_page.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({Key? key}) : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  CameraController? _cameraController;
  late List<CameraDescription> cameras;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    cameras = await availableCameras();
    _cameraController = CameraController(cameras[0], ResolutionPreset.high);
    await _cameraController!.initialize();
    setState(() {
      _isCameraInitialized = true;
    });
  }

  @override
  void dispose() {
    _cameraController?.dispose();
    super.dispose();
  }

  Future<void> _captureAndUpload() async {
    if (!_isCameraInitialized) return;

    final XFile image = await _cameraController!.takePicture();
    final bytes = await image.readAsBytes();
    final base64Image = base64Encode(bytes);

    final url = Uri.parse('http://192.168.56.1:5000/upload');
    try {
      // Send the image to the backend
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData.containsKey('processed_image')) {
          // Decode the processed image
          final processedImageBytes =
              base64Decode(responseData['processed_image']);

          // Navigate to ResultsPage with the processed image
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ResultsPage(
                imageBytes: processedImageBytes,
              ),
            ),
          );
        } else {
          print('Processed image not found in response.');
        }
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Failed to upload and process image: $e');
    }
  }

  Future<Map<String, dynamic>?> _sendBase64Image(String base64Image) async {
    final url = Uri.parse('http://192.168.56.1:5000/upload');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Image}),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        print('Error: ${response.statusCode}, ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error sending image: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Capture Window Image')),
      body: _isCameraInitialized
          ? Stack(
              children: [
                CameraPreview(_cameraController!),
                Positioned(
                  bottom: 20,
                  left: 20,
                  right: 20,
                  child: ElevatedButton(
                    onPressed: _captureAndUpload,
                    child: const Text('Capture and Process'),
                  ),
                )
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
