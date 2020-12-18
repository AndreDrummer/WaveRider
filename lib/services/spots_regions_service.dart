import 'package:dio/dio.dart';
import 'package:waverider/utils/endpoints.dart';

class SpotRegionService {
  void getRegions() async {
    try {
      Response response = await Dio().get(Endpoints.listAllRegions);
      print(response);
    } catch (e) {
      print(e);
    }
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
