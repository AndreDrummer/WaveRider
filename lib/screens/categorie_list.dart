import 'package:flutter/material.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/loading_page.dart';
import 'package:waverider/widgets/text_widgets.dart';

class CategorieList extends StatefulWidget {
  CategorieList({
    this.bloc,
  });

  final bloc;

  @override
  _CategorieListState createState() => _CategorieListState();
}

class _CategorieListState extends State<CategorieList> {
  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async => widget.bloc.load(),
      child: StreamBuilder<List<Post>>(
        stream: widget.bloc.listStream,
        initialData: widget.bloc.getList,
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
                  widget.bloc.changeStackIndex(1);
                  widget.bloc.changeIndexBeingDetailed(index);
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
    );
  }

  @override
  void dispose() {
    widget.bloc.dispose();
    super.dispose();
  }
}
