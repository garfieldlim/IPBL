import 'package:flutter/material.dart';
import 'grafana_iframe_screen.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grafanita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GrafanaIframeScreen(),
    );
  }
}
