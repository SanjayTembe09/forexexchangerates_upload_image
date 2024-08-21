import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'package:image_picker/image_picker.dart';
void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp( 

      title: 'Image Upload',
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
  String? 
 _imageUrl;

  void _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileBytes = await pickedFile.readAsBytes();
      final
 imageData = base64Encode(fileBytes); // Convert image data to base64

      const imageUrl = 'http://localhost/upload.php'; // Replace with your PHP script URL

      final response = await http.post(
        Uri.parse(imageUrl),
        body: {'image': imageData},
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
      } else {
        print('Error uploading image: ${response.statusCode}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
 <Widget>[
            if (_imageUrl != null)
              Image.network(_imageUrl!, 
 width: 300, height: 300),
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