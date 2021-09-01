import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/widgets.dart';

Widget storyView(
    List<Story> stories, BuildContext context, HomeNavigationItemIdEnum id) {
  return StoryListView(stories: stories, storyScreenId: id);
}
