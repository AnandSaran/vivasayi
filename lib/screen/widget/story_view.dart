import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_factory/read_story_data_factory.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/util/navigation.dart';

Stack storyView(
    List<Story> stories, BuildContext context, HomeNavigationItemIdEnum id) {
  return Stack(
    children: <Widget>[
      StoryListView(stories: stories, storyScreenId: id),
      Fab(
          iconData: Icons.add,
          fabColor: Theme.AppColors.fabColor,
          onTap: () {
            onTapFab(context, id);
          })
    ],
  );
}

onTapFab(BuildContext context, HomeNavigationItemIdEnum id) {
  ReadStoryDataFactory readStoryDataFactory =
      ReadStoryDataFactory(storyScreenId: id);
  Navigation()
      .pushPageWithArgument(context, ROUTE_CREATE_STORY, readStoryDataFactory);
}
