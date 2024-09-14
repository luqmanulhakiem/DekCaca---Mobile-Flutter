import 'package:weather/weather.dart';

abstract class CurrentWeatherRepository {
  Future<Weather> getCurrentWeather(double latitude, double longitude);
  Future<List<Weather>> getPredictionWeather(double latitude, double longitude);
}
