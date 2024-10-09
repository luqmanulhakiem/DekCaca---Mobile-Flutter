import 'package:dekcaca_app/src/core/themes/app_color.dart';
import 'package:dekcaca_app/src/feature/detail/presentation/pages/detail_page.dart';
import 'package:dekcaca_app/src/feature/main/presentation/blocs/search_city/search_city_bloc.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/gap.dart';
import 'package:dekcaca_app/src/shared/presentation/widgets/search_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart' as getx;
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:logger/logger.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchWidget(),
            const Gap(gap: 30),
            const Text("Kota/Negara"),
            const Gap(gap: 20),
            BlocConsumer<SearchCityBloc, SearchCityState>(
                listener: (context, state) {
              if (state is SearchCityLoaded) {
                // setState(() {
                //   data = state.cities;
                // });
              }
            }, builder: (context, state) {
              if (state is SearchCityLoading) {
                return const CircularProgressIndicator();
              } else if (state is SearchCityFailure) {
                return const Center(
                  child: Text("ERR"),
                );
              } else if (state is SearchCityLoaded) {
                final data = state.cities;
                Logger().d("data kota: $data");
                return Column(
                  children: [
                    ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          if (data.isEmpty) {
                            return Center(
                              child: Text(
                                "Tidak ditemukan",
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            );
                          }
                          return _itemSearch(
                              data[index].cityName,
                              data[index].administrativeAreaName,
                              data[index].countryName,
                              data[index].latitude,
                              data[index].longitude);
                        }),
                  ],
                );
              } else {
                return Container(
                  child: const Center(
                    child: Text("Cari Berdasarkan daerah"),
                  ),
                );
              }
            })
          ],
        ),
      ),
    );
  }

  Widget _itemSearch(String namaKota, String provinsi, String negara,
      double latitude, double longitude) {
    return InkWell(
      onTap: () {
        getx.Get.to(
            DetailPage(
                title: namaKota, latitude: latitude, longitude: longitude),
            transition: getx.Transition.rightToLeft);
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        height: 70,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: const Offset(0, 3))
            ]),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              const Icon(
                Icons.location_city,
                color: AppColor.primary,
              ),
              const Gap(gap: 20),
              Expanded(
                child: Text(
                  "$namaKota, $provinsi - $negara",
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
