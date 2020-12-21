import 'package:dio/dio.dart';
import 'package:waverider/models/region.dart';
import 'package:waverider/utils/endpoints.dart';

class RegionService {
  Future<List<Region>> getRegions() async {
    List<Region> regions = List<Region>();
    try {
      Response response = await Dio().get(Endpoints.listAllRegions);
      if (response.data != null) {
        regions = List<Region>.from(
          response.data.map(
            (region) => Region.fromJson(region),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    return regions;
  }
}
