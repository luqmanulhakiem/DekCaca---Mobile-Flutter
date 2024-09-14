import 'package:dekcaca_app/src/feature/main/data/repositories/current_weather_repository_impl.dart';
import 'package:dekcaca_app/src/feature/main/data/repositories/search_city_repository_impl.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/list_weather_location/list_weather_location_bloc.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/search_city/search_city_bloc.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/weather_location/weather_location_bloc.dart';
import 'package:dekcaca_app/src/feature/splash/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              WeatherLocationBloc(repository: CurrentWeatherRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) => ListWeatherLocationBloc(
              repository: CurrentWeatherRepositoryImpl()),
        ),
        BlocProvider(
          create: (context) =>
              SearchCityBloc(repository: SearchCityRepositoryImpl()),
        ),
      ],
      child: GetMaterialApp(
        title: 'DekCaca',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
