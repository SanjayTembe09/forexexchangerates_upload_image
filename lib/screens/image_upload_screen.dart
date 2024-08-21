import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart'; 


class ImageFetcher extends StatefulWidget {
  @override
  _ImageFetcherState createState() => _ImageFetcherState();
}

class _ImageFetcherState extends State<ImageFetcher> {
  File? _image;

  Future<void> _fetchImage() async {
    final imageUrl = 'https://img.freepik.com/premium-photo/currency-exchange-rates-board_795320-1401.jpg?w=900'; // Replace with the actual image URL

    final response = await http.get(Uri.parse(imageUrl));
    if (response.statusCode == 200) {
      final bytes = response.bodyBytes;
      final directory = await getApplicationDocumentsDirectory(); 

      final file = File('${directory.path}/foreign_exchange_rate.png');
      await file.writeAsBytes(bytes);
      setState(() {
        _image = file;
      });
    } else {
      // Handle error
      print('Error fetching image: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: 
 Text('Image Fetcher'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: 
 [
            if (_image != null) Image.file(_image!),
            ElevatedButton(
              onPressed: 
 _fetchImage,
              child: Text('Fetch Image'),
            ),
          ],
        ),
      ),
    );
  }
}