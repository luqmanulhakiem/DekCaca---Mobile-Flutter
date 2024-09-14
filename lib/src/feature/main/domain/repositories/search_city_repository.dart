import 'package:dekcaca_app/src/feature/main/domain/entities/city_entity.dart';

abstract class SearchCityRepository {
  Future<List<CityEntity>> searchCity(String keyword);
}
