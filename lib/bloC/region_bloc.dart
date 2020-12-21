import 'package:flutter/cupertino.dart';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/region.dart';
import 'package:waverider/services/spots_regions_service.dart';
import 'package:rxdart/rxdart.dart';

class RegionBloc with Bloc, ChangeNotifier {
  final RegionService _regionService = RegionService();
  final _regionList = BehaviorSubject<List<Region>>.seeded(List<Region>());

  Stream<List<Region>> get regionList => _regionList.stream;
  List<Region> get getRegionList => _regionList.value;

  Future<void> loadRegions() async {
    _regionList.sink.add(await _regionService.getRegions());
  }

  @override
  void dispose() {
    _regionList.close();
    super.dispose();
  }
}
