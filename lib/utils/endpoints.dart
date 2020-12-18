import 'constantes.dart';

class Endpoints {
  // Categories
  static String get listAllCategories => '${Constantes.BASE_URL}\wp-json/wp/v2/categories';

  static String listAllCategoriesByID(String categorieID) {
    return '${Constantes.BASE_URL}\wp-json/wp/v2/posts?categories=$categorieID';
  }

  static String getPostByID(String postID) {
    return '${Constantes.BASE_URL}\wp-json/wp/v2/posts/$postID';
  }

  // Spots / Regions
  static String get listAllRegions => '${Constantes.BASE_URL}\wp-json/wp/v2/regions';

  static String listAllSpotsByRegion(String regionID) {
    return '${Constantes.BASE_URL}\wp-json/wp/v2/spot?regions=$regionID';
  }

  static String getSpotDetails(String spotID) {
    return '${Constantes.BASE_URL}\wp-json/wp/v2/spot/$spotID';
  }
}
