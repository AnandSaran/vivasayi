import 'package:flutter/material.dart';
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
    return Story(
      id: entity.id,
      title: "",
      subTitle: "",
      imageUrl: "",
    );
  }
}
