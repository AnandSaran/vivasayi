import 'package:flutter/material.dart';

Widget buildChip(String label, GestureTapCallback onTap) {
  return ActionChip(
    labelPadding: EdgeInsets.all(2.0),
    avatar: CircleAvatar(
      backgroundColor: Colors.black,
      child: Text(label[0].toUpperCase()),
    ),
    label: Text(
      label,
      style: TextStyle(
        color: Colors.black,
        fontSize: 17
      ),
    ),
    backgroundColor: Colors.white38,
    elevation: 6.0,
    shadowColor: Colors.grey[60],
    padding: EdgeInsets.all(8.0),
    onPressed: () {
      onTap();
    },
  );
}