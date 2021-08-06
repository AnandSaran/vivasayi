import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story_genre_repository/constants/constant.dart';
import 'package:story_genre_repository/src/models/story_genre.dart';
import 'package:story_genre_repository/src/story_genre_repository.dart';

import 'entities/entities.dart';

class FirestoreStoryGenreRepository implements StoryGenreRepository {
  final todoCollection = FirebaseFirestore.instance.collection(COL_STORY_GENRE);

  @override
  Future<void> addNewStoryGenre(StoryGenre storyGenre) {
    return todoCollection.add(storyGenre.toEntity().toDocument());
  }

  @override
  Future<void> deleteStoryGenre(StoryGenre storyGenre) {
    return todoCollection.doc(storyGenre.id).delete();
  }

  @override
  Stream<List<StoryGenre>> storyGenres() {
    return todoCollection.orderBy(FIELD_GENRE_NAME).snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) =>
              StoryGenre.fromEntity(StoryGenreEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updateStoryGenre(StoryGenre storyGenre) {
    return todoCollection
        .doc(storyGenre.id)
        .update(storyGenre.toEntity().toDocument());
  }
}
