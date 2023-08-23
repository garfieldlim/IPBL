import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ESP Controller',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
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
        title: Text('ESP Controller'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              child: Text("Normal"),
              onPressed: () => sendRequest("/normal"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Turn Motor On"),
              onPressed: () => sendRequest("/on_motor"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              child: Text("Turn Motor Off"),
              onPressed: () => sendRequest("/off_motor"),
            ),
          ],
        ),
      ),
    );
  }
}
