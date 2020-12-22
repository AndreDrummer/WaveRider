import 'package:flutter/material.dart';

class ButtonBack extends StatelessWidget {
  ButtonBack({
    this.onPressed,
  });
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            FlatButton(
              onPressed: onPressed,
              child: Text('Voltar'),
            ),
          ],
        ),
      ],
    );
  }
}
