import 'package:flutter/material.dart';
import 'package:vivasayi/constants/constant.dart';
import 'entities/entities.dart';

@immutable
class Post {
  String id = EMPTY_STRING;
  String userId = EMPTY_STRING;
  String content = EMPTY_STRING;
  String title = EMPTY_STRING;
  String genre = EMPTY_STRING;
  List<String> imageUrl = List.empty();

  Post(this.id, this.userId, this.content, this.title, this.genre);

  Post copyWith(
      {String id = EMPTY_STRING,
      String userId = EMPTY_STRING,
      String content = EMPTY_STRING,
      String title = EMPTY_STRING,
      String genre = EMPTY_STRING}) {
    return Post(id, userId, content, title, genre);
  }

  @override
  int get hashCode =>
      id.hashCode ^ userId.hashCode ^ content.hashCode ^ title.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          userId == other.userId &&
          content == other.content &&
          title == other.title;

  PostEntity toEntity() {
    return PostEntity(id, userId, content, genre);
  }

  static Post fromEntity(PostEntity entity) {
    /* NotusDocument doc = NotusDocument.fromJson(jsonDecode(entity.content));
    String title =doc.toPlainText();*/
    return Post(
        entity.id, entity.userId, entity.content, "title", entity.genre);
  }
}
