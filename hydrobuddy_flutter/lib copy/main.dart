import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grafanita',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const GrafanaIframeScreen(),
    );
  }
}

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
            MaterialPageRoute(builder: (context) => const BlankScreen()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Grafanita')),
        body: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            children: [
              const WeatherWidget(),
              const SizedBox(height: 20.0),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
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
              const SizedBox(height: 20.0),
              firstRow(),
              secondRow(),
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
            // Handle Journal button press
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
}

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Row(
        children: [
          Icon(Icons.wb_sunny, size: 50.0, color: Colors.white),
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sunny',
                  style: TextStyle(fontSize: 22.0, color: Colors.white)),
              Text('25°C',
                  style: TextStyle(
                      fontSize: 24.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}

class BlankScreen extends StatelessWidget {
  const BlankScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blank Screen"),
      ),
      body: const Center(
        child: Text("This is a blank screen."),
      ),
    );
  }
}

// Assuming you have the WebViewWidget defined elsewhere, or you can replace it with the actual WebView instance in the GridView.
