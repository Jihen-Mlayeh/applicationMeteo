import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../utils/weather_utils.dart';

class AdditionalInfoCard extends StatelessWidget {
  final WeatherData weather;

  const AdditionalInfoCard({
    Key? key,
    required this.weather,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final visibility = WeatherUtils.formatVisibility(weather.visibility);
    final windSpeed = WeatherUtils.formatWindSpeed(weather.windSpeed);
    final sunrise = WeatherUtils.formatTime(weather.sunrise);
    final sunset = WeatherUtils.formatTime(weather.sunset);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.25),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: Colors.white.withOpacity(0.3),
          width: 1.5,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.water_drop,
                  label: 'Humidité',
                  value: '${weather.humidity}%',
                ),
              ),
              Expanded(
                child: _InfoTile(
                  icon: Icons.air,
                  label: 'Vent',
                  value: '$windSpeed m/s',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.visibility,
                  label: 'Visibilité',
                  value: '$visibility km',
                ),
              ),
              Expanded(
                child: _InfoTile(
                  icon: Icons.compress,
                  label: 'Pression',
                  value: '${weather.pressure} hPa',
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _InfoTile(
                  icon: Icons.wb_sunny,
                  label: 'Lever',
                  value: sunrise,
                ),
              ),
              Expanded(
                child: _InfoTile(
                  icon: Icons.nightlight,
                  label: 'Coucher',
                  value: sunset,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white.withOpacity(0.8),
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}