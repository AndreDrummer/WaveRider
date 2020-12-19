import 'dart:async';
import 'package:rxdart/rxdart.dart';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/services/categories_services.dart';

class EventsBloc implements Bloc {
  EventsBloc() {
    this.getEvents();
  }

  final CategoryService _categoryService = CategoryService();
  List<Post> _events = List<Post>();
  final _eventsList = BehaviorSubject<List<Post>>();
  final _indexStack = BehaviorSubject<int>.seeded(0);

  // Listening data
  Stream<List<Post>> get eventsListStream => _eventsList.stream;
  Stream<int> get indexStackStream => _indexStack.stream;

  // Obtaining the actual data
  List<Post> get getEventsList => _events;

  // loading data from API
  Future<void> getEvents() async {
    _events = await _categoryService.getEvents();
    _eventsList.sink.add(_events);
  }

  @override
  void dispose() {
    _eventsList.close();
    _indexStack.close();
  }
}

EventsBloc bloc = EventsBloc();
