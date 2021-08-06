import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_genre_repository/story_genre_repository.dart';
import 'package:vivasayi/bloc/story_genres/story_genres.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/extension/extension.dart';
class CreateStoryGenre extends StatelessWidget {
  final TextEditingController _addNewStoryGenreController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryGenresBloc, StoryGenresState>(
        builder: (context, state) {
      return Padding(
          padding: EdgeInsets.all(10.0),
          child: TextField(
              controller: _addNewStoryGenreController,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                border: textFieldBorder(),
                hintText: HINT_ADD_NEW_STORY_GENRE,
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    _onClickAddGenre(context);
                  },
                ),
              )));
    });
  }

  void _onClickAddGenre(BuildContext context) {
    if (isFormValid()) {
      context.read<StoryGenresBloc>().add(AddStoryGenre(
          StoryGenre(genreName: _addNewStoryGenreController.text.trim().capitalizeFirstChar())));
    } else {
      showToast(context, ERROR_ADD_GENRE_NAME);
    }
  }

  bool isFormValid() {
    return _addNewStoryGenreController.text.trim().length > 0;
  }
}
