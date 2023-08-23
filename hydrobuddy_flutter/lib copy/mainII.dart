import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final String ipAddress = "172.28.8.40";

  Future<void> sendRequest(String endpoint) async {
    try {
      final response = await http.get(Uri.http(ipAddress, endpoint));
      if (response.statusCode == 200) {
        print("Response from $endpoint: ${response.body}");
      } else {
        print("Error with $endpoint: ${response.body}");
      }
    } catch (e) {
      print("Error sending request to $endpoint: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ESP Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: const Text("Normal"),
              onPressed: () => sendRequest("/normal"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Turn Motor On"),
              onPressed: () => sendRequest("/on_motor"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              child: const Text("Turn Motor Off"),
              onPressed: () => sendRequest("/off_motor"),
            ),
          ],
        ),
      ),
    );
  }
}
