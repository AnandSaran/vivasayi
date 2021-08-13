import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/util/navigation.dart';

Stack storyView(List<Story> stories, BuildContext context, String id) {
  return Stack(
    children: <Widget>[
      storyListView(stories),
      Fab(
          iconData: Icons.add,
          fabColor: Theme.AppColors.fabColor,
          onTap: () {
            onTapFab(context, id);
          })
    ],
  );
}

onTapFab(BuildContext context, String id) {
  Navigation().pushPageWithArgument(context, ROUTE_CREATE_STORY, id);
}
