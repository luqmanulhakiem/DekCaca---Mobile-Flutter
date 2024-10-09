import 'package:dekcaca_app/src/feature/main/data/repositories/current_weather_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';

part 'weather_location_event.dart';
part 'weather_location_state.dart';

class WeatherLocationBloc
    extends Bloc<WeatherLocationEvent, WeatherLocationState> {
  final CurrentWeatherRepositoryImpl repository;
  WeatherLocationBloc({required this.repository})
      : super(WeatherLocationInitial()) {
    on<GetCurrentWeather>((event, emit) async {
      emit(WeatherLocationLoading());
      try {
        final resp =
            await repository.getCurrentWeather(event.latitude, event.longitude);
        emit(WeatherLocationLoaded(weather: resp));
        await Future.delayed(const Duration(seconds: 5));
      } catch (e) {
        emit(WeatherLocationFailure(error: e.toString()));
      }
    });
  }
}
