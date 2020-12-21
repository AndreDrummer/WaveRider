import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/screens/categorie/categorie_screen.dart';
import 'package:waverider/utils/constantes.dart';

class NewsScreen extends StatefulWidget {
  @override
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  CategorieBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<CategorieBloc>(context);
    bloc.loadNews();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CategorieScreen(
      categorieType: CATEGORIE_TYPE.news,
      bloc: bloc,
    );
  }
}
