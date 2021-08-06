import 'package:flutter/material.dart';
import 'package:story_genre_repository/src/entities/entities.dart';

@immutable
class StoryGenre {
  final String id;
  final String genreName;

  StoryGenre({
    required this.genreName,
    String? id,
  }) : this.id = id ?? '';

  StoryGenre copyWith({String? genreName}) {
    return StoryGenre(
      id: id,
      genreName: genreName ?? this.genreName,
    );
  }

  @override
  int get hashCode {
    return genreName.hashCode ^ id.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is StoryGenre &&
            runtimeType == other.runtimeType &&
            genreName == other.genreName &&
            id == other.id;
  }

  @override
  String toString() {
    return 'Todo{genreName: $genreName, id: $id}';
  }

  StoryGenreEntity toEntity() {
    return StoryGenreEntity(
      id: id,
      genreName: genreName,
    );
  }

  static StoryGenre fromEntity(StoryGenreEntity entity) {
    return StoryGenre(
      id: entity.id,
      genreName: entity.genreName,
    );
  }
}
