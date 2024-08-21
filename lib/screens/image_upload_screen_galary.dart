import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart'; 


class ImageUploadScreen extends StatefulWidget {
  @override
  _ImageUploadScreenState createState() => _ImageUploadScreenState();
}

class _ImageUploadScreenState extends State<ImageUploadScreen> {
  String? 
 _imageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final 
 fileBytes = await pickedFile.readAsBytes();
      final 
 imageData = base64Encode(fileBytes);

      const imageUrl = 'http://localhost/uploadpicture.php'; // Replace with your PHP script URL

      final response = await http.post(
        Uri.parse(imageUrl),
        body: {'image': imageData},
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      );

      if (response.statusCode == 200) {
        print('Image uploaded successfully!');
        setState(() {
          _imageUrl = imageUrl; // Update state with uploaded image URL (optional)
        });
      } else {
        print('Error uploading image: ${response.statusCode}');
      }
    }
  }

  // This method defines the UI for the screen
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
 [
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            // Display uploaded image (optional)
            if (_imageUrl != null)
              //Image.network(_imageUrl!),
              Image.network(
                  _imageUrl!,
                  width: 300,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                  /*if (error is ImageCodecException) {
                    // Handle image decoding errors
                    return const Center(
                      child: Text('Error decoding image'),
                    );
                  } else*/ if (error is HttpException) {
                    // Handle network-related errors
                    return const Center(
                      child: Text('Network error'),
                    );
                  } else if (error is FormatException) {
                    // Handle image format errors
                    return const Center(
                      child: Text('Invalid image format'),
                    );
                  } else {
                    // Handle other errors
                    return const Center(
                      child: Text(''),
                    );
                  }
                },
              )
          ],
        ),
      ),
    );
  }
}