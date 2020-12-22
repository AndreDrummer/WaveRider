import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/utils/constantes.dart';

class CategorieCommonFunctions {
  CategorieCommonFunctions({
    this.bloc,
    this.categorieType,
  });

  final CategorieBloc bloc;
  final CATEGORIE_TYPE categorieType;

  List<Post> list() {
    switch (categorieType) {
      case CATEGORIE_TYPE.news:
        return bloc.getNewsList;
        break;
      default:
        return bloc.getEventsList;
    }
  }

  void changeStackIndex({bool inc = false}) {
    switch (categorieType) {
      case CATEGORIE_TYPE.news:
        bloc.changeStackIndexNews(inc ? bloc.getIndexStackNews + 1 : bloc.getIndexStackNews - 1);
        break;
      default:
        bloc.changeStackIndexEvents(inc ? bloc.getIndexStackEvents + 1 : bloc.getIndexStackEvents - 1);
    }
  }

  void changeCategorieIndexBeingDetailed(int index) {
    switch (categorieType) {
      case CATEGORIE_TYPE.news:
        bloc.changeNewsIndexBeingDetailed(index);
        break;
      default:
        bloc.changeEventsIndexBeingDetailed(index);
    }
  }

  int getCategorieIndexBeingDetailed() {
    switch (categorieType) {
      case CATEGORIE_TYPE.news:
        return bloc.newsIndexBeingDetailed;
        break;
      default:
        return bloc.eventsIndexBeingDetailed;
    }
  }
}
