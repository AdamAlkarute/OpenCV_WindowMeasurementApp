import 'dart:typed_data'; // For Uint8List
import 'package:flutter/material.dart';

class ResultsPage extends StatelessWidget {
  final Uint8List imageBytes;

  const ResultsPage({Key? key, required this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Processed Image')),
      body: Center(
        child: Image.memory(imageBytes),
      ),
    );
  }
}
