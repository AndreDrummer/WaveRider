import 'dart:async';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/services/categories_services.dart';
import 'package:rxdart/rxdart.dart';

class EventsBloc implements Bloc {
  final CategoryService _categoryService = CategoryService();
  final _eventsList = BehaviorSubject<List<Post>>.seeded([]);
  final _indexStack = BehaviorSubject<int>.seeded(0);
  final _eventBeingDetailed = BehaviorSubject<int>.seeded(0);

  // Listening data
  Stream<List<Post>> get eventsListStream => _eventsList.stream;
  Stream<int> get indexStackStream => _indexStack.stream;
  Stream<int> get eventBeingDetailed => _eventBeingDetailed;

  // Obtaining the actual data
  List<Post> get getEventsList => _eventsList.value;

  void Function(int) get changeStackIndex => _indexStack.sink.add;
  void Function(int) get changeNewBeingDetailed => _eventBeingDetailed.sink.add;

  // loading data from API
  Future<void> getEvents() async {
    _eventsList.sink.add(await _categoryService.getEvents());
  }

  @override
  void dispose() {
    _eventsList.close();
    _indexStack.close();
    _eventBeingDetailed.close();
  }
}
