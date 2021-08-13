import 'package:flutter/material.dart';

class Fab extends StatelessWidget {
  final IconData iconData;
  final Color fabColor;
  final GestureTapCallback onTap;

  Fab({
    Key? key,
    required this.iconData,
    required this.fabColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildFab(iconData, fabColor, onTap);
  }
}

Widget buildFab(IconData iconData, Color fabColor, GestureTapCallback onTap) {
  return FloatingActionButton(
    onPressed: () {
      onTap();
    },
    child: Icon(iconData),
    backgroundColor: fabColor,
  );
}
