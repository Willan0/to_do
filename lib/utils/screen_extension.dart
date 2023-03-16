import 'package:flutter/material.dart';

extension ScreenExtension on Widget{
  void nextScreenPush(context,widget){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => widget,)
    );
  }
  void previousScreenPush(context){
    Navigator.of(context).pop();
  }
}