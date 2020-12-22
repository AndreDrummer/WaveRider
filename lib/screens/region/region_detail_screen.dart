import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/maps_bloc.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/bloC/spot_bloc.dart';
import 'package:waverider/models/spot.dart';
import 'package:waverider/screens/region/spot_detail.dart';
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
  MapsBloc mapsBloc;

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
            snippet: spot.acf.subregion,
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
    mapsBloc = BlocProvider.of<MapsBloc>(context);
    super.didChangeDependencies();
  }

  void openSpotDetail() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SpotDetail(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    if (regionBloc.getRegionList.isEmpty) return Container();
    final _centerEmpty = LatLng(36.8977574, -27.8334449);

    return WillPopScope(
      onWillPop: () async {
        regionBloc.changeStackIndex(regionBloc.getIndexStack - 1);
        return false;
      },
      child: spotBloc.getSpotList.isEmpty
          ? _emptyScreen(context)
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
                      target: spotBloc.getSpotList.isNotEmpty ? LatLng(double.parse(spotBloc.getSpotList.first.acf.lat), double.parse(spotBloc.getSpotList.first.acf.lon)) : _centerEmpty,
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
                      String resume = HandleApiString.removeInapropriatedCharacter(spotBloc.getSpotList[index].content.rendered);
                      resume = resume.split('.')[0] + resume.split('.')[1] + resume.split('.')[2] + '...';
                      return GestureDetector(
                        onTap: () {
                          spotBloc.changeSpotIndexBeingDetailed(index);
                          Spot spot = spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed];
                          mapsBloc.changeMapSpotDetail(spot);
                          openSpotDetail();
                        },
                        child: BeachTile(
                          loadImage: spotBloc.loadDestakImage(spotBloc.getSpotList[index].lLinks.wpAttachment.first.href),
                          beachName: spotBloc.getSpotList[index].title.rendered,
                          beachResume: resume,
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
    );
  }

  Widget _emptyScreen(context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: height / 3,
            width: double.infinity,
            color: Colors.greenAccent,
          ),
          Padding(
            padding: EdgeInsets.only(top: height / 5, left: height / 36),
            child: Column(
              children: [
                Text(
                  ':(',
                  style: TextStyle(fontSize: 60, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 15),
                Text('Nada sobre esta região foi encontrado!'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
