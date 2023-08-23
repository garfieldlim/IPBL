import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arduino Control',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: ArduinoControlPage(),
    );
  }
}

class ArduinoControlPage extends StatelessWidget {
  final String arduinoIp = '172.28.8.40';

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
        title: Text('Arduino Control'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () => sendRequest('/'),
              child: Text('Hello World'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendRequest('/led_on'),
              child: Text('Turn LED ON'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => sendRequest('/led_off'),
              child: Text('Turn LED OFF'),
            ),
          ],
        ),
      ),
    );
  }
}
