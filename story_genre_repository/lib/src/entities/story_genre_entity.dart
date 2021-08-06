import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class StoryGenreEntity extends Equatable {
  final String id;
  final String genreName;

  const StoryGenreEntity({
    required this.id,
    required this.genreName,
  });

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'genreName': genreName,
    };
  }

  @override
  List<Object?> get props => [id, genreName];

  @override
  String toString() {
    return 'StoryGenreEntity { id: $id, genreName: $genreName}';
  }

  static StoryGenreEntity fromJson(Map<String, Object> json) {
    return StoryGenreEntity(
      id: json['id'] as String,
      genreName: json['genreName'] as String,
    );
  }

  static StoryGenreEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return StoryGenreEntity(
        id: snap.get('id'), genreName: snap.get('genreName'));
  }

  Map<String, Object?> toDocument() {
    return {
      'id': id,
      'genreName': genreName,
    };
  }
}
