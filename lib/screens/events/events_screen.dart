import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/events_bloc.dart';
import 'package:waverider/screens/events/events_list.dart';
import 'package:waverider/screens/news/new_detail.dart';

class EventsScreen extends StatelessWidget {
  final bloc = EventsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventsBloc>(
      bloc: bloc,
      child: StreamBuilder<int>(
        stream: bloc.indexStackStream,
        builder: (context, snapshot) {
          return IndexedStack(
            index: snapshot.data ?? 0,
            children: [
              EventsList(),
              NewDetail(),
            ],
          );
        },
      ),
    );
  }
}
