import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  ImageHeader({
    this.isExpanded = false,
    this.squareImage = false,
    this.src,
  });

  final bool isExpanded;
  final bool squareImage;
  final String src;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    String imageUrl = src;

    // if (imageUrl == null) imageUrl = Constantes.NO_IMAGE;

    return Container(
      height: squareImage ? 200 : height / 5,
      width: squareImage ? width / 2 : double.infinity,
      color: Colors.blueGrey,
      margin: EdgeInsets.symmetric(horizontal: isExpanded ? 0 : 15, vertical: isExpanded ? 0 : 10),
      child: imageUrl != null && imageUrl.isNotEmpty
          ? FadeInImage(
              placeholder: AssetImage('assets/no-image.png'),
              image: NetworkImage(imageUrl),
              fit: BoxFit.fill,
            )
          : Image.asset(
              'assets/no-image.png',
              fit: BoxFit.fill,
            ),
    );
  }
}
