import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/screens/categorie/categorie_screen.dart';
import 'package:waverider/utils/constantes.dart';

class EventsScreen extends StatefulWidget {
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  CategorieBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<CategorieBloc>(context);
    bloc.loadEvents();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return CategorieScreen(
      bloc: bloc,
      categorieType: CATEGORIE_TYPE.events,
    );
  }
}
