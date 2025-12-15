import 'package:flutter/material.dart';
import '../models/weather_model.dart';
import '../services/weather_service.dart';
import '../utils/weather_utils.dart';
import '../widgets/search_section.dart';
import '../widgets/current_weather_card.dart';
import '../widgets/additional_info_card.dart';
import '../widgets/forecast_section.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen>
    with TickerProviderStateMixin {
  final TextEditingController _cityController = TextEditingController();
  final WeatherService _weatherService = WeatherService(
    apiKey: '1cbc26da32a056f48d45319ffd6bdc95',
  );

  WeatherData? _currentWeather;
  List<ForecastData> _forecast = [];
  bool _isLoading = false;
  String? _errorMessage;

  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;
  AnimationController? _slideController;
  Animation<Offset>? _slideAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _loadDefaultCity();
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );
    _fadeAnimation = CurvedAnimation(
      parent: _fadeController,
      curve: Curves.easeInOut,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController!,
      curve: Curves.easeOutCubic,
    ));
  }

  void _loadDefaultCity() {
    _cityController.text = 'Paris';
    _fetchWeather('Paris');
  }

  @override
  void dispose() {
    _cityController.dispose();
    _fadeController.dispose();
    _slideController?.dispose();
    super.dispose();
  }

  Future<void> _fetchWeather(String city) async {
    if (city.isEmpty) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final result = await _weatherService.getWeatherAndForecast(city);

      setState(() {
        _currentWeather = result['weather'] as WeatherData;
        _forecast = result['forecast'] as List<ForecastData>;
        _isLoading = false;
      });

      _fadeController.forward(from: 0);
      _slideController?.forward(from: 0);
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Color get _weatherColor {
    return _currentWeather != null
        ? WeatherUtils.getWeatherColor(_currentWeather!.weatherMain)
        : const Color(0xFF5E35B1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              _weatherColor,
              _weatherColor.withOpacity(0.7),
              Colors.white,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              SearchSection(
                controller: _cityController,
                onSearch: _fetchWeather,
              ),
              Expanded(
                child: _buildContent(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (_errorMessage != null) {
      return _buildErrorState();
    }

    if (_currentWeather != null) {
      return _buildWeatherContent();
    }

    return const Center(
      child: Text(
        'Recherchez une ville',
        style: TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _buildErrorState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.error_outline,
              color: Colors.white,
              size: 64,
            ),
            const SizedBox(height: 20),
            Text(
              _errorMessage!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => _fetchWeather(_cityController.text),
              icon: const Icon(Icons.refresh),
              label: const Text('Réessayer'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: _weatherColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            CurrentWeatherCard(weather: _currentWeather!),
            const SizedBox(height: 15),
            AdditionalInfoCard(weather: _currentWeather!),
            const SizedBox(height: 20),
            ForecastSection(
              forecasts: _forecast,
              slideAnimation: _slideAnimation,
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}