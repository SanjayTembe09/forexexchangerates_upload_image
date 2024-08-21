import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart'; 


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return 
 MaterialApp(
      title: 'Image Upload with Text Extraction',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ImageUploadScreen(),
    );
  }
}

class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState(); 

}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  String? _extractedText;

  Future<void> _pickImage() async {
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = pickedImage;
    });
    if (_imageFile != null) {
      await _extractTextFromImage(_imageFile!.path);
    }
  }

  Future<void> _extractTextFromImage(String imagePath) async {
    final textRecognizer = TextRecognizer();
    final inputImage = InputImage.fromFilePath(imagePath);
    final recognizedText = await textRecognizer.processImage(inputImage);

    String recognizedString = "";
    for (TextBlock block in recognizedText.blocks) {
      for (TextLine line in block.lines) {
        recognizedString += line.text + "\n";
      }
    }
    setState(() {
      _extractedText = recognizedString.trim();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload with Text Extraction'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (_imageFile != null)
              Image.file(File(_imageFile!.path), 
 width: 300, height: 300),
            SizedBox(height: 20),
            if (_extractedText != null)
              Text(
                "Extracted Text:\n$_extractedText",
                style: TextStyle(fontSize: 16.0),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick an Image'),
            ),
          ],
        ),
      ),
    );
  }
}