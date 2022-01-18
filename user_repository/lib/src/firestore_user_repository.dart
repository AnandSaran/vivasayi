import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:user_repository/constants/fire_store_collection.dart';
import 'package:user_repository/constants/fire_store_key.dart';

import 'models/models.dart';

class UserRepository {
  final _userCollection = FirebaseFirestore.instance.collection(collUser);

  Future<User> getUser(User user) async {
    final QuerySnapshot result = await _userCollection
        .where(keyPhoneNumber, isEqualTo: user.phoneNumber)
        .get();
    final List<DocumentSnapshot> docs = result.docs;
    if (docs.isEmpty) {
      return User();
    } else {
      return User.fromSnapshot(docs[0]);
    }
  }

  Future<User> addUser(User user) async {
    return _userCollection.add(user.toJson()).then((value) {
      return User(
          id: value.id,
          uid: user.id,
          name: user.name,
          phoneNumber: user.phoneNumber);
    });
  }
}
