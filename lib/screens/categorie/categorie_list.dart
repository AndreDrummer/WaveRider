import 'package:flutter/material.dart';
import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/screens/categorie/functions.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/loading_page.dart';
import 'package:waverider/widgets/text_widgets.dart';
import 'package:waverider/utils/constantes.dart';

class CategorieList extends StatefulWidget {
  CategorieList({
    this.bloc,
    @required this.categorieType,
  });

  final CategorieBloc bloc;
  final CATEGORIE_TYPE categorieType;

  @override
  _CategorieListState createState() => _CategorieListState();
}

class _CategorieListState extends State<CategorieList> {
  @override
  Widget build(BuildContext context) {
    CategorieCommonFunctions categorieCommonFunctions = CategorieCommonFunctions(bloc: widget.bloc, categorieType: widget.categorieType);
    List<Post> list = categorieCommonFunctions.list();

    return RefreshIndicator(
      onRefresh: () async => _onRefresh,
      child: StreamBuilder<List<Post>>(
        stream: _listStream(),
        initialData: list,
        builder: (BuildContext context, AsyncSnapshot<List<Post>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          }

          if (snapshot.data.isEmpty) {
            return FutureBuilder<Object>(
              future: Future.delayed(Duration(seconds: 120)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return LoadingPage();
                }
                return Container(
                  alignment: Alignment.center,
                  child: Text('Nada encontrado'),
                );
              },
            );
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  categorieCommonFunctions.changeStackIndex(inc: true);
                  categorieCommonFunctions.changeCategorieIndexBeingDetailed(index);
                },
                child: Column(
                  children: [
                    FutureBuilder<String>(
                      future: widget.bloc.loadDestakImage(snapshot.data[index].lLinks.wpAttachment.first.href),
                      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return ImageHeader();
                        }
                        return ImageHeader(
                          src: snapshot.data,
                        );
                      },
                    ),
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

  Future<void> _onRefresh() {
    switch (widget.categorieType) {
      case CATEGORIE_TYPE.news:
        return widget.bloc.loadNews();
        break;
      default:
        return widget.bloc.loadEvents();
    }
  }

  Stream _listStream() {
    switch (widget.categorieType) {
      case CATEGORIE_TYPE.news:
        return widget.bloc.listNewsStream;
        break;
      default:
        return widget.bloc.listEventsStream;
    }
  }
}
