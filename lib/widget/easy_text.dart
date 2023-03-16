import 'package:flutter/material.dart';
import 'package:to_do/constant/dimen.dart';

import '../constant/color.dart';

class EasyText extends StatelessWidget {
  const EasyText({Key? key,
  required this.data,
    this.fontWeight = FontWeight.w400,
    this.decoration = TextDecoration.none,
    this.fontColor = cPrimaryTextColor,
    this.fontSize = kFi14x
  }) : super(key: key);

  final String data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color fontColor;
  final TextDecoration decoration;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: fontColor,
        decoration: decoration,
      ),
    );
  }
}
