import 'package:flutter/material.dart';
import 'package:waverider/bloC/bloc_provider.dart';
import 'package:waverider/bloC/news_bloc.dart';
import 'package:waverider/utils/handle_api_string.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/text_widgets.dart';
import 'package:waverider/widgets/video.dart';

class NewDetail extends StatefulWidget {
  @override
  _NewDetailState createState() => _NewDetailState();
}

class _NewDetailState extends State<NewDetail> {
  NewsBloc bloc;

  @override
  void didChangeDependencies() {
    bloc = BlocProvider.of<NewsBloc>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    if (bloc.getList.isEmpty) return Container();

    String content = bloc.getList[bloc.indexBeingDetailed].content.rendered;
    bool containImage = content.contains('<figure class=\"wp-block-image');
    bool containVideo = content.contains('<figure class=\"wp-block-embed is-type-video');
    String videoTitle = containVideo ? HandleApiString.getVideoTitle(content) : null;
    String imageSrc = containImage ? HandleApiString.getImageSrc(content) : null;

    return WillPopScope(
      onWillPop: () async {
        bloc.changeStackIndex(0);
        return false;
      },
      child: ListView(
        children: [
          ImageHeader(
            isExpanded: true,
          ),
          SizedBox(height: 10),
          TextTitle(text: bloc.getList[bloc.indexBeingDetailed].title.rendered, fontSize: 18),
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
