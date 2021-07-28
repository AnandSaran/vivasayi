import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Navigation {
  static final Navigation _navigation = Navigation._internal();

  factory Navigation() {
    return _navigation;
  }

  Navigation._internal();

  void pushPage(BuildContext context, String route,
      {bool isToReplace = false, bool isUntil = false}) {
    if (isToReplace) {
      Navigator.pushReplacementNamed(context, route);
    } else if (isUntil) {
      Navigator.pushNamedAndRemoveUntil(
        context,
        route,
        (Route<dynamic> route) => false,
      );
    } else {
      Navigator.pushNamed(context, route);
    }
  }

  pop(BuildContext context) {
    Navigator.pop(context);
  }
}
