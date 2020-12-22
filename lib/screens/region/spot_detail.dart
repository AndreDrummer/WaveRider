import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/bloC/spot_bloc.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/text_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SpotDetail extends StatefulWidget {
  @override
  _SpotDetailState createState() => _SpotDetailState();
}

class _SpotDetailState extends State<SpotDetail> {
  RegionBloc regionBloc;
  SpotBloc spotBloc;

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      final marker = Marker(
        markerId: MarkerId(spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].id.toString()),
        position: LatLng(double.parse(spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].acf.lat), double.parse(spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].acf.lon)),
        infoWindow: InfoWindow(
          title: spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].title.rendered,
          snippet: spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].acf.subregion,
        ),
      );
      _markers[spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].title.rendered] = marker;
    });
  }

  @override
  void didChangeDependencies() {
    regionBloc = BlocProvider.of<RegionBloc>(context);
    spotBloc = BlocProvider.of<SpotBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (spotBloc.getSpotList.isEmpty) return Container();

    return ListView(
      children: [
        Container(
          height: height / 3,
          width: double.infinity,
          color: Colors.greenAccent,
          child: GoogleMap(
            zoomControlsEnabled: false,
            markers: _markers.values.toSet(),
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: LatLng(
                double.parse(spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].acf.lat),
                double.parse(spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].acf.lon),
              ),
              zoom: 18,
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          alignment: Alignment.centerLeft,
          child: TextTitle(
            text: spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].title.rendered,
            fontSize: 22,
          ),
        ),
        SizedBox(height: 15),
        FutureBuilder<String>(
          future: spotBloc.loadDestakImage(spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].lLinks.wpAttachment.first.href),
          builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return ImageHeader(
                isExpanded: true,
              );
            }
            return ImageHeader(
              isExpanded: true,
              src: snapshot.data,
            );
          },
        ),
        SizedBox(height: 15),
        TextResume(
          text: spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].content.rendered,
          fontSize: 16,
        )
      ],
    );
  }
}
