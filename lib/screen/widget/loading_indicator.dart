import 'package:flutter/material.dart';
import 'package:vivasayi/style/theme.dart' as Theme;

class LoadingIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(color:Theme.AppColors.accentColor),
    );
  }
}