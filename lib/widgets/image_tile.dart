import 'package:flutter/material.dart';

class ImageTile extends StatelessWidget {
  ImageTile({
    this.imageUrl,
    this.regionName = 'Region Tile',
  });

  final String regionName;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: imageUrl != null ? NetworkImage(imageUrl) : AssetImage('assets/no-image.png'),
          fit: BoxFit.fill,
        ),
      ),
      child: _TextTile(regionName),
    );
  }
}

class _TextTile extends StatelessWidget {
  _TextTile(this.regionName);
  final String regionName;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 15, top: 40),
      child: Text(
        regionName,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          color: Colors.white,
          fontSize: 25,
        ),
      ),
    );
  }
}
