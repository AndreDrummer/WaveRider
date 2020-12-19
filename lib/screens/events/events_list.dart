import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/events_bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/loading_page.dart';
import 'package:waverider/widgets/text_widgets.dart';

class EventsList extends StatefulWidget {
  @override
  _EventsListState createState() => _EventsListState();
}

class _EventsListState extends State<EventsList> {
  EventsBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<EventsBloc>(context);
    if (bloc.getEventsList.isEmpty) bloc.getEvents();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => bloc.getEvents(),
      child: BlocProvider<EventsBloc>(
        bloc: bloc,
        child: StreamBuilder<List<Post>>(
          stream: bloc.eventsListStream,
          initialData: bloc.getEventsList,
          builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return LoadingPage();
            }

            if (snapshot.data.isEmpty) {
              return Container(
                alignment: Alignment.center,
                child: Text('Nada encontrado'),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    bloc.changeStackIndex(1);
                  },
                  child: Column(
                    children: [
                      ImageHeader(),
                      TextTitle(text: snapshot.data[index].title.rendered),
                      TextResume(text: snapshot.data[index].excerpt.rendered),
                      Divider(),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }
}
