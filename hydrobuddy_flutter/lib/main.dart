import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grafana in Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GrafanaIframeScreen(),
    );
  }
}

class GrafanaIframeScreen extends StatefulWidget {
  @override
  _GrafanaIframeScreenState createState() => _GrafanaIframeScreenState();
}

class _GrafanaIframeScreenState extends State<GrafanaIframeScreen> {
  late WebViewController controller;

  @override
  void initState() {
    super.initState();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.transparent)
      ..loadRequest(Uri.parse(
          "http://localhost:3000/d-solo/b38a5ce4-5268-443f-8dff-7757ae580b95/new-dashboard?orgId=1&from=1692666794066&to=1692688394066&panelId=1"));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Grafana in Flutter')),
      body: WebViewWidget(controller: controller),
    );
  }
}
