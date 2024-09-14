part of 'list_weather_location_bloc.dart';

@immutable
sealed class ListWeatherLocationState {}

final class ListWeatherLocationInitial extends ListWeatherLocationState {}

final class ListWeatherLocationLoading extends ListWeatherLocationState {}

final class ListWeatherLocationLoaded extends ListWeatherLocationState {
  final List<Weather> weathers;

  ListWeatherLocationLoaded({required this.weathers});
}

final class ListWeatherLocationFailure extends ListWeatherLocationState {
  final String error;

  ListWeatherLocationFailure({required this.error});
}
