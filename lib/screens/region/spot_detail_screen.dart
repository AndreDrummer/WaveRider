import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/bloC/spot_bloc.dart';
import 'package:waverider/widgets/button_back.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/maps.dart';
import 'package:waverider/widgets/text_widgets.dart';

class SpotDetail extends StatefulWidget {
  @override
  _SpotDetailState createState() => _SpotDetailState();
}

class _SpotDetailState extends State<SpotDetail> {
  RegionBloc regionBloc;
  SpotBloc spotBloc;

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

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes de ${spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].title.rendered}'),
      ),
      body: ListView(
        children: [
          Container(
            height: height / 3,
            width: double.infinity,
            color: Colors.greenAccent,
            child: Maps(
              zoom: 15,
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
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: ImageHeader(
                    isExpanded: true,
                  ),
                );
              }
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ImageHeader(
                  isExpanded: true,
                  src: snapshot.data,
                ),
              );
            },
          ),
          SizedBox(height: 15),
          TextResume(
            text: spotBloc.getSpotList[spotBloc.spotIndexBeingDetailed].content.rendered,
            fontSize: 16,
          ),
          ButtonBack(
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
