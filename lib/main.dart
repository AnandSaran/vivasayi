import 'package:flutter/material.dart';
import 'package:vivasayi/screens/homepage.dart';
import 'package:vivasayi/screens/product_widget.dart';
import 'package:vivasayi/style/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vivasayi',
      theme: ThemeData(
        fontFamily: 'sitka',
        primaryColor: AppColors.appGreen,
      ),
      home: MyHomePage(title: 'Vivasayi'),
    );
  }
}