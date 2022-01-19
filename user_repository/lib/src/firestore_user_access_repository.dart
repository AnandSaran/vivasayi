import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/constants/fire_store_collection.dart';
import 'package:user_repository/constants/fire_store_doc.dart';
import 'package:user_repository/src/models/user_access.dart';

import 'models/models.dart';

class UserAccessRepository {
  final _userAccessCollection =
      FirebaseFirestore.instance.collection(collUserAccess);

  Stream<List<UserAccess>> getUserAccess() {
    return _userAccessCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => UserAccess.fromSnapshot(doc)).toList();
    });
  }
}
