import 'package:flutter/material.dart';
import 'package:waverider/services/spots_regions_service.dart';
import 'package:waverider/widgets/image_tile.dart';

class WaveSpotsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RegionService().getRegions();
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 40, bottom: 10),
          child: Center(
            child: Text(
              'Choose the region',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
          ),
        ),
        Expanded(
          child: ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              if (index == 9) return Container();
              return ImageTile();
            },
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: 10,
          ),
        )
      ],
    );
  }
}
