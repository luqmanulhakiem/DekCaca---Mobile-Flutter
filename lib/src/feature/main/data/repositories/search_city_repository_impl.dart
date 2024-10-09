import 'package:dekcaca_app/src/feature/main/domain/entities/city_entity.dart';
import 'package:dekcaca_app/src/feature/main/domain/repositories/search_city_repository.dart';
import 'package:dio/dio.dart';

class SearchCityRepositoryImpl implements SearchCityRepository {
  final _dio = Dio();
  @override
  Future<List<CityEntity>> searchCity(String keyword, String key) async {
    final resp = await _dio.get(
        "http://dataservice.accuweather.com/locations/v1/search?apikey=$key&q=$keyword");

    List<CityEntity> cities =
        (resp.data as List).map((json) => CityEntity.fromJson(json)).toList();
    return cities;
  }
}
