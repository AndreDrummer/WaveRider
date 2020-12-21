import 'package:flutter/material.dart';
import 'package:waverider/bloC/categorie_bloc.dart';
import 'package:waverider/models/post.dart';
import 'package:waverider/screens/categorie/functions.dart';
import 'package:waverider/utils/handle_api_string.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/text_widgets.dart';
import 'package:waverider/widgets/video.dart';
import 'package:waverider/utils/constantes.dart';

class CategorieDetail extends StatefulWidget {
  CategorieDetail({
    this.bloc,
    @required this.categorieType,
  });

  final CategorieBloc bloc;
  final CATEGORIE_TYPE categorieType;

  @override
  _CategorieDetailState createState() => _CategorieDetailState();
}

class _CategorieDetailState extends State<CategorieDetail> {
  @override
  Widget build(BuildContext context) {
    CategorieCommonFunctions categorieCommonFunctions = CategorieCommonFunctions(bloc: widget.bloc, categorieType: widget.categorieType);
    List<Post> list = categorieCommonFunctions.list();
    int indexDetailed = categorieCommonFunctions.getCategorieIndexBeingDetailed();

    if (list.isEmpty) return Container();
    String content = list[indexDetailed].content.rendered;
    bool containImage = content.contains('<figure class=\"wp-block-image');
    bool containVideo = content.contains('<figure class=\"wp-block-embed is-type-video');
    String videoTitle = containVideo ? HandleApiString.getVideoTitle(content) : null;
    String imageSrc = containImage ? HandleApiString.getImageSrc(content) : null;

    return WillPopScope(
      onWillPop: () async {
        categorieCommonFunctions.changeStackIndex(0);
        return false;
      },
      child: ListView(
        children: [
          ImageHeader(
            isExpanded: true,
            src: imageSrc,
          ),
          SizedBox(height: 10),
          TextTitle(text: list[indexDetailed].title.rendered, fontSize: 18),
          TextResume(text: content, fontSize: 14),
          Container(
            margin: const EdgeInsets.all(20),
            child: containVideo
                ? Column(
                    children: [
                      TextVideoTitle(text: videoTitle),
                      YouTubePlayer(
                        videoUrl: HandleApiString.getVideoLink(content),
                      ),
                    ],
                  )
                : Text(''),
          )
        ],
      ),
    );
  }
}