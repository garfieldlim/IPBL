import 'package:flutter/material.dart';
import 'package:hydrobuddy/mainiiiii.dart';
import 'package:hydrobuddy/my_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GrafanaIframeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
