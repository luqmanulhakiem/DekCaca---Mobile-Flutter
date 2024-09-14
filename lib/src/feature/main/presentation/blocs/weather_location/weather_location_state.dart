part of 'weather_location_bloc.dart';

@immutable
sealed class WeatherLocationState {}

final class WeatherLocationInitial extends WeatherLocationState {}

final class WeatherLocationLoading extends WeatherLocationState {}

final class WeatherLocationLoaded extends WeatherLocationState {
  final Weather weather;

  WeatherLocationLoaded({required this.weather});
}

final class WeatherLocationFailure extends WeatherLocationState {}
