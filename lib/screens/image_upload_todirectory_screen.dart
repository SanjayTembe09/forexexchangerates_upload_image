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
  File? _image;

  Future<void> _pickImage() 
 async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      _image = pickedFile != null ? File(pickedFile.path) : null; 

    });
  }

  Future<void> 
 _uploadImage() async {
    if (_image == null) return;

    var request = http.MultipartRequest('POST', Uri.parse('http://localhost/upload.php'));
    request.files.add(await http.MultipartFile.fromPath('image', _image!.path));

    try {
      var response = await request.send();
      if (response.statusCode == 200) {
        var responseString = await response.stream.bytesToString();
        var 
 data = jsonDecode(responseString); 

        if (data['success'] != null) {
          // Handle successful upload
          print('Image uploaded successfully');
        } else {
          // Handle upload error
          print('Error uploading image: ${data['error']}');
        }
      } else {
        // Handle network error
        print('Error uploading image: Network error');
      }
    } catch (e) {
      // Handle general error
      print('Error uploading image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Upload'),
      ),
      body: Center(
        child: 
 Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
 [
            _image != null
                ? Image.file(_image!)
                : ElevatedButton(
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