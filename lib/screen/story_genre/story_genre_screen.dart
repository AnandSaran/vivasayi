import 'package:flutter/material.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/style/theme.dart' as Theme;

class StoryGenreScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(STORY_GENRE),
        backgroundColor: Theme.AppColors.toolBarBackgroundColor,
      ),
      body: SelectStoryGenre(),
    );
  }
}