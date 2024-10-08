import 'package:dekcaca_app/src/core/utils/weather_key.dart';
import 'package:dekcaca_app/src/feature/main/data/repositories/search_city_repository_impl.dart';
import 'package:dekcaca_app/src/feature/main/domain/entities/city_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'search_city_event.dart';
part 'search_city_state.dart';

class SearchCityBloc extends Bloc<SearchCityEvent, SearchCityState> {
  final SearchCityRepositoryImpl repository;
  SearchCityBloc({required this.repository}) : super(SearchCityInitial()) {
    on<SearchCityByName>((event, emit) async {
      emit(SearchCityLoading());
      try {
        final resp = await repository.searchCity(
            event.keyword, WeatherKey.accuWeatherKey1);
        emit(SearchCityLoaded(cities: resp));
      } catch (e) {
        try {
          final resp = await repository.searchCity(
              event.keyword, WeatherKey.accuWeatherKey2);
          emit(SearchCityLoaded(cities: resp));
        } catch (e) {
          try {
            final resp = await repository.searchCity(
                event.keyword, WeatherKey.accuWeatherKey3);
            emit(SearchCityLoaded(cities: resp));
          } catch (e) {
            try {
              final resp = await repository.searchCity(
                  event.keyword, WeatherKey.accuWeatherKey4);
              emit(SearchCityLoaded(cities: resp));
            } catch (e) {
              try {
                final resp = await repository.searchCity(
                    event.keyword, WeatherKey.accuWeatherKey5);
                emit(SearchCityLoaded(cities: resp));
              } catch (e) {
                emit(SearchCityFailure(error: e.toString()));
              }
            }
          }
        }
      }
    });
  }
}
