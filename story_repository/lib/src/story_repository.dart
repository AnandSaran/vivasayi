import 'dart:async';

import 'package:story_repository/src/models/models.dart';

abstract class StoryRepository {
  /* Future<void> addNewStory(Story story);*/

  /* Future<void> deleteStory(Story story);*/

  Stream<List<Story>> stories();

/* Future<void> updateStory(Story story);*/
}
