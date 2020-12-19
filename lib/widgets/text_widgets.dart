import 'package:flutter/material.dart';
import 'package:waverider/utils/handle_api_string.dart';

class TextTitle extends StatelessWidget {
  TextTitle({this.text, this.fontSize = 16});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Text(
        HandleApiString.removeInapropriatedCharacter(text),
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class TextResume extends StatelessWidget {
  TextResume({this.text, this.fontSize = 11});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Text(
        HandleApiString.removeInapropriatedCharacter(text),
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: FontWeight.w300,
          fontSize: fontSize,
        ),
      ),
    );
  }
}

class TextVideoTitle extends StatelessWidget {
  TextVideoTitle({this.text, this.fontSize = 10});

  final String text;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      child: Text(
        HandleApiString.removeInapropriatedCharacter(text).toUpperCase(),
        textAlign: TextAlign.justify,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: fontSize,
        ),
      ),
    );
  }
}
