import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:story_repository/extension/extension.dart';
import 'package:story_repository/src/entities/entities.dart';

@immutable
class Story {
  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;

  Story({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
  });

  Story copyWith() {
    return Story(
      id: id,
      title: title,
      subTitle: subTitle,
      imageUrl: imageUrl,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^ title.hashCode ^ subTitle.hashCode ^ imageUrl.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Story &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            title == other.title &&
            subTitle == other.subTitle &&
            imageUrl == other.imageUrl;
  }

  @override
  String toString() {
    return 'Story{id: $id, title: $title, subTitle: $subTitle, imageUrl: $imageUrl}';
  }

  static Story fromEntity(StoryEntity entity) {
    var myJSON = jsonDecode(entity.content);
    Document quilDocument = Document.fromJson(myJSON);

    return Story(
      id: entity.id,
      title: quilDocument.title,
      subTitle: quilDocument.subtitle,
      imageUrl: quilDocument.imageUrl,
    );
  }
}
