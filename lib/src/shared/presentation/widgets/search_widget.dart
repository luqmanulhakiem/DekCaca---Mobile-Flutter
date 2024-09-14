import 'dart:async';

import 'package:dekcaca_app/src/feature/main/presentation/blocs/search_city/search_city_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  State<SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  Timer? _loader;
  var logger = Logger();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 5,
                offset: const Offset(0, 3))
          ]),
      child: TextFormField(
        onChanged: (val) {
          _onSearchChanged(val);
        },
        decoration: InputDecoration(
            hintText: "Cari Berdasarkan Nama Daerah",
            prefixIcon: const Icon(Icons.search),
            border: _outlinedInputStyle(),
            enabledBorder: _outlinedInputStyle(),
            errorBorder: _outlinedInputStyle(),
            focusedErrorBorder: _outlinedInputStyle(),
            focusedBorder: _outlinedInputStyle()),
      ),
    );
  }

  void _onSearchChanged(String val) {
    if (_loader?.isActive ?? false) _loader?.cancel();
    _loader = Timer(const Duration(milliseconds: 500), () {
      if (val.length > 3) {
        final bloc = context.read<SearchCityBloc>();
        bloc.add(SearchCityByName(keyword: val));
      }
    });
  }

  @override
  void dispose() {
    _loader?.cancel();
    super.dispose();
  }

  OutlineInputBorder _outlinedInputStyle() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: Colors.white),
    );
  }
}
