import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ControlPanel extends StatefulWidget {
  @override
  _ControlPanelState createState() => _ControlPanelState();
}

class _ControlPanelState extends State<ControlPanel> {
  // IP Address of your Arduino board
  final String baseUrl = 'http://172.28.8.40';

  // List of motor names
  final List<String> motorNames = ['Water', 'Vitamin B', 'Vitamin A'];

  // Function to control the motor based on motor number and action (on/off)
  Future<void> controlMotor(int motorNumber, String action) async {
    String endpoint = '/motor${motorNumber}_$action';
    try {
      final response = await http.get(Uri.parse(baseUrl + endpoint));
      if (response.statusCode == 200) {
        print('${motorNames[motorNumber]} turned $action successfully.');
      } else {
        print('Failed to turn $action ${motorNames[motorNumber]}.');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff96b9d0),
      appBar: AppBar(
        title: Text('Control Panel'),
        backgroundColor: Color(0xff96b9d0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: motorNames.asMap().entries.map((entry) {
            int index = entry.key;
            String motorName = entry.value;
            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    motorName,
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 100),
                      Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            controlMotor(index, 'on');
                          },
                          child: Text('+'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 122, 205, 125),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 150,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            controlMotor(index, 'off');
                          },
                          child: Text('OFF'),
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 235, 110, 101),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

void main() => runApp(MaterialApp(home: ControlPanel()));
