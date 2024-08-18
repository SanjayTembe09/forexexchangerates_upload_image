import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;



class ImageUploadPage extends StatefulWidget {
  @override
  _ImageUploadPageState createState() => _ImageUploadPageState();
}

class _ImageUploadPageState extends State<ImageUploadPage> 
 {
  Uint8List? _imageBytes;
  //String? _imageUrl;

  Future<void> _pickImage() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      setState(() 
 {
        _imageBytes = result.files.first.bytes; 

      });
    }
  }

  Future<void> _uploadImage() async {
    if (_imageBytes == null) return;

    // Create a multipart request
    var request = http.MultipartRequest('POST', Uri.parse('localhost/uploads/freebird.jpg'));
    var pic = await http.MultipartFile.fromBytes('image', _imageBytes!, filename: 'image.jpg'); // Replace 'image.jpg' with desired filename
    request.files.add(pic);
    
    try {
      var streamedResponse = await request.send();
      var response = await http.Response.fromStream(streamedResponse); 


      if (response.statusCode 
 == 200) {
        // Image uploaded successfully
        print('Image uploaded successfully');
        // Handle success, e.g., show a success message
      } else {
        // Handle upload error
        print('Upload failed');
      }
    } catch (e) {
      // Handle exception
      print(e);
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
          children: [
            if (_imageBytes 
 != null) Image.memory(_imageBytes!),
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