import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/core/utils/date_parser.dart';
import 'package:dekcaca_app/src/core/utils/temp_parser.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/list_weather_location/list_weather_location_bloc.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/weather_location/weather_location_bloc.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailPage extends StatelessWidget {
  final double latitude;
  final double longitude;
  final String title;
  const DetailPage(
      {super.key,
      required this.title,
      required this.latitude,
      required this.longitude});

  @override
  Widget build(BuildContext context) {
    final blocFuture = context.read<ListWeatherLocationBloc>();
    final blocCurrent = context.read<WeatherLocationBloc>();
    blocFuture
        .add(GetPredictionWeather(latitude: latitude, longitude: longitude));
    blocCurrent
        .add(GetCurrentWeather(latitude: latitude, longitude: longitude));
    return Scaffold(
      backgroundColor: AppColor.secondary,
      appBar: AppBar(
        toolbarHeight: kToolbarHeight + 20,
        backgroundColor: AppColor.primary,
        iconTheme: const IconThemeData(color: AppColor.secondary),
        title: Text(
          title,
          style: GoogleFonts.poppins(
            color: AppColor.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
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
                        // Section 2
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
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
                              const Gap(gap: 30),
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
                  "Perkiraan 5 hari",
                  style: GoogleFonts.poppins(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ),
              const Gap(gap: 10),
              // ignore: avoid_unnecessary_containers
              Container(
                child: BlocBuilder<ListWeatherLocationBloc,
                    ListWeatherLocationState>(builder: (context, state) {
                  if (state is ListWeatherLocationLoading) {
                    return const CircularProgressIndicator();
                  } else if (state is ListWeatherLocationLoaded) {
                    final data = state.weathers;
                    return ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (state, index) {
                          return Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              decoration: BoxDecoration(
                                color: AppColor.primary,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: AppColor.primary.withOpacity(0.4),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(2, 3))
                                ],
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          dateParses(
                                              data[index].date.toString(),
                                              "time"),
                                          style: GoogleFonts.poppins(
                                              color: AppColor.secondary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        Text(
                                          dateParses(
                                              data[index].date.toString(),
                                              "date"),
                                          style: GoogleFonts.poppins(
                                              color: AppColor.secondary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        SizedBox(
                                          height: 40,
                                          width: 40,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            clipBehavior: Clip.hardEdge,
                                            child: switch (data[index]
                                                .weatherDescription) {
                                              "langit cerah" =>
                                                SvgPicture.asset(
                                                    "assets/svgs/cerah.svg"),
                                              _ => Image.network(
                                                  "http://openweathermap.org/img/wn/${data[index].weatherIcon}@4x.png",
                                                )
                                            },
                                          ),
                                        ),
                                        Text(
                                          data[index]
                                              .weatherDescription
                                              .toString(),
                                          style: GoogleFonts.poppins(
                                              color: AppColor.secondary,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      "${tempParser(data[index].tempMin.toString())} - ${tempParser(data[index].tempMax.toString())}",
                                      style: GoogleFonts.poppins(
                                          color: AppColor.secondary,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        });
                  } else if (state is ListWeatherLocationFailure) {
                    return Center(
                      child: Text(state.error),
                    );
                  } else {
                    return const SizedBox();
                  }
                }),
              )
            ],
          ),
        ),
      ),
    );
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
