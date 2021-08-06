import 'package:flutter/material.dart';
import 'package:story_genre_repository/story_genre_repository.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/util/navigation.dart';

class StoryGenreListView extends StatelessWidget {
  const StoryGenreListView({
    Key? key,
    required this.storyGenres,
  }) : super(key: key);

  final List<StoryGenre> storyGenres;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Wrap(
            spacing: 5,
            children: List.generate(
              storyGenres.length,
              (index) {
                final storyGenre = storyGenres[index];
                return GenreItem(
                  storyGenre: storyGenre,
                  onTap: () {
                    onTapListItem(context, storyGenre);
                  },
                );
              },
            )));
  }

  void onTapListItem(BuildContext context, StoryGenre storyGenre) {
    Navigation().popWithResultBack(context, storyGenre);
  }
}
