import 'package:flutter/cupertino.dart';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/region.dart';
import 'package:waverider/services/region_service.dart';
import 'package:rxdart/rxdart.dart';

class RegionBloc with Bloc, ChangeNotifier {
  final RegionService _regionService = RegionService();
  final _regionList = BehaviorSubject<List<Region>>.seeded(List<Region>());
  final _indexStack = BehaviorSubject<int>.seeded(0);
  int _regionIndexBeingDetailed = 0;

  Stream<List<Region>> get regionList => _regionList.stream;
  Stream<int> get indexStack => _indexStack.stream;

  List<Region> get getRegionList => _regionList.value;
  int get regionIndexBeingDetailed => _regionIndexBeingDetailed;
  int get getIndexStack => _indexStack.value;

  void Function(int) get changeStackIndex => _indexStack.sink.add;

  void changeRegionIndexBeingDetailed(int index) {
    _regionIndexBeingDetailed = index;
    notifyListeners();
  }

  Future<void> loadRegions() async {
    _regionList.sink.add(await _regionService.getRegions());
  }

  @override
  void dispose() {
    _regionList.close();
    _indexStack.close();
    super.dispose();
  }
}
