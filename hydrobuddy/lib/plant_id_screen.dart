import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;

class PlantIDScreen extends StatefulWidget {
  const PlantIDScreen({Key? key}) : super(key: key);

  @override
  _PlantIDScreenState createState() => _PlantIDScreenState();
}

class _PlantIDScreenState extends State<PlantIDScreen> {
  final ImagePicker _picker = ImagePicker();
  XFile? _selectedImage;
  String? plantName;

  Future<void> pickImage() async {
    try {
      final pickedImage = await _picker.pickImage(
          source: ImageSource.gallery, maxWidth: 1024, maxHeight: 1024);

      if (pickedImage != null) {
        setState(() {
          _selectedImage = pickedImage;
        });
        identifyPlant(File(_selectedImage!.path));
      }
    } catch (e) {
      print('Error picking the image: $e');
    }
  }

  Future<void> identifyPlant(File imageFile) async {
    try {
      final uri = Uri.parse('http://127.0.0.1:5000/identify');

      final request = http.MultipartRequest('POST', uri)
        ..files.add(await http.MultipartFile.fromPath('image', imageFile.path));

      final response = await request.send();

      if (response.statusCode == 200) {
        final result = await response.stream.bytesToString();
        final data = json.decode(result);

        setState(() {
          plantName = data['plant_name'];
        });
      } else {
        // Handle the error.
        print('Error identifying the plant.');
      }
    } catch (e) {
      print('Error sending image for identification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('WhatThePlant?!')),
      body: Center(
        child: _selectedImage == null
            ? const Text('No image selected.')
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.file(File(_selectedImage!.path)),
                  if (plantName != null)
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Identified as: $plantName',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: pickImage,
        child: const Icon(Icons.add_a_photo),
      ),
    );
  }
}
