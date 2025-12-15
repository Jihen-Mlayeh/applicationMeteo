import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WeatherUtils {
  static String getWeatherIcon(String iconCode) {
    const iconMap = {
      '01d': '☀️', '01n': '🌙',
      '02d': '⛅', '02n': '☁️',
      '03d': '☁️', '03n': '☁️',
      '04d': '☁️', '04n': '☁️',
      '09d': '🌧️', '09n': '🌧️',
      '10d': '🌦️', '10n': '🌧️',
      '11d': '⛈️', '11n': '⛈️',
      '13d': '❄️', '13n': '❄️',
      '50d': '🌫️', '50n': '🌫️',
    };
    return iconMap[iconCode] ?? '☁️';
  }

  static Color getWeatherColor(String? weatherMain) {
    switch (weatherMain?.toLowerCase()) {
      case 'clear':
        return const Color(0xFF4A90E2);
      case 'clouds':
        return const Color(0xFF607D8B);
      case 'rain':
      case 'drizzle':
        return const Color(0xFF546E7A);
      case 'thunderstorm':
        return const Color(0xFF455A64);
      case 'snow':
        return const Color(0xFF78909C);
      case 'mist':
      case 'fog':
        return const Color(0xFF90A4AE);
      default:
        return const Color(0xFF5E35B1);
    }
  }

  static String formatTime(int timestamp) {
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('HH:mm').format(dateTime);
  }

  static String formatDate(DateTime date) {
    final dateFormat = DateFormat('EEEE, d MMMM', 'fr_FR');
    return dateFormat.format(date);
  }

  static String formatDay(DateTime date) {
    final dayFormat = DateFormat('EEE', 'fr_FR');
    return dayFormat.format(date);
  }

  static String formatVisibility(int visibilityInMeters) {
    return (visibilityInMeters / 1000).toStringAsFixed(1);
  }

  static String formatWindSpeed(double speed) {
    return speed.toStringAsFixed(1);
  }
}