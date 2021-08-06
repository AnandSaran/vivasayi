import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as Material;
import 'package:flutter/services.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutter_quill/flutter_quill.dart' hide Text;
import 'package:rxdart/rxdart.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/extension/extension.dart';
import 'package:vivasayi/models/models.dart';
import 'package:vivasayi/repository/repository.dart';

import 'bloc.dart';

class PostBloc extends BlocBase {
  final _repository = FireStorePostRepository();
  final _content = BehaviorSubject<String>();
  final _showProgress = BehaviorSubject<bool>();
  final _showSelectStoryGenreScreen = BehaviorSubject<bool>();
  final _postUploaded = BehaviorSubject<bool>();

  PostBloc() {}

  Stream<bool> get showProgress => _showProgress.stream;

  Stream<bool> get showSelectStoryGenrePage =>
      _showSelectStoryGenreScreen.stream;

  Stream<bool> get isPostUploaded => _postUploaded.stream;

  Function(bool) get showProgressBar => _showProgress.sink.add;

  Function(bool) get setShowSelectStoryGenreScreen =>
      _showSelectStoryGenreScreen.sink.add;

  void setStoryCollectionName(String collectionName) {
    _repository.changeCollectionName(collectionName);
  }

  bool _validateContent(BuildContext context, String plainText) {
    if (plainText.length > MINIMUM_POST_LENGTH) {
      return true;
    } else {
      showToast(context, POST_VALIDATE_MESSAGE);
      return false;
    }
  }

  void submit(BuildContext context, String content, String plainText) {
    _content.add(content);
    _showProgress.sink.add(true);
    if (_validateContent(context, plainText)) {
      _showSelectStoryGenreScreen.sink.add(true);
      // addUserPost();
    } else {
      _showProgress.sink.add(false);
    }

    Stream<List<Post>> myPostList() {
      return _repository.posts();
    }

    Stream<List<Post>> allPostList() {
      return _repository.posts();
    }
  }

  void dispose() async {
    await _content.drain();
    _content.close();
    await _showProgress.drain();
    _showProgress.close();
    await _showSelectStoryGenreScreen.drain();
    _showSelectStoryGenreScreen.close();
    await _postUploaded.drain();
    _postUploaded.close();
  }

  //Remove item from the goal list
  void removePost(String postId) {
    _repository.deletePost(postId);
  }

  void addUserPost(String genre) {
    Post post =
        Post(EMPTY_STRING, EMPTY_STRING, _content.value, EMPTY_STRING, genre);
    _repository.addNewPost(post).then((value) {
      _cleanDocument();
    });
  }

  String getContent(QuillController controller) {
    return jsonEncode(controller.document.toDelta().toJson());
  }

  String getPlainText(QuillController controller) {
    return controller.document.toPlainText();
  }

  void saveDocument(BuildContext context, QuillController controller) {
    // Notus documents can be easily serialized to JSON by passing to
    // For this example we save our document to a temporary file.
    final file = File(Directory.systemTemp.path + POST_LOCAL_PATH);
    // And show a snack bar on success.
    file.writeAsString(getContent(controller)).then((_) {
      // showToast(context,POST_LOCAL_SAVE_MESSAGE);
    });
  }

  /// Loads the document asynchronously from a file if it exists, otherwise
  /// returns default document.
  Future<QuillController> loadDocument() async {
    _showProgress.sink.add(true);
    /* final file = File(Directory.systemTemp.path + POST_LOCAL_PATH);
    if (await file.exists()) {
      final contents = await file
          .readAsString()
          .then((data) => Future.delayed(Duration(seconds: 1), () => data));
      return NotusDocument.fromJson(jsonDecode(contents));
    }
    final Delta delta = Delta()..insert("\n");
    return NotusDocument.fromDelta(delta);*/

    final result = await rootBundle
        .loadString(Directory.systemTemp.path + POST_LOCAL_PATH);
    final doc = Document.fromJson(jsonDecode(result));
    return QuillController(
        document: doc, selection: const TextSelection.collapsed(offset: 0));
  }

  QuillController loadEmptyDocument() {
    final doc = Document()..insert(0, EMPTY_STRING);
    return QuillController(
        document: doc, selection: const TextSelection.collapsed(offset: 0));
  }

  void _cleanDocument() async {
    final file = File(Directory.systemTemp.path + POST_LOCAL_PATH);
    if (await file.exists()) {
      file.delete().then((value) => _postUploaded.sink.add(true));
    } else {
      _postUploaded.sink.add(true);
    }
  }

  void showToast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Material.Text(message)));
  }

  Future<String> uploadFile(File file) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child(POST_IMAGE + file.name);
    UploadTask uploadTask = storageReference.putFile(file);
    return await uploadTask
        .whenComplete(() => null)
        .then((value) => storageReference.getDownloadURL().then((fileURL) {
              return fileURL;
            }));
  }
}
