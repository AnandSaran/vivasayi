import 'package:vivasayi/models/models.dart';
abstract class PostRepository {
  Future<void> addNewPost(Post post);

  Future<void> deletePost(String documentId);

  Stream<List<Post>> posts();

  Future<void> updatePost(Post post);
}
