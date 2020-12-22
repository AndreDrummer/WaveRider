import 'package:flutter/cupertino.dart';
import 'package:waverider/bloC/bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waverider/models/spot.dart';

class MapsBloc with Bloc, ChangeNotifier {
  final _markers = BehaviorSubject<Map<String, Marker>>.seeded({});
  final _center = BehaviorSubject<LatLng>.seeded(LatLng(36.8977574, -27.8334449));

  Stream<Map<String, Marker>> get markers => _markers.stream;
  Stream<LatLng> get center => _center.stream;

  Map<String, Marker> get getMarkers => _markers.value;
  LatLng get getCenter => _center.value;

  void Function(Map<String, Marker>) get changeMarkers => _markers.sink.add;
  void Function(LatLng) get changeCenter => _center.sink.add;

  void changeMapSpotDetail(Spot spot) {
    changeCenter(
      LatLng(
        double.parse(spot.acf.lat),
        double.parse(spot.acf.lon),
      ),
    );

    final Map<String, Marker> tempMarkers = {};

    final marker = Marker(
      markerId: MarkerId(spot.id.toString()),
      position: LatLng(double.parse(spot.acf.lat), double.parse(spot.acf.lon)),
      infoWindow: InfoWindow(
        title: spot.title.rendered,
        snippet: spot.acf.subregion,
      ),
    );
    tempMarkers[spot.title.rendered] = marker;

    changeMarkers(tempMarkers);
  }

  @override
  void dispose() {
    _markers.close();
    _center.close();
    super.dispose();
  }
}
