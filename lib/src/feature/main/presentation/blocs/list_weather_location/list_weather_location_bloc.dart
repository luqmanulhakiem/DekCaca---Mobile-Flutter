import 'package:dekcaca_app/src/feature/main/data/repositories/current_weather_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/weather.dart';

part 'list_weather_location_event.dart';
part 'list_weather_location_state.dart';

class ListWeatherLocationBloc
    extends Bloc<ListWeatherLocationEvent, ListWeatherLocationState> {
  final CurrentWeatherRepositoryImpl repository;
  ListWeatherLocationBloc({required this.repository})
      : super(ListWeatherLocationInitial()) {
    on<GetPredictionWeather>((event, emit) async {
      emit(ListWeatherLocationLoading());
      try {
        final resp = await repository.getPredictionWeather(
            event.latitude, event.longitude);
        emit(ListWeatherLocationLoaded(weathers: resp));
      } catch (e) {
        emit(ListWeatherLocationFailure(error: e.toString()));
      }
    });
  }
}
