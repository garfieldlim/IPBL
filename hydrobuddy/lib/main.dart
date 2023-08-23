import 'package:flutter/material.dart';
import 'package:hydrobuddy/screens/login.dart';
import 'screens/grafana_iframe_screen.dart';

class homepage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grafanita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
