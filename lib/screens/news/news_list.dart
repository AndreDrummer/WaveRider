import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/news_bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/widgets/loading_page.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/text_widgets.dart';

class NewsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => bloc.getNews(),
      child: BlocProvider<NewsBloc>(
        bloc: bloc,
        child: StreamBuilder<List<Post>>(
          stream: bloc.newsListStream,
          initialData: bloc.getNewsList,
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
                  onTap: () {},
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
}