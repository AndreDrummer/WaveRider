import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Container(
      height: height / 5,
      width: double.infinity,
      color: Colors.red,
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
    );
  }
}
