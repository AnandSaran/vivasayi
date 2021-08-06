import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  final String id;
  final String userId;
  final String content;
  final String genre;

  const StoryEntity(
      {id, required this.userId, required this.content, required this.genre})
      : this.id = id ?? '';

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'genre': genre,
    };
  }

  @override
  List<Object?> get props => [id, userId, content, genre];

  @override
  String toString() {
    return 'StoryGenreEntity { id: $id, userId: $userId, content: $content, genre: $genre}';
  }

  static StoryEntity fromJson(Map<String, Object> json) {
    return StoryEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      genre: json['genre'] as String,
    );
  }

  static StoryEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return StoryEntity(
        id: snap.get('id'),
        userId: snap.get('userId'),
        content: snap.get('content'),
        genre: snap.get('genre'));
  }

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'content': content,
      'genre': genre,
      'date': Timestamp.now(),
    };
  }
}
