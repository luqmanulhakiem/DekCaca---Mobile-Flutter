part of 'list_weather_location_bloc.dart';

@immutable
sealed class ListWeatherLocationEvent {}

final class GetPredictionWeather extends ListWeatherLocationEvent {
  final double latitude;
  final double longitude;

  GetPredictionWeather({required this.latitude, required this.longitude});
}
