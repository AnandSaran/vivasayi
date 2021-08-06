/*
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/extension/extension.dart';
import 'package:zefyr/zefyr.dart';

class MyAppZefyrImageDelegate implements ZefyrImageDelegate<ImageSource> {
  @override
  ImageSource get cameraSource => ImageSource.camera;

  @override
  ImageSource get gallerySource => ImageSource.gallery;

  @override
  Future<String> pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 20);
    if (pickedFile == null) return EMPTY_STRING;
    File file = File(pickedFile.path);
    return _uploadFile(file);
  }

  @override
  Widget buildImage(BuildContext context, String key) {
    /// Create standard [FileImage] provider. If [key] was an HTTP link
    /// we could use [NetworkImage] instead.
  return  CachedNetworkImage(
      placeholder: (context, url) =>
      const CircularProgressIndicator(),
      imageUrl: key,
    );
    }

  Future<String> _uploadFile(File file) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child(POST_IMAGE + file.name);
    UploadTask uploadTask = storageReference.putFile(file);
    return await uploadTask.whenComplete(() => null)
        .then((value) => storageReference.getDownloadURL().then((fileURL) {
              return fileURL;
            }));
  }
}
*/
