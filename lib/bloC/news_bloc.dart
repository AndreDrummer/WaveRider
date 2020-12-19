import 'dart:async';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/services/categories_services.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc implements Bloc {
  final CategoryService _categoryService = CategoryService();
  final _newsList = BehaviorSubject<List<Post>>.seeded([]);
  final _indexStack = BehaviorSubject<int>.seeded(0);

  // Listening data
  Stream<List<Post>> get newsListStream => _newsList.stream;
  Stream<int> get indexStackStream => _indexStack.stream;

  // Obtaining the actual data
  List<Post> get getNewsList => _newsList.value;

  void Function(int) get changeStackIndex => _indexStack.sink.add;

  // loading data from API
  Future<void> getNews() async {
    _newsList.sink.add(await _categoryService.getNews());
  }

  @override
  void dispose() {
    _newsList.close();
    _indexStack.close();
  }
}
