// class CityEntity {
//   final String areaName;
//   final String cityName;
//   final String countryName;
//   final double latitude;
//   final double longitude;

//   CityEntity(
//       {required this.areaName,
//       required this.cityName,
//       required this.countryName,
//       required this.latitude,
//       required this.longitude});

//   Map<String, dynamic> toJson() {
//     return {
//       "AdministrativeArea": {
//         "LocalizedName": areaName,
//       },
//       'LocalizedName': cityName,
//       "Country": {
//         "LocalizedName": countryName,
//       },
//       'GeoPosition': {
//         'Latitude': latitude,
//         'Longitude': longitude,
//       },
//     };
//   }

//   factory CityEntity.fromJson(Map<String, dynamic> json) {
//     return CityEntity(
//         areaName: json['AdministrativeArea']['LocalizedName'],
//         cityName: json['LocalizedName'],
//         countryName: json['Country']['LocalizedName'],
//         latitude: json['GeoPosition']['latitude'],
//         longitude: json['GeoPosition']['longitude']);
//   }
// }

class CityEntity {
  final int version;
  final String key;
  final int rank;
  final String cityName;
  final String countryName;
  final String administrativeAreaName;
  final double latitude;
  final double longitude;
  final String timeZoneCode;
  final double elevationMetric;

  CityEntity({
    required this.version,
    required this.key,
    required this.rank,
    required this.cityName,
    required this.countryName,
    required this.administrativeAreaName,
    required this.latitude,
    required this.longitude,
    required this.timeZoneCode,
    required this.elevationMetric,
  });

  factory CityEntity.fromJson(Map<String, dynamic> json) {
    return CityEntity(
      version: json['Version'],
      key: json['Key'],
      rank: json['Rank'],
      cityName: json['LocalizedName'],
      countryName: json['Country']['LocalizedName'],
      administrativeAreaName: json['AdministrativeArea']['LocalizedName'],
      latitude: json['GeoPosition']['Latitude'],
      longitude: json['GeoPosition']['Longitude'],
      timeZoneCode: json['TimeZone']['Code'],
      elevationMetric: json['GeoPosition']['Elevation']['Metric']['Value'],
    );
  }
}
