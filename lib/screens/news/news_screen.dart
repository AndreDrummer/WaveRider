import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/news_bloc.dart';
import 'package:waverider/screens/news/new_detail.dart';
import 'package:waverider/screens/news/news_list.dart';

class NewsScreen extends StatelessWidget {
  final bloc = NewsBloc();

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsBloc>(
      bloc: bloc,
      child: StreamBuilder<int>(
        stream: bloc.indexStackStream,
        builder: (context, snapshot) {
          return IndexedStack(
            index: snapshot.data ?? 0,
            children: [
              NewsList(),
              NewDetail(),
            ],
          );
        },
      ),
    );
  }
}
