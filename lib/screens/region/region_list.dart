import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/models/region.dart';
import 'package:waverider/services/spots_regions_service.dart';
import 'package:waverider/widgets/image_tile.dart';
import 'package:waverider/widgets/loading_page.dart';

class RegionList extends StatefulWidget {
  @override
  _RegionListState createState() => _RegionListState();
}

class _RegionListState extends State<RegionList> {
  RegionBloc regionBloc;

  @override
  void didChangeDependencies() {
    regionBloc = BlocProvider.of<RegionBloc>(context);
    if (regionBloc.getRegionList.isEmpty) regionBloc.loadRegions();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    RegionService().getRegions();
    return StreamBuilder<List<Region>>(
        stream: regionBloc.regionList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return LoadingPage();
          }

          List<Region> items = snapshot.data;
          int qtyItem = items.length;

          return Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30, bottom: 10),
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
                    if (index == qtyItem) return Container();
                    return ImageTile(
                      imageUrl: items[index].acf?.highlightedPicture,
                      regionName: items[index].name,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) => Divider(),
                  itemCount: qtyItem + 1,
                ),
              )
            ],
          );
        });
  }
}
