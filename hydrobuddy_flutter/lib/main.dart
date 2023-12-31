import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MQTT Chart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MQTTGraphScreen(),
    );
  }
}

class MQTTGraphScreen extends StatefulWidget {
  @override
  _MQTTGraphScreenState createState() => _MQTTGraphScreenState();
}

class _MQTTGraphScreenState extends State<MQTTGraphScreen> {
  List<double> tdsDataPoints = [];
  List<double> wifiRssiDataPoints = [];
  List<double> waterLevelDataPoints = [];

  @override
  void initState() {
    super.initState();
    _connectToMQTT();
  }

  _connectToMQTT() async {
    final client = await setupMQTTClient();

    if (client.connectionStatus!.state == MqttConnectionState.connected) {
      print('MQTT client connected');

      client.updates!.listen((List<MqttReceivedMessage<MqttMessage>> messages) {
        final MqttPublishMessage message =
            messages[0].payload as MqttPublishMessage;
        final payload =
            MqttPublishPayload.bytesToStringAsString(message.payload.message!);

        final topic = messages[0].topic;

        switch (topic) {
          case 'tds_sensor/ppm':
            setState(() {
              tdsDataPoints.add(double.parse(payload));
            });
            print('Received data on $topic: $payload');
            break;
          case 'wi-fi/rssi':
            setState(() {
              wifiRssiDataPoints.add(double.parse(payload));
            });
            print('Received data on $topic: $payload');
            break;
          case 'water_sensor/level':
            setState(() {
              waterLevelDataPoints.add(double.parse(payload));
            });
            print('Received data on $topic: $payload');
            break;
          default:
            print("Unknown topic: $topic");
            break;
        }
      });

      client.subscribe('tds_sensor/ppm', MqttQos.exactlyOnce);
      client.subscribe('wi-fi/rssi', MqttQos.exactlyOnce);
      client.subscribe('water_sensor/level', MqttQos.exactlyOnce);
    } else {
      print('MQTT client connection failed - disconnecting');
      client.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('MQTT Data Graphs')),
      body: Column(
        children: <Widget>[
          Expanded(child: _buildChart(tdsDataPoints, 'TDS Sensor')),
          Expanded(child: _buildChart(wifiRssiDataPoints, 'Wi-Fi RSSI')),
          Expanded(child: _buildChart(waterLevelDataPoints, 'Water Level')),
        ],
      ),
    );
  }

  Widget _buildChart(List<double> dataPoints, String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(show: true),
          lineBarsData: [
            LineChartBarData(
              spots: dataPoints
                  .asMap()
                  .entries
                  .map((e) => FlSpot(e.key.toDouble(), e.value))
                  .toList(),
              isCurved: true,
              barWidth: 4,
              isStrokeCapRound: true,
            ),
          ],
        ),
      ),
    );
  }
}

Future<MqttServerClient> setupMQTTClient() async {
  final client =
      MqttServerClient('x09ef00e.ala.us-east-1.emqxsl.com', 'flutter_client');
  client.port = 8883;
  client.logging(on: true);
  client.secure = true;

  // Setting up security context
  SecurityContext securityContext = SecurityContext.defaultContext;
  securityContext.setTrustedCertificatesBytes("""-----BEGIN CERTIFICATE-----
MIIDrzCCApegAwIBAgIQCDvgVpBCRrGhdWrJWZHHSjANBgkqhkiG9w0BAQUFADBh
MQswCQYDVQQGEwJVUzEVMBMGA1UEChMMRGlnaUNlcnQgSW5jMRkwFwYDVQQLExB3
d3cuZGlnaWNlcnQuY29tMSAwHgYDVQQDExdEaWdpQ2VydCBHbG9iYWwgUm9vdCBD
QTAeFw0wNjExMTAwMDAwMDBaFw0zMTExMTAwMDAwMDBaMGExCzAJBgNVBAYTAlVT
MRUwEwYDVQQKEwxEaWdpQ2VydCBJbmMxGTAXBgNVBAsTEHd3dy5kaWdpY2VydC5j
b20xIDAeBgNVBAMTF0RpZ2lDZXJ0IEdsb2JhbCBSb290IENBMIIBIjANBgkqhkiG
9w0BAQEFAAOCAQ8AMIIBCgKCAQEA4jvhEXLeqKTTo1eqUKKPC3eQyaKl7hLOllsB
CSDMAZOnTjC3U/dDxGkAV53ijSLdhwZAAIEJzs4bg7/fzTtxRuLWZscFs3YnFo97
nh6Vfe63SKMI2tavegw5BmV/Sl0fvBf4q77uKNd0f3p4mVmFaG5cIzJLv07A6Fpt
43C/dxC//AH2hdmoRBBYMql1GNXRor5H4idq9Joz+EkIYIvUX7Q6hL+hqkpMfT7P
T19sdl6gSzeRntwi5m3OFBqOasv+zbMUZBfHWymeMr/y7vrTC0LUq7dBMtoM1O/4
gdW7jVg/tRvoSSiicNoxBN33shbyTApOB6jtSj1etX+jkMOvJwIDAQABo2MwYTAO
BgNVHQ8BAf8EBAMCAYYwDwYDVR0TAQH/BAUwAwEB/zAdBgNVHQ4EFgQUA95QNVbR
TLtm8KPiGxvDl7I90VUwHwYDVR0jBBgwFoAUA95QNVbRTLtm8KPiGxvDl7I90VUw
DQYJKoZIhvcNAQEFBQADggEBAMucN6pIExIK+t1EnE9SsPTfrgT1eXkIoyQY/Esr
hMAtudXH/vTBH1jLuG2cenTnmCmrEbXjcKChzUyImZOMkXDiqw8cvpOp/2PV5Adg
06O/nVsJ8dWO41P0jmP6P6fbtGbfYmbW0W5BjfIttep3Sp+dWOIrWcBAI+0tKIJF
PnlUkiaY4IBIqDfv8NZ5YBberOgOzW6sRBc4L0na4UU+Krk2U886UAb3LujEV0ls
YSEY1QSteDwsOoBrp+uvFRTp2InBuThs4pFsiv9kuXclVzDAGySj4dzp30d8tbQk
CAUw7C29C79Fv1C5qfPrmAESrciIxpg0X40KPMbp1ZWVbd4=
-----END CERTIFICATE-----"""
      .codeUnits);

  client.securityContext = securityContext;

  final connMessage = MqttConnectMessage()
      .withClientIdentifier('flutter_client')
      .startClean()
      .withWillQos(MqttQos.atLeastOnce);

  client.connectionMessage = connMessage;

  try {
    await client.connect('test', 'testing');
  } catch (e) {
    print('Exception: $e');
    client.disconnect();
  }

  if (client.connectionStatus!.state == MqttConnectionState.connected) {
    print('MQTT client connected');
  } else {
    print('MQTT client connection failed - disconnecting');
    client.disconnect();
  }

  return client;
}
