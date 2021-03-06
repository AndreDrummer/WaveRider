import 'constantes.dart';

class Endpoints {
  // News / Events list and Detail.
  static String listAllPostsByCategorie(CATEGORIE_TYPE categorieName) {
    int categorieID;
    switch (categorieName) {
      case CATEGORIE_TYPE.news:
        categorieID = 9;
        break;
      case CATEGORIE_TYPE.events:
        categorieID = 11;
    }

    return '${Constantes.BASE_URL}\wp-json/wp/v2/posts?categories=$categorieID';
  }

  static String getPostByID(String postID) {
    return '${Constantes.BASE_URL}\wp-json/wp/v2/posts/$postID';
  }

  // Spots / Regions
  static String get listAllRegions => '${Constantes.BASE_URL}\wp-json/wp/v2/regions';

  static String listAllSpotsByRegion(int regionID) {
    return '${Constantes.BASE_URL}\wp-json/wp/v2/spot?regions=$regionID';
  }

  static String getSpotDetails(String spotID) {
    return '${Constantes.BASE_URL}\wp-json/wp/v2/spot/$spotID';
  }
}
