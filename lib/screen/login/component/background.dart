import 'package:flutter/material.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/screen/widget/widget.dart';
import 'package:vivasayi/style/theme.dart';

class Background extends StatelessWidget {
  final Widget child;

  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
            colors: [
              AppColors.screenBackgroundColorWhite,
              AppColors.screenBackgroundColorWhite,
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 1.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            child: widgetImageFromAsset(
              ICON_LOGIN_TOP,
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: widgetImageFromAsset(
              ICON_LOGIN_BOTTOM,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
