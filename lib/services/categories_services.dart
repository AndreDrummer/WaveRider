import 'package:dio/dio.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/utils/endpoints.dart';

class CategoryService {
  Future<List<Post>> getNews() async {
    List<Post> news = List<Post>();
    try {
      Response response = await Dio().get(Endpoints.listAllPostsByCategorie('news'));
      print(response);

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
      Response response = await Dio().get(Endpoints.listAllPostsByCategorie('events'));
      print(response);

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
      Response response = await Dio().get(Endpoints.getPostByID(postID));
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
