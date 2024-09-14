part of 'search_city_bloc.dart';

@immutable
sealed class SearchCityEvent {}

final class SearchCityByName extends SearchCityEvent {
  final String keyword;

  SearchCityByName({required this.keyword});
}
