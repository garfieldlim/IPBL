import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arduino Control',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ArduinoControlPage(),
    );
  }
}

class ArduinoControlPage extends StatelessWidget {
  final String arduinoIp = '172.28.8.40';

  const ArduinoControlPage({super.key});

  Future<void> sendRequest(String endpoint) async {
    try {
      final response = await http.post(Uri.http(arduinoIp, endpoint));
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
    } catch (error) {
      print('Failed to send request: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arduino Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => sendRequest('/'),
              child: const Text('Hello World'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendRequest('/led_on'),
              child: const Text('Turn LED ON'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendRequest('/led_off'),
              child: const Text('Turn LED OFF'),
            ),
          ],
        ),
      ),
    );
  }
}
