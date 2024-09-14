import 'package:dekcaca_app/src/core/utils/weather_key.dart';
import 'package:dekcaca_app/src/feature/main/domain/repositories/current_weather_repository.dart';
import 'package:weather/weather.dart';

class CurrentWeatherRepositoryImpl implements CurrentWeatherRepository {
  WeatherFactory wf =
      WeatherFactory(WeatherKey.openWeatherKey, language: Language.INDONESIAN);

  @override
  Future<Weather> getCurrentWeather(double latitude, double longitude) async {
    Weather weather = await wf.currentWeatherByLocation(latitude, longitude);
    return weather;
  }

  @override
  Future<List<Weather>> getPredictionWeather(
      double latitude, double longitude) async {
    List<Weather> weather =
        await wf.fiveDayForecastByLocation(latitude, longitude);
    return weather;
  }
}
