import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherService {
  final String _endpoint = "https://api.openweathermap.org/data/2.5/weather";
  final String _apiKey =
      "df70d6953e55809d199dac8e797757ce"; // Your OpenWeatherMap API key

  Future<Map<String, dynamic>> getWeatherForCebuCity() async {
    final response = await http
        .get(Uri.parse("$_endpoint?q=Cebu City&units=metric&appid=$_apiKey"));

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
