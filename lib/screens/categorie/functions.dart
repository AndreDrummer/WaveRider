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

  void changeStackIndex(int index) {
    switch (categorieType) {
      case CATEGORIE_TYPE.news:
        bloc.changeStackIndexNews(index);
        break;
      default:
        bloc.changeStackIndexEvents(index);
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
