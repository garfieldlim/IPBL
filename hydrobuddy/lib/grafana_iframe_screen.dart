import 'package:flutter/material.dart';
import 'package:hydrobuddy/buddy.dart';
import 'package:hydrobuddy/journal_screen.dart';
import 'package:hydrobuddy/plant_id_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'weather_widget.dart';

class GrafanaIframeScreen extends StatefulWidget {
  const GrafanaIframeScreen({super.key});

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
            MaterialPageRoute(builder: (context) => const Buddy()),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                const WeatherWidget(),
                const SizedBox(height: 20.0),
                Container(
                  height: 400, // Adjust this to your preferred WebView height
                  child: PageView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return WebViewWidget(
                        controller: WebViewController()
                          ..setJavaScriptMode(JavaScriptMode.unrestricted)
                          ..setBackgroundColor(Colors.transparent)
                          ..loadRequest(Uri.parse(
                              "http://172.28.8.16:3000/d/b38a5ce4-5268-443f-8dff-7757ae580b95/new-dashboard?orgId=1&from=1692746734645&to=1692746934219&viewPanel=1"))
                          ..runJavaScript("""
                              var meta = document.createElement('meta');
                              meta.name = "viewport";                                 
                              meta.content = "initial-scale=0.1";
                              document.getElementsByTagName('head')[0].appendChild(meta);
                          """),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 20.0),
                firstRow(),
                secondRow(),
                thirdRow(),
              ],
            ),
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
              MaterialPageRoute(builder: (context) => const JournalScreen()),
            );
          },
          child: const Text('Journal'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle Control Panel button press
          },
          child: const Text('Control Panel'),
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
          child: const Text('Achievements'),
        ),
        ElevatedButton(
          onPressed: () {
            // Handle Language button press
          },
          child: const Text('Language'),
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
              MaterialPageRoute(builder: (context) => const PlantIDScreen()),
            );
          },
          child: const Text('WhatThePlant?!'),
        ),
      ],
    );
  }
}
