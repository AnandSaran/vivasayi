import 'package:flutter/material.dart';
import 'package:story_genre_repository/story_genre_repository.dart';
import 'package:vivasayi/screen/widget/widgets.dart';

class GenreItem extends StatelessWidget {
  final StoryGenre storyGenre;
  final GestureTapCallback onTap;

  GenreItem({
    Key? key,
    required this.storyGenre,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildChip(storyGenre.genreName,onTap);
  }
}
