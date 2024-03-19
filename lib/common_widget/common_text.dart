import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {

  final String? text;
  final double? fontSize;
  final FontWeight? fontWeight;

  const CommonText({super.key, this.text, this.fontSize, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Text(text.toString(),style: TextStyle(fontSize: fontSize, fontWeight: fontWeight));
  }
}
