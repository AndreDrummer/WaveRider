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
      print(response);
    } catch (e) {
      print(e);
    }
    return regions;
  }

  void getSpotByRegionID(String regionID) async {
    try {
      Response response = await Dio().get(Endpoints.listAllSpotsByRegion(regionID));
      print(response);
    } catch (e) {
      print(e);
    }
  }

  void getSpotByID(String spotID) async {
    try {
      Response response = await Dio().get(Endpoints.getSpotDetails(spotID));
      print(response);
    } catch (e) {
      print(e);
    }
  }
}
