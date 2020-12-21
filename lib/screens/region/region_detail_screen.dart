import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/bloC/spot_bloc.dart';
import 'package:waverider/utils/handle_api_string.dart';
import 'package:waverider/widgets/beach_tile.dart';
import 'package:waverider/widgets/text_widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RegionDetail extends StatefulWidget {
  @override
  _RegionDetailState createState() => _RegionDetailState();
}

class _RegionDetailState extends State<RegionDetail> {
  RegionBloc regionBloc;
  SpotBloc spotBloc;
  GoogleMapController mapController;

  final Map<String, Marker> _markers = {};
  Future<void> _onMapCreated(GoogleMapController controller) async {
    setState(() {
      _markers.clear();
      for (final spot in spotBloc.getSpotList) {
        final marker = Marker(
          markerId: MarkerId(spot.id.toString()),
          position: LatLng(double.parse(spot.acf.lat), double.parse(spot.acf.lon)),
          infoWindow: InfoWindow(
            title: spot.title.rendered,
            snippet: spot.title.rendered,
          ),
        );
        _markers[spot.title.rendered] = marker;
      }
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
    if (regionBloc.getRegionList.isEmpty) return Container();

    return WillPopScope(
      onWillPop: () async {
        regionBloc.changeStackIndex(0);
        return false;
      },
      child: spotBloc.getSpotList.isEmpty
          ? _emptyScreen()
          : Column(
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
                        double.parse(spotBloc.getSpotList.first.acf.lat),
                        double.parse(spotBloc.getSpotList.first.acf.lon),
                      ),
                      zoom: 11.7,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  alignment: Alignment.centerLeft,
                  child: TextTitle(
                    text: regionBloc.getRegionList[regionBloc.regionIndexBeingDetailed].name,
                    fontSize: 22,
                  ),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: ListView.builder(
                    itemCount: spotBloc.getSpotList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return BeachTile(
                        loadImage: spotBloc.loadDestakImage(spotBloc.getSpotList[index].lLinks.wpAttachment.first.href),
                        beachName: spotBloc.getSpotList[index].title.rendered,
                        beachResume: HandleApiString.removeInapropriatedCharacter(spotBloc.getSpotList[index].content.rendered),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  Widget _emptyScreen() {
    return Container(
      alignment: Alignment.center,
      child: Text('Nada sobre esta região foi encontrado!'),
    );
  }
}
