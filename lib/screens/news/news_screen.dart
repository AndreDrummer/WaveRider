import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/news_bloc.dart';
import 'package:waverider/screens/news/new_detail.dart';
import 'package:waverider/screens/news/news_list.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  NewsBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<NewsBloc>(context);
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
            NewsList(),
            NewDetail(),
          ],
        );
      },
    );
  }
}
