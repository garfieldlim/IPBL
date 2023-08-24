import 'package:flutter/material.dart';

class SwitchScreen extends StatefulWidget {
  @override
  _SwitchScreenState createState() => _SwitchScreenState();
}

class _SwitchScreenState extends State<SwitchScreen> {
  List<bool> switchValues = [false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Control Panel'),
        backgroundColor: Color(0xffbfd4db),
      ),
      backgroundColor: Color(0xff96b9d0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Switch ${index + 1}"),
                  Switch(
                    value: switchValues[index],
                    onChanged: (value) {
                      setState(() {
                        switchValues[index] = value;
                      });
                    },
                  ),
                ],
              ),
            );
          }),
        ),
      ),
    );
  }
}
