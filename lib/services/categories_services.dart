import 'package:dio/dio.dart';
import 'package:waverider/models/common.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/utils/endpoints.dart';
import 'package:waverider/utils/constantes.dart';

class CategoryService {
  Future<List<Post>> getNews() async {
    List<Post> news = List<Post>();
    try {
      Response response = await Dio().get(Endpoints.listAllPostsByCategorie(CATEGORIE_TYPE.news));

      if (response.data != null) {
        news = List<Post>.from(response.data.map((news) => Post.fromJson(news)));
      }
    } catch (e) {
      print(e);
    }
    return news;
  }

  Future<List<Post>> getEvents() async {
    List<Post> events = List<Post>();
    try {
      Response response = await Dio().get(Endpoints.listAllPostsByCategorie(CATEGORIE_TYPE.events));

      if (response.data != null) {
        events = List<Post>.from(response.data.map((events) => Post.fromJson(events)));
      }
    } catch (e) {
      print(e);
    }
    return events;
  }

  void getPostByID(String postID) async {
    try {
      // Response response = await Dio().get(Endpoints.getPostByID(postID));
    } catch (e) {
      print(e);
    }
  }

  Future<String> loadDestakImage(String url) async {
    List<DestakImageData> destakImageData = List<DestakImageData>();
    try {
      Response response = await Dio().get(url);
      if (response.data != null) {
        destakImageData = List<DestakImageData>.from(response.data.map((destakImageData) => DestakImageData.fromJson(destakImageData)));
      }
    } catch (e) {
      print(e);
    }
    return destakImageData.isEmpty ? null : destakImageData.first.guid.rendered;
  }
}
