import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/home.dart';

void main() {
  runApp(WaveRider());
}

class WaveRider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<CategorieBloc>(
      bloc: CategorieBloc(),
      child: MaterialApp(
        title: 'WaveRider',
        theme: ThemeData(
          primarySwatch: Colors.purple,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: Home(title: 'WaveRider'),
      ),
    );
  }
}
