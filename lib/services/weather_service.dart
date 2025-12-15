import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather_model.dart';

class WeatherService {
  final String apiKey;
  static const String baseUrl = 'https://api.openweathermap.org/data/2.5';

  WeatherService({required this.apiKey});

  Future<WeatherData> getCurrentWeather(String city) async {
    final url = '$baseUrl/weather?q=$city&appid=$apiKey&units=metric&lang=fr';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return WeatherData.fromJson(data);
    } else if (response.statusCode == 401) {
      throw Exception('Clé API invalide');
    } else if (response.statusCode == 404) {
      throw Exception('Ville non trouvée');
    } else {
      throw Exception('Erreur ${response.statusCode}');
    }
  }

  Future<List<ForecastData>> getForecast(String city, {int days = 4}) async {
    final url = '$baseUrl/forecast?q=$city&appid=$apiKey&units=metric&lang=fr';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<dynamic> forecastList = data['list'];

      List<ForecastData> dailyForecast = [];
      Map<String, dynamic> dayMap = {};

      for (var item in forecastList) {
        String date = item['dt_txt'].split(' ')[0];
        if (!dayMap.containsKey(date) && dailyForecast.length < days) {
          dayMap[date] = item;
          dailyForecast.add(ForecastData.fromJson(item));
        }
      }

      return dailyForecast;
    } else {
      throw Exception('Erreur lors de la récupération des prévisions');
    }
  }

  Future<Map<String, dynamic>> getWeatherAndForecast(String city) async {
    try {
      final weather = await getCurrentWeather(city);
      final forecast = await getForecast(city);

      return {
        'weather': weather,
        'forecast': forecast,
      };
    } catch (e) {
      rethrow;
    }
  }
}