import 'package:flutter/material.dart';
import 'package:hydrobuddy/weather_service.dart';

class WeatherWidget extends StatefulWidget {
  const WeatherWidget({Key? key}) : super(key: key);

  @override
  _WeatherWidgetState createState() => _WeatherWidgetState();
}

class _WeatherWidgetState extends State<WeatherWidget> {
  String weatherMain = "Cebu city";
  String weatherTemp = "26°C";

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  _fetchWeatherData() async {
    try {
      final service = WeatherService();
      final weatherData = await service.getWeatherForCebuCity();
      setState(() {
        weatherMain = weatherData['weather'][0]['main'];
        weatherTemp = "${weatherData['main']['temp']}°C";
      });
    } catch (e) {
      print('Error fetching weather: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        color: Color(0xffbfd4db),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Icon(Icons.wb_sunny,
              size: 50.0,
              color: Colors
                  .white), // You can change the icon based on the weather data.
          SizedBox(width: 20.0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(weatherMain,
                  style: TextStyle(fontSize: 22.0, color: Colors.white)),
              Text(weatherTemp,
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
