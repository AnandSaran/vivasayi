import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/bloc/story_genres/story_genres.dart';

import 'widgets.dart';

class SelectStoryGenre extends StatelessWidget {
  SelectStoryGenre({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryGenresBloc, StoryGenresState>(
      builder: (context, state) {
        if (state is StoryGenresLoading) {
          return LoadingIndicator();
        } else if (state is StoryGenresLoaded) {
          return Column(
            children: [
              CreateStoryGenre(),
              Expanded(
                  child: StoryGenreListView(storyGenres: state.storyGenres))
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
