import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/core/utils/date_parser.dart';
import 'package:dekcaca_app/src/core/utils/temp_parser.dart';
import 'package:dekcaca_app/src/feature/main/domain/utils/determine_location.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/list_weather_location/list_weather_location_bloc.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/weather_location/weather_location_bloc.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  double lat = 0;
  double long = 0;

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    final position = await determinePosition();
    setState(() {
      lat = position.latitude;
      long = position.longitude;
    });
  }

  @override
  Widget build(BuildContext context) {
    final blocCurrent = context.read<WeatherLocationBloc>();
    final blocPredict = context.read<ListWeatherLocationBloc>();
    blocCurrent.add(GetCurrentWeather(latitude: lat, longitude: long));
    blocPredict.add(GetPredictionWeather(latitude: lat, longitude: long));
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BlocBuilder<WeatherLocationBloc, WeatherLocationState>(
              builder: (context, state) {
            if (state is WeatherLocationLoading) {
              return _loadingCurrent();
            } else if (state is WeatherLocationFailure) {
              return const Text("ERR");
            } else if (state is WeatherLocationLoaded) {
              final data = state.weather;
              return Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    const Gap(gap: 20),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 6,
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${data.areaName},",
                                overflow: TextOverflow.clip,
                                style: GoogleFonts.poppins(
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800,
                                    height: 0),
                              ),
                              Text(
                                "${data.country == "ID" ? "Indonesia" : data.country}",
                                style: GoogleFonts.poppins(
                                    fontSize: 30,
                                    fontWeight: FontWeight.w800,
                                    height: 0),
                              ),
                              Text(
                                dateParses(data.date.toString(), 'date'),
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ],
                          ),
                        ),
                        // Flexible(flex: 1, child: Gap(gap: 10)),
                        // TODO: Nanti aktifkan kembali ini
                        // Flexible(
                        //   flex: 4,
                        //   child: Container(
                        //     height: 50,
                        //     width: 50,
                        //     child: FittedBox(
                        //         fit: BoxFit.fill,
                        //         clipBehavior: Clip.hardEdge,
                        //         child: Image.asset("assets/images/logosmk.png")),
                        //   ),
                        // )
                      ],
                    ),
                    // Section 2
                    const Gap(gap: 30),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColor.primary,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                              color: AppColor.primary.withOpacity(0.4),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(2, 3))
                        ],
                      ),
                      child: Column(
                        children: [
                          const Gap(gap: 30),
                          SizedBox(
                            height: 140,
                            width: 140,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              clipBehavior: Clip.hardEdge,
                              child: switch (data.weatherDescription) {
                                "langit cerah" =>
                                  SvgPicture.asset("assets/svgs/cerah.svg"),
                                _ => Image.network(
                                    "http://openweathermap.org/img/wn/${data.weatherIcon}@4x.png",
                                  )
                              },
                            ),
                          ),
                          const Gap(gap: 10),
                          Text(
                            "${data.weatherDescription}",
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.poppins(
                              color: AppColor.secondary,
                              fontSize: 26,
                              height: 0,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Gap(gap: 20),
                          Flex(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            direction: Axis.horizontal,
                            children: [
                              Flexible(
                                  flex: 4,
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        "Temp",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Gap(gap: 5),
                                      Text(
                                        "${tempParser(data.temperature.toString())}",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.secondary,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              Flexible(
                                  flex: 4,
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        "Kelembapan",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Gap(gap: 5),
                                      Text(
                                        "${data.humidity}",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.secondary,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              Flexible(
                                  flex: 4,
                                  child: Flex(
                                    direction: Axis.vertical,
                                    children: [
                                      Text(
                                        "Angin",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.secondary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const Gap(gap: 5),
                                      Text(
                                        "${data.windSpeed}",
                                        style: GoogleFonts.poppins(
                                            color: AppColor.secondary,
                                            fontSize: 22,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                            ],
                          ),
                          const Gap(gap: 30)
                        ],
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const SizedBox();
            }
          }),
          const Gap(gap: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              "Hari ini dan 5 hari kedepan",
              style: GoogleFonts.poppins(
                  fontSize: 20, fontWeight: FontWeight.w500),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<ListWeatherLocationBloc, ListWeatherLocationState>(
                    builder: (context, state) {
                  if (state is ListWeatherLocationLoading) {
                    return _loadingPrediction();
                  } else if (state is ListWeatherLocationFailure) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else if (state is ListWeatherLocationLoaded) {
                    final data = state.weathers;
                    return SizedBox(
                      height: 150,
                      child: Row(
                        children: [
                          Expanded(
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: data.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                      margin: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          color: AppColor.primary,
                                          borderRadius:
                                              BorderRadius.circular(16)),
                                      child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(children: [
                                            Text(
                                              dateParses(
                                                  data[index].date.toString(),
                                                  'time'),
                                              style: GoogleFonts.poppins(
                                                  color: AppColor.secondary,
                                                  fontSize: 16,
                                                  height: 0,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            const Gap(gap: 10),
                                            Container(
                                                height: 50,
                                                width: 50,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                child: data[index]
                                                            .weatherDescription ==
                                                        "langit cerah"
                                                    ? SvgPicture.asset(
                                                        "assets/svgs/cerah.svg")
                                                    : Image.network(
                                                        "http://openweathermap.org/img/wn/${data[index].weatherIcon}@4x.png")),
                                            const Gap(gap: 10),
                                            Text(
                                              tempParser(data[index]
                                                      .temperature
                                                      .toString())
                                                  .toString(),
                                              style: GoogleFonts.poppins(
                                                  color: AppColor.secondary,
                                                  fontSize: 16,
                                                  height: 0,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ])));
                                }),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
                const Gap(gap: 10),
              ],
            ),
          )
        ],
      ),
    );
  }

  Row _loadingPrediction() {
    return Row(
        children: List.generate(2, (index) {
      return Container(
        margin: const EdgeInsets.all(5),
        height: 130,
        width: 70,
        decoration: BoxDecoration(
            color: Colors.grey.shade300,
            borderRadius: BorderRadius.circular(16)),
      );
    }));
  }

  Column _loadingCurrent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 40,
                    width: 200,
                    color: Colors.grey.shade300,
                  ),
                  const Gap(gap: 10),
                  Container(
                    height: 40,
                    width: 180,
                    color: Colors.grey.shade300,
                  ),
                  const Gap(gap: 10),
                  Container(
                    height: 20,
                    width: 80,
                    color: Colors.grey.shade300,
                  ),
                  const Gap(gap: 10),
                ],
              )
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Container(
            height: 300,
            width: double.infinity,
            color: Colors.grey.shade300,
          ),
        ),
      ],
    );
  }
}
