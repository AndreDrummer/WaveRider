import 'package:flutter/material.dart';
import 'package:waverider/widgets/image_header.dart';
import 'package:waverider/widgets/text_widgets.dart';

class BeachTile extends StatelessWidget {
  BeachTile({
    this.beachName,
    this.beachResume,
    this.loadImage,
  });

  final String beachName;
  final String beachResume;
  final Future loadImage;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      children: [
        Row(
          children: [
            FutureBuilder<String>(
              future: loadImage,
              builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    width: 150,
                    height: 150,
                    child: ImageHeader(),
                  );
                }
                return Container(
                  width: 150,
                  height: 150,
                  child: ImageHeader(
                    src: snapshot.data,
                  ),
                );
              },
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextTitle(
                  text: beachName,
                ),
                Container(
                  width: width - 170,
                  child: TextResume(
                    text: beachResume,
                  ),
                )
              ],
            )
          ],
        ),
        Divider()
      ],
    );
  }
}
