import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/entities/entities.dart';
import 'package:vivasayi/models/models.dart';

import 'abstract/abstract_repository.dart';

class FireStorePostRepository implements PostRepository {
  var postCollection = FirebaseFirestore.instance.collection(COL_POST);

  void changeCollectionName(String collectionName) {
    postCollection = FirebaseFirestore.instance.collection(collectionName);
  }

  @override
  Future<void> addNewPost(Post post) {
    return postCollection.add(post.toEntity().toDocument());
  }

  @override
  Future<void> deletePost(String documentId) {
    return postCollection.doc(documentId).delete();
  }

  @override
  Stream<List<Post>> posts() {
    return postCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => Post.fromEntity(PostEntity.fromSnapshot(doc)))
          .toList();
    });
  }

  @override
  Future<void> updatePost(Post post) {
    return postCollection.doc(post.id).update(post.toEntity().toDocument());
  }
}
