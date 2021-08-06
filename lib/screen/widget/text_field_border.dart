import 'package:flutter/material.dart';

OutlineInputBorder textFieldBorder() {
  return OutlineInputBorder(
    borderRadius: const BorderRadius.all(
      const Radius.circular(8.0),
    ),
    borderSide: new BorderSide(
      color: Colors.black,
      width: 0.5,
    ),
  );
}
