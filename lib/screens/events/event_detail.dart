import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/events_bloc.dart';
import 'package:waverider/utils/handle_api_string.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/loading_page.dart';
import 'package:waverider/widgets/text_widgets.dart';
import 'package:waverider/widgets/video.dart';

class EventDetail extends StatefulWidget {
  @override
  _EventDetailState createState() => _EventDetailState();
}

class _EventDetailState extends State<EventDetail> {
  EventsBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<EventsBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bloc.changeStackIndex(0);
        return false;
      },
      child: StreamBuilder<int>(
        stream: bloc.eventBeingDetailed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          }

          if (bloc.getEventsList.isEmpty) {
            return Container();
          }

          String content = bloc.getEventsList[snapshot.data].content.rendered;
          bool videoExist = HandleApiString.getVideoLink(content) != null;
          String videoTitle = videoExist ? HandleApiString.getVideoTitle(content) : null;
          return ListView(
            children: [
              ImageHeader(
                isExpanded: true,
              ),
              SizedBox(height: 10),
              TextTitle(text: bloc.getEventsList[snapshot.data].title.rendered, fontSize: 18),
              TextResume(text: bloc.getEventsList[snapshot.data].content.rendered, fontSize: 14),
              Container(
                margin: const EdgeInsets.all(20),
                child: videoExist
                    ? Column(
                        children: [
                          TextVideoTitle(text: videoTitle),
                          YouTubePlayer(
                            videoUrl: HandleApiString.getVideoLink(content),
                          ),
                        ],
                      )
                    : Text(''),
              )
            ],
          );
        },
      ),
    );
  }
}
