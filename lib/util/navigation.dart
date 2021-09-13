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

  popWithResultBack(BuildContext context, dynamic data) {
    Navigator.pop(context, data);
  }

  pushPageWithArgument(BuildContext context, String route, dynamic data) {
    Navigator.pushNamed(
      context,
      route,
      arguments: data,
    );
  }

  pushReplacementNamed(BuildContext context, String route, dynamic data) {
    Navigator.pushReplacementNamed(
      context,
      route,
      arguments: data,
    );
  }

  popAndPushNamed(BuildContext context, String route, {dynamic data}) {
    Navigator.popAndPushNamed(
      context,
      route,
      arguments: data,
    );
  }

  dynamic pushPageResult(BuildContext context, String route) async {
    return await Navigator.of(context).pushNamed(route);
    /*Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screenName),
    );*/
  }

  void showToast(BuildContext context, String message) {
    hidKeyPad();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  hidKeyPad() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  Future<void> popDelay(BuildContext context, int milliseconds) async {
    await new Future.delayed(Duration(milliseconds: milliseconds));
    pop(context);
  }
}
