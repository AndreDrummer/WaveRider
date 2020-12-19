import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/events_bloc.dart';
import 'package:waverider/bloC/news_bloc.dart';
import 'package:waverider/home.dart';

void main() {
  runApp(WaveRider());
}

class WaveRider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      bloc: NewsBloc(),
      child: BlocProvider<EventsBloc>(
        bloc: EventsBloc(),
        child: MaterialApp(
          title: 'WaveRider',
          theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          debugShowCheckedModeBanner: false,
          home: Home(title: 'WaveRider'),
        ),
      ),
    );
  }
}
