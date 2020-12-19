import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/news_bloc.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/loading_page.dart';
import 'package:waverider/widgets/text_widgets.dart';

class NewDetail extends StatefulWidget {
  @override
  _NewDetailState createState() => _NewDetailState();
}

class _NewDetailState extends State<NewDetail> {
  NewsBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<NewsBloc>(context);
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
        stream: bloc.newBeingDetailed,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          }

          if (bloc.getNewsList.isEmpty) {
            return Container();
          }

          return ListView(
            children: [
              ImageHeader(
                isExpanded: true,
              ),
              SizedBox(height: 10),
              TextTitle(text: bloc.getNewsList[snapshot.data].title.rendered, fontSize: 18),
              TextResume(text: bloc.getNewsList[snapshot.data].content.rendered, fontSize: 14),
            ],
          );
        },
      ),
    );
  }
}
