import 'package:flutter/material.dart';
import 'package:waverider/utils/handle_api_string.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/text_widgets.dart';
import 'package:waverider/widgets/video.dart';

class CategorieDetail extends StatefulWidget {
  CategorieDetail({
    this.bloc,
  });

  final bloc;

  @override
  _CategorieDetailState createState() => _CategorieDetailState();
}

class _CategorieDetailState extends State<CategorieDetail> {
  @override
  Widget build(BuildContext context) {
    if (widget.bloc.getList.isEmpty) return Container();
    String content = widget.bloc.getList[widget.bloc.indexBeingDetailed].content.rendered;
    bool containImage = content.contains('<figure class=\"wp-block-image');
    bool containVideo = content.contains('<figure class=\"wp-block-embed is-type-video');
    String videoTitle = containVideo ? HandleApiString.getVideoTitle(content) : null;
    String imageSrc = containImage ? HandleApiString.getImageSrc(content) : null;

    return WillPopScope(
      onWillPop: () async {
        widget.bloc.changeStackIndex(0);
        return false;
      },
      child: ListView(
        children: [
          ImageHeader(
            isExpanded: true,
          ),
          SizedBox(height: 10),
          TextTitle(text: widget.bloc.getList[widget.bloc.indexBeingDetailed].title.rendered, fontSize: 18),
          imageSrc != null
              ? ImageHeader(
                  isExpanded: false,
                  squareImage: true,
                  src: imageSrc,
                )
              : Container(),
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
