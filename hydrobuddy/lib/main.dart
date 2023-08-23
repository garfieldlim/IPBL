import 'package:flutter/material.dart';
import 'package:hydrobuddy/login.dart';
import 'package:hydrobuddy/mqttgrafana.dart';
import 'package:hydrobuddy/my_app.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
