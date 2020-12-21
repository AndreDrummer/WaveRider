import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/services/categories_services.dart';
import 'package:rxdart/rxdart.dart';

class CategorieBloc with Bloc, ChangeNotifier {
  final CategoryService _categoryService = CategoryService();
  final _listNews = BehaviorSubject<List<Post>>.seeded([]);
  final _listEvents = BehaviorSubject<List<Post>>.seeded([]);
  final _indexStackNews = BehaviorSubject<int>.seeded(0);
  final _indexStackEvents = BehaviorSubject<int>.seeded(0);

  // Listening data
  Stream<List<Post>> get listNewsStream => _listNews.stream;
  Stream<List<Post>> get listEventsStream => _listEvents.stream;
  Stream<int> get indexStackNewsStream => _indexStackNews.stream;
  Stream<int> get indexStackEventsStream => _indexStackEvents.stream;

  // Obtaining the actual data
  List<Post> get getNewsList => _listNews.value;
  List<Post> get getEventsList => _listEvents.value;

  void Function(int) get changeStackIndexNews => _indexStackNews.sink.add;
  void Function(int) get changeStackIndexEvents => _indexStackEvents.sink.add;

  int _newsIndexBeingDetailed = 0;
  int _eventsIndexBeingDetailed = 0;

  void changeNewsIndexBeingDetailed(int index) {
    _newsIndexBeingDetailed = index;
    notifyListeners();
  }

  void changeEventsIndexBeingDetailed(int index) {
    _eventsIndexBeingDetailed = index;
    notifyListeners();
  }

  int get newsIndexBeingDetailed => _newsIndexBeingDetailed;
  int get eventsIndexBeingDetailed => _eventsIndexBeingDetailed;

  // loading data from API
  Future<void> loadNews() async {
    _listNews.sink.add(await _categoryService.getNews());
  }

  Future<void> loadEvents() async {
    _listEvents.sink.add(await _categoryService.getEvents());
  }

  @override
  void dispose() {
    _listNews.close();
    _listEvents.close();
    _indexStackNews.close();
    _indexStackEvents.close();
    super.dispose();
  }
}
