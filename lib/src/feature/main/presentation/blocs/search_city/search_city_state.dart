part of 'search_city_bloc.dart';

@immutable
sealed class SearchCityState {}

final class SearchCityInitial extends SearchCityState {}

final class SearchCityLoading extends SearchCityState {}

final class SearchCityLoaded extends SearchCityState {
  final List<CityEntity> cities;

  SearchCityLoaded({required this.cities});
}

final class SearchCityFailure extends SearchCityState {
  final String error;

  SearchCityFailure({required this.error});
}
