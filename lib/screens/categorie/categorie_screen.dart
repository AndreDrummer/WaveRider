import 'package:flutter/material.dart';
import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/screens/categorie/categorie_detail_screen.dart';
import 'package:waverider/screens/categorie/categorie_list_screen.dart';
import 'package:waverider/utils/constantes.dart';

class CategorieScreen extends StatefulWidget {
  CategorieScreen({
    this.bloc,
    @required this.categorieType,
  });

  final CategorieBloc bloc;
  final CATEGORIE_TYPE categorieType;

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  CategorieBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: _indexStackStream(),
      builder: (context, snapshot) {
        return IndexedStack(
          index: snapshot.data ?? 0,
          children: [
            CategorieListScreen(
              bloc: widget.bloc,
              categorieType: widget.categorieType,
            ),
            CategorieDetailScreen(
              bloc: widget.bloc,
              categorieType: widget.categorieType,
            ),
          ],
        );
      },
    );
  }

  Stream _indexStackStream() {
    Stream indexStackStream;
    switch (widget.categorieType) {
      case CATEGORIE_TYPE.news:
        indexStackStream = widget.bloc.indexStackNewsStream;
        break;
      case CATEGORIE_TYPE.events:
        indexStackStream = widget.bloc.indexStackEventsStream;
    }

    return indexStackStream;
  }
}
