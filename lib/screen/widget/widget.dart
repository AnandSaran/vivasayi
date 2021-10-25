import 'package:flutter/material.dart';
import 'package:vivasayi/constants/constant.dart';

Widget dividerSpace({double width = 0, double height = 0}) {
  return SizedBox(width: width, height: height);
}

Widget widgetLogo() {
  return Image(
      image: AssetImage(ICON_LOGO), width: 150, height: 150);
}
