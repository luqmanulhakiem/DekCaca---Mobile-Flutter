part of 'weather_location_bloc.dart';

@immutable
sealed class WeatherLocationEvent {}

final class GetCurrentWeather extends WeatherLocationEvent {
  final double latitude;
  final double longitude;

  GetCurrentWeather({required this.latitude, required this.longitude});
}
