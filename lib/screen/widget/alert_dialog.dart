import 'package:flutter/material.dart';

Widget buildAlertDialog(String title, String content,
    String positiveButtonTitle, GestureTapCallback onTapPositiveButton) {
  Widget positiveButton = TextButton(
    child: Text(positiveButtonTitle),
    onPressed: () {
      onTapPositiveButton();
    },
  );

  return AlertDialog(
    title: Text(title),
    content: Text(content),
    actions: [
      positiveButton,
    ],
  );
}
