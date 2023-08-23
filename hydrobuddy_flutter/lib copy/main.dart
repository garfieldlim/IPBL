import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Grafanita',
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onHorizontalDragEnd: (DragEndDetails details) {
        if (details.primaryVelocity != null && details.primaryVelocity! < 0) {
          // User swiped to the left
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => BlankScreen()),
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
}

class WeatherWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Colors.blueAccent,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Blank Screen"),
      ),
      body: Center(
        child: Text("This is a blank screen."),
      ),
    );
  }
}

// Assuming you have the WebViewWidget defined elsewhere, or you can replace it with the actual WebView instance in the GridView.
