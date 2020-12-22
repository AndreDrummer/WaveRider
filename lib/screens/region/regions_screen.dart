import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/region_bloc.dart';
import 'package:waverider/screens/region/region_detail_screen.dart';
import 'package:waverider/screens/region/region_list.dart';
import 'package:waverider/screens/region/spot_detail.dart';

class RegionScreen extends StatefulWidget {
  @override
  _RegionScreenState createState() => _RegionScreenState();
}

class _RegionScreenState extends State<RegionScreen> {
  RegionBloc regionBloc;

  @override
  void didChangeDependencies() {
    regionBloc = BlocProvider.of<RegionBloc>(context);
    if (regionBloc.getRegionList.isEmpty) regionBloc.loadRegions();
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      stream: regionBloc.indexStack,
      builder: (context, snapshot) {
        return IndexedStack(
          index: snapshot.data ?? 0,
          children: [
            RegionList(
              bloc: regionBloc,
            ),
            RegionDetail(),
            SpotDetail()
          ],
        );
      },
    );
  }
}
