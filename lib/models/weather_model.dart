class WeatherData {
  final String cityName;
  final String country;
  final double temperature;
  final double feelsLike;
  final int humidity;
  final double windSpeed;
  final int visibility;
  final int pressure;
  final int sunrise;
  final int sunset;
  final String description;
  final String iconCode;
  final String weatherMain;

  WeatherData({
    required this.cityName,
    required this.country,
    required this.temperature,
    required this.feelsLike,
    required this.humidity,
    required this.windSpeed,
    required this.visibility,
    required this.pressure,
    required this.sunrise,
    required this.sunset,
    required this.description,
    required this.iconCode,
    required this.weatherMain,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      cityName: json['name'],
      country: json['sys']['country'],
      temperature: json['main']['temp'].toDouble(),
      feelsLike: json['main']['feels_like'].toDouble(),
      humidity: json['main']['humidity'],
      windSpeed: json['wind']['speed'].toDouble(),
      visibility: json['visibility'],
      pressure: json['main']['pressure'],
      sunrise: json['sys']['sunrise'],
      sunset: json['sys']['sunset'],
      description: json['weather'][0]['description'],
      iconCode: json['weather'][0]['icon'],
      weatherMain: json['weather'][0]['main'],
    );
  }
}

class ForecastData {
  final DateTime dateTime;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String iconCode;
  final String description;

  ForecastData({
    required this.dateTime,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.iconCode,
    required this.description,
  });

  factory ForecastData.fromJson(Map<String, dynamic> json) {
    return ForecastData(
      dateTime: DateTime.parse(json['dt_txt']),
      temperature: json['main']['temp'].toDouble(),
      tempMin: json['main']['temp_min'].toDouble(),
      tempMax: json['main']['temp_max'].toDouble(),
      iconCode: json['weather'][0]['icon'],
      description: json['weather'][0]['description'],
    );
  }
}