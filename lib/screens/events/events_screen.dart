import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/events_bloc.dart';
import 'package:waverider/screens/events/event_detail.dart';
import 'package:waverider/screens/events/events_list.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  EventsBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<EventsBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: bloc.indexStackStream,
      builder: (context, snapshot) {
        print('index ${snapshot.data}');
        return IndexedStack(
          index: snapshot.data ?? 0,
          children: [
            EventsList(),
            EventDetail(),
          ],
        );
      },
    );
  }
}
