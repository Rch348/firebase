import 'package:flutter/material.dart';
import 'package:weather_api/models/weather_model.dart';
import 'package:weather_api/services/weather_service.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService = WeatherService(apiKey: 'a4e437d68d1bbf24f1aed');

  Weather? _weather;

  _fetchWeather() async {
    String cityName = await _weatherService.getCurrentCity();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  // Etat par défaut.
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(_weather?.cityName ?? 'en cours de chargement'),
          Text('${_weather?.temperature.round()}°c'),
          Text(_weather?.mainCondition ?? 'en cours de chargement'), 
        ],
      )
    );
  }
}
