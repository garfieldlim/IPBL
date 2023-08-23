import 'package:flutter/material.dart';
import 'package:hydrobuddy_flutter/buddy.dart';
import 'package:hydrobuddy_flutter/journal_screen.dart';
import 'package:hydrobuddy_flutter/plant_id_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'buddy.dart';
import 'weather_widget.dart';

class GrafanaIframeScreen extends StatefulWidget {
  @override
  _GrafanaIframeScreenState createState() => _GrafanaIframeScreenState();
}

class _GrafanaIframeScreenState extends State<GrafanaIframeScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
          // User swiped to the left
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Buddy()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Grafanita')),
        body: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              WeatherWidget(),
              SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: List.generate(4, (index) {
                  // Assuming WebViewWidget is defined elsewhere
                  return WebViewWidget(
                    controller: WebViewController()
                      ..setJavaScriptMode(JavaScriptMode.unrestricted)
                      ..setBackgroundColor(Colors.transparent)
                      ..loadRequest(Uri.parse(
                          "http://localhost:3000/d/b38a5ce4-5268-443f-8dff-7757ae580b95/new-dashboard?orgId=1&from=1692669388086&to=1692755788086&viewPanel=${index + 1}&kiosk"))
                      ..runJavaScript("""
                          var meta = document.createElement('meta');
                          meta.name = "viewport";
                          meta.content = "initial-scale=0.1";
                          document.getElementsByTagName('head')[0].appendChild(meta);
                      """),
                  );
                }),
              ),
              SizedBox(height: 20.0),
              firstRow(),
              secondRow(),
              thirdRow(),
            ],
          ),
        ),
      ),
    );
  }

  Row firstRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => JournalScreen()),
            );
          },
          child: Text('Journal'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle Control Panel button press
          },
          child: Text('Control Panel'),
        ),
      ],
    );
  }

  Row secondRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            // Handle Achievements button press
          },
          child: Text('Achievements'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle Language button press
          },
          child: Text('Language'),
        ),
      ],
    );
  }

  Row thirdRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PlantIDScreen()),
            );
          },
          child: Text('WhatThePlant?!'),
        ),
      ],
    );
  }
}
