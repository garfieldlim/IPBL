import 'package:flutter/material.dart';
import 'grafana_iframe_screen.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const GrafanaIframeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
