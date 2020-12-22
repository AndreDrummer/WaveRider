import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/bloC/maps_bloc.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/home.dart';

import 'bloC/spot_bloc.dart';

void main() {
  runApp(WaveRider());
}

class WaveRider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegionBloc regionBloc = RegionBloc();
    regionBloc.loadRegions();

    return BlocProvider<CategorieBloc>(
      bloc: CategorieBloc(),
      child: BlocProvider<RegionBloc>(
        bloc: regionBloc,
        child: BlocProvider<SpotBloc>(
          bloc: SpotBloc(),
          child: BlocProvider<MapsBloc>(
            bloc: MapsBloc(),
            child: MaterialApp(
              title: 'WaveRider',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                visualDensity: VisualDensity.adaptivePlatformDensity,
              ),
              debugShowCheckedModeBanner: false,
              home: Home(title: 'WaveRider'),
            ),
          ),
        ),
      ),
    );
  }
}
