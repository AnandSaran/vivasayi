import 'package:cloud_firestore/cloud_firestore.dart';

class PostEntity {
  final String id;
  final String userId;
  final String content;
  final String genre;

  PostEntity(this.id, this.userId, this.content, this.genre);

  Map<String, Object> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'genre': genre,
    };
  }

  static PostEntity fromJson(Map<String, Object> json) {
    return PostEntity(
      json['id'] as String,
      json['userId'] as String,
      json['content'] as String,
      json['genre'] as String,
    );
  }

  static PostEntity fromSnapshot(DocumentSnapshot snap) {
    return PostEntity(
      snap.id,
      snap['userId'],
      snap['content'],
      snap['genre'],
    );
  }

  Map<String, Object> toDocument() {
    return {
      'userId': userId,
      'content': content,
      'genre': genre,
      'date': Timestamp.now(),
    };
  }

  Map<String, Object> toHomeBannerStoryDocument(String adsFieldName) {
    return {
      'userId': userId,
      'content': content,
      'genre': genre,
      adsFieldName: true,
      'date': Timestamp.now(),
    };
  }
}
