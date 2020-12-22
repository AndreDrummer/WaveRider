import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/maps_bloc.dart';

class Maps extends StatefulWidget {
  const Maps({
    this.zoom = 11.0,
  });
  final double zoom;

  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  MapsBloc mapsBloc;
  @override
  void didChangeDependencies() {
    mapsBloc = BlocProvider.of<MapsBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      zoomControlsEnabled: false,
      markers: mapsBloc.getMarkers.values.toSet(),
      onMapCreated: (GoogleMapController controller) {},
      initialCameraPosition: CameraPosition(
        target: mapsBloc.getCenter,
        zoom: widget.zoom,
      ),
    );
  }
}
