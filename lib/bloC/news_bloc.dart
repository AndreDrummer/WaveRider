import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/services/categories_services.dart';
import 'package:rxdart/rxdart.dart';

class NewsBloc with Bloc, ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  final _list = BehaviorSubject<List<Post>>.seeded([]);
  final _indexStack = BehaviorSubject<int>.seeded(0);

  // Listening data
  Stream<List<Post>> get listStream => _list.stream;
  Stream<int> get indexStackStream => _indexStack.stream;

  // Obtaining the actual data
  List<Post> get getList => _list.value;

  void Function(int) get changeStackIndex => _indexStack.sink.add;

  int _indexBeingDetailed = 0;
  void changeIndexBeingDetailed(int index) {
    _indexBeingDetailed = index;
    notifyListeners();
  }

  int get indexBeingDetailed => _indexBeingDetailed;

  // loading data from API
  Future<void> load() async {
    _list.sink.add(await _categoryService.getNews());
  }

  @override
  void dispose() {
    _list.close();
    _indexStack.close();
    super.dispose();
  }
}
