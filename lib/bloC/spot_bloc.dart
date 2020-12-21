import 'package:flutter/cupertino.dart';
import 'package:waverider/bloC/bloc.dart';
import 'package:waverider/models/spot.dart';
import 'package:rxdart/rxdart.dart';
import 'package:waverider/services/spot_service.dart';

class SpotBloc with Bloc, ChangeNotifier {
  final SpotService _spotService = SpotService();
  final _spotList = BehaviorSubject<List<Spot>>.seeded(List<Spot>());

  Stream<List<Spot>> get spotList => _spotList.stream;

  List<Spot> get getSpotList => _spotList.value;

  Future<void> getSpotsByRegionID(int regionID) async {
    _spotList.sink.add(await _spotService.loadSpotsByRegionID(regionID));
  }

  Future<String> loadDestakImage(String url) async {
    return await _spotService.loadDestakImage(url);
  }

  @override
  void dispose() {
    _spotList.close();
    super.dispose();
  }
}
