import 'dart:io';
import 'package:flutter/material.dart';

class ImageDisplayWidget extends StatelessWidget {
  final String? imageUrl;
  final File? imageFile;

  const ImageDisplayWidget({
    Key? key,
    this.imageUrl,
    this.imageFile,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return imageUrl != null
        ? Image.network(imageUrl!)
        : imageFile != null
            ? Image.file(imageFile!)
            : Container(); // Or a placeholder image
  }
}