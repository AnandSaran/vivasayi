import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;

abstract class AppColors {
  static const Color loginGradientStart = const Color(0xFFFFFFFF);
  static const Color backgroundColor = const Color(0xFFE9E9E9);
  static const Color transparent = const Color(0x00000000);
  static const Color loginGradientEnd = const Color(0xFFFFFFF9);
  static const Color homeNavigationBarBackgroundColor = const Color(0xFFFFFFFF);
  static const Color toolBarBackgroundColor = const Color(0xFF00942C);

  static const Color iconColor = const Color(0xFFFFFFFF);

  static const Color blackColor = const Color(0xFF000000);
  static const Color whiteColor = const Color(0xFFFFFFFF);
  static const Color redColor = const Color(0xFF860043);
  static Color appGreen = Color(0xFF00942C);
  static Color lightGrey = Color(0xFFE6E6E6);

  static const Color profileBackgroundColorStart = const Color(0xFF715DEC);
  static const Color profileBackgroundColorEnd = const Color(0xFF9E60EC);

  static Color buttonColorIdle = Material.Colors.deepPurple.shade500;
  static Color buttonColorLoading = Material.Colors.deepPurple.shade700;
  static Color buttonColorFail = Material.Colors.red.shade900;
  static Color buttonColorSuccess = Material.Colors.green.shade400;

  static const primaryGradient = const LinearGradient(
    colors: const [loginGradientStart, loginGradientEnd],
    stops: const [0.0, 1.0],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
