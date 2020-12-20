import 'package:flutter/material.dart';
import 'package:waverider/screens/categorie_detail.dart';
import 'package:waverider/screens/categorie_list.dart';

class CategorieScreen extends StatefulWidget {
  CategorieScreen({
    this.bloc,
  });

  final bloc;

  @override
  _CategorieScreenState createState() => _CategorieScreenState();
}

class _CategorieScreenState extends State<CategorieScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: widget.bloc.indexStackStream,
      builder: (context, snapshot) {
        return IndexedStack(
          index: snapshot.data ?? 0,
          children: [
            CategorieList(
              bloc: widget.bloc,
            ),
            CategorieDetail(
              bloc: widget.bloc,
            ),
          ],
        );
      },
    );
  }
}
