import 'package:weather/weather.dart';

class WeatherCurrentEntity {
  final String areaName;
  final String country;
  final String weatherMain;
  final String weatherDescription;
  final String weatherIcon;
  final Temperature temperature;
  final double latitude;
  final double longitude;
  final double windSpeed;

  WeatherCurrentEntity(
      {required this.areaName,
      required this.country,
      required this.weatherMain,
      required this.weatherDescription,
      required this.weatherIcon,
      required this.temperature,
      required this.latitude,
      required this.longitude,
      required this.windSpeed});

  Map<String, dynamic> toJson() {
    return {
      'areaName': areaName,
      'country': country,
      'weatherMain': weatherMain,
      'weatherDescription': weatherDescription,
      'weatherIcon': weatherIcon,
      'temperature': temperature,
      'latitude': latitude,
      'longitude': longitude,
      'windSpeed': windSpeed,
    };
  }

  factory WeatherCurrentEntity.fromJson(Map<String, dynamic> json) {
    return WeatherCurrentEntity(
      areaName: json['areaName'],
      country: json['country'],
      weatherMain: json['weatherMain'],
      weatherDescription: json['weatherDescription'],
      weatherIcon: json['weatherIcon'],
      temperature: json['temperature'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      windSpeed: json['windSpeed'],
    );
  }
}
