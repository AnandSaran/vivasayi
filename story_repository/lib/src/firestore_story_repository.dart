import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story_repository/constants/constant.dart';
import 'package:story_repository/src/models/story.dart';
import 'package:story_repository/src/story_repository.dart';

import 'entities/entities.dart';

class FirestoreStoryRepository implements StoryRepository {
  var storyCollection = FirebaseFirestore.instance.collection(COL_STORY_HOME);

  void changeCollectionName(String collectionName) {
    storyCollection = FirebaseFirestore.instance.collection(collectionName);
  }

/*
  @override
  Future<void> addNewStory(Story story) {
    return storyCollection.add(story.toEntity().toDocument());
  }*/

  /* @override
  Future<void> deleteStory(Story story) {
    return storyCollection.doc(story.id).delete();
  }
*/
  @override
  Stream<List<Story>> stories() {
    return storyCollection
        .orderBy(FIELD_DATE, descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Story.fromEntity(StoryEntity.fromSnapshot(doc)))
          .toList();
    });
  }

/*@override
  Future<void> updateStory(Story story) {
    return storyCollection.doc(story.id).update(story.toEntity().toDocument());
  }*/
}
