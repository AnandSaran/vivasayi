import 'package:flutter/cupertino.dart';

abstract class ZefyrImageDelegate<S> {
  /// Unique key to identify camera source.
  S get cameraSource;

  /// Unique key to identify gallery source.
  S get gallerySource;

  /// Builds image widget for specified image [key].
  ///
  /// The [key] argument contains value which was previously returned from
  /// [pickImage].
  Widget buildImage(BuildContext context, String key);

  /// Picks an image from specified [source].
  ///
  /// Returns unique string key for the selected image. Returned key is stored
  /// in the document.
  ///
  /// Depending on your application returned key may represent a path to
  /// an image file on user's device, an HTTP link, or an identifier generated
  /// by a file hosting service like AWS S3 or Google Drive.
  Future<String> pickImage(S source);
}