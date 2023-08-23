import 'package:flutter/material.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class PlantIDScreen extends StatefulWidget {
  @override
  _PlantIDScreenState createState() => _PlantIDScreenState();
}

class _PlantIDScreenState extends State<PlantIDScreen> {
  ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;

  Future<void> pickImage() async {
    final pickedImage = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _selectedImage = pickedImage;
      });
      // Here, you can send the image to your backend and then to Plant.ID.
      // For this example, we'll just display the image.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WhatThePlant?!')),
      body: Center(
        child: _selectedImage == null
            ? Text('No image selected.')
            : Image.file(File(_selectedImage!.path)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: Icon(Icons.add_a_photo),
      ),
    );
  }
}
