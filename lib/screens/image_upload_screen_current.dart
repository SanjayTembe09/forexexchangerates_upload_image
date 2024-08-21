import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class
 ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage>
 {
  File? _image;
  String? _imageUrl;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image 
 = File(pickedFile.path);
      });
    }
  }

  Future<void> _uploadImage() async {
    if (_image == null) return;

    var request = http.MultipartRequest('POST', Uri.parse('https://your-server.com/upload-image'));

    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    var response = await request.send();
    if (response.statusCode == 200) 
 {
      // Assuming the API returns the uploaded image URL
      var responseBody = await response.stream.bytesToString();
      var jsonData = jsonDecode(responseBody);
      setState(() {
        _imageUrl = jsonData['imageUrl']; // Replace with the actual JSON key
      });
    } else {
      // Handle error
      print('Image upload failed');
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
 [
            _imageUrl != null
                ? Image.network(_imageUrl!)
                : (_image != null
                    ? Image.file(_image!)
                    : Text('No image selected')),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Pick Image'),
            ),
            ElevatedButton(
              onPressed: _uploadImage,
              child: Text('Upload Image'),
            ),
          ],
        ),
      ),
    );
  }
}
