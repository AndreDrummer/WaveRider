import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  ImageHeader({
    this.isExpanded = false,
  });

  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 5,
      width: double.infinity,
      color: Colors.red,
      margin: EdgeInsets.symmetric(horizontal: isExpanded ? 0 : 15, vertical: isExpanded ? 0 : 10),
    );
  }
}
