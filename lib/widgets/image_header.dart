import 'package:flutter/material.dart';
import 'package:waverider/utils/constantes.dart';

class ImageHeader extends StatelessWidget {
  ImageHeader({
    this.isExpanded = false,
    this.squareImage = false,
    this.src = Constantes.NO_IMAGE,
  });

  final bool isExpanded;
  final bool squareImage;
  final String src;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Container(
      height: squareImage ? 200 : height / 5,
      width: squareImage ? width / 2 : double.infinity,
      color: Colors.blueGrey,
      margin: EdgeInsets.symmetric(horizontal: isExpanded ? 0 : 15, vertical: isExpanded ? 0 : 10),
      child: FadeInImage(
        placeholder: AssetImage('assets/no-image.png'),
        image: NetworkImage(src),
        fit: BoxFit.fill,
      ),
    );
  }
}
