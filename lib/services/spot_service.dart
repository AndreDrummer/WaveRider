import 'package:dio/dio.dart';
import 'package:waverider/models/common.dart';
import 'package:waverider/models/spot.dart';
import 'package:waverider/utils/endpoints.dart';

class SpotService {
  Future<List<Spot>> loadSpotsByRegionID(int regionID) async {
    List<Spot> spots = List<Spot>();
    try {
      Response response = await Dio().get(Endpoints.listAllSpotsByRegion(regionID));
      if (response.data != null) {
        spots = List<Spot>.from(
          response.data.map(
            (spot) => Spot.fromJson(spot),
          ),
        );
      }
      print(response);
    } catch (e) {
      print(e);
    }

    return spots;
  }

  Future<String> loadDestakImage(String url) async {
    List<DestakImageData> destakImageData = List<DestakImageData>();
    try {
      Response response = await Dio().get(url);
      if (response.data != null) {
        destakImageData = List<DestakImageData>.from(response.data.map((destakImageData) => DestakImageData.fromJson(destakImageData)));
      }
    } catch (e) {
      print(e);
    }
    return destakImageData.isEmpty ? null : destakImageData.first.guid.rendered;
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
