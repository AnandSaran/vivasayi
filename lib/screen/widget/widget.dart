import 'package:flutter/material.dart';
import 'package:vivasayi/constants/constant.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vivasayi/constants/image_constants.dart';

Widget widgetDividerSpace({double width = 0, double height = 0}) {
  return SizedBox(width: width, height: height);
}

Widget widgetImageFromAsset(String path,
    {Color? color, double? width, double? height}) {
  return Image.asset(path, width: width, height: height, color: color);
}

Widget widgetSvgFromAsset(String path,
    {Color? color, double? width = 24, double? height = 24}) {
  return SvgPicture.asset(path, width: width, height: height, color: color);
}

Widget widgetCircleViewFromAsset(String path,
    {bool isSvg = false,
      double? circleWidth = 24,
      double? circleHeight = 24,
      EdgeInsets? circleMargin,
      Color? circleColor,
      Color? iconColor,
      double iconPadding = 5,
      double? iconWidth = 24,
      double? iconHeight = 24}) {
  return Container(
    width: circleWidth,
    height: circleHeight,
    margin: circleMargin,
    decoration: BoxDecoration(color: circleColor, shape: BoxShape.circle),
    child: Padding(
      padding: EdgeInsets.all(iconPadding),
      child: isSvg
          ? widgetSvgFromAsset(path,
          color: iconColor, width: iconWidth, height: iconHeight)
          : widgetImageFromAsset(path,
          color: iconColor, width: iconWidth, height: iconHeight),
    ),
  );
  return SvgPicture.asset(path,
      width: iconWidth, height: iconHeight, color: iconColor);
}

void showToast(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
}

Widget widgetLogo({double width = 150, double height = 150}) {
  return widgetImageFromAsset(ICON_LOGO, width: width, height: height);
}

Widget widgetError() {
  return const Icon(Icons.error);
}

Widget dividerSpace({double width = 0, double height = 0}) {
  return SizedBox(width: width, height: height);
}
