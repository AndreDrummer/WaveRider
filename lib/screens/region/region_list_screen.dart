import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/bloC/spot_bloc.dart';
import 'package:waverider/models/region.dart';
import 'package:waverider/widgets/image_tile.dart';
import 'package:waverider/widgets/loading_page.dart';

class RegionList extends StatefulWidget {
  RegionList({
    this.bloc,
  });

  final RegionBloc bloc;

  @override
  _RegionListState createState() => _RegionListState();
}

class _RegionListState extends State<RegionList> {
  RegionBloc regionBloc;
  SpotBloc spotBloc;

  @override
  void didChangeDependencies() {
    spotBloc = BlocProvider.of<SpotBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Region>>(
      stream: widget.bloc.regionList,
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
                  return GestureDetector(
                    onTap: () async {
                      await spotBloc.getSpotsByRegionID(items[index].id);
                      widget.bloc.changeStackIndex(1);
                      widget.bloc.changeRegionIndexBeingDetailed(index);
                    },
                    child: ImageTile(
                      imageUrl: items[index].acf?.highlightedPicture,
                      regionName: items[index].name,
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) => Divider(),
                itemCount: qtyItem + 1,
              ),
            )
          ],
        );
      },
    );
  }
}
