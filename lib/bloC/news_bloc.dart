import 'dart:async';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/services/categories_services.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc implements Bloc {
  NewsBloc() {
    this.getNews();
  }

  final CategoryService _categoryService = CategoryService();
  List<Post> _news = List<Post>();
  final _newsList = BehaviorSubject<List<Post>>();
  final _indexStack = BehaviorSubject<int>.seeded(0);

  // Listening data
  Stream<List<Post>> get newsListStream => _newsList.stream;
  Stream<int> get indexStackStream => _indexStack.stream;

  // Obtaining the actual data
  List<Post> get getNewsList => _news;

  // loading data from API
  Future<void> getNews() async {
    _news = await _categoryService.getNews();
    _newsList.sink.add(_news);
  }

  @override
  void dispose() {
    _newsList.close();
    _indexStack.close();
  }
}

NewsBloc bloc = NewsBloc();
