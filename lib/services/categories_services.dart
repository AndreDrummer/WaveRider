import 'package:dio/dio.dart';
import 'package:waverider/utils/endpoints.dart';

class CategoryService {
  void getCategories() async {
    try {
      Response response = await Dio().get(Endpoints.listAllCategories);
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void getCategoriesByID(String categorieID) async {
    try {
      Response response = await Dio().get(Endpoints.listAllCategoriesByID(categorieID));
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void getPostByID(String postID) async {
    try {
      Response response = await Dio().get(Endpoints.getPostByID(postID));
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
