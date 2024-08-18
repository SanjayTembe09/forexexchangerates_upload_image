import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Image Display'),
        ),
        body: Center(
          child: Image.asset('assets/images/dollarrate.jpg'),
        ),
      ),
    ),
  );
}