import 'dart:async';

import 'package:story_genre_repository/src/models/models.dart';

abstract class StoryGenreRepository {
  Future<void> addNewStoryGenre(StoryGenre storyGenre);

  Future<void> deleteStoryGenre(StoryGenre storyGenre);

  Stream<List<StoryGenre>> storyGenres();

  Future<void> updateStoryGenre(StoryGenre storyGenre);
}
