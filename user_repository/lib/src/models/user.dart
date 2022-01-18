import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/constants/constant.dart';

class User extends Equatable {
  final String id;
  final String uid;
  final String name;
  final String phoneNumber;

  const User({
    id,
    uid,
    name,
    phoneNumber,
  })  : this.id = id ?? emptyString,
        this.uid = name ?? emptyString,
        this.name = name ?? emptyString,
        this.phoneNumber = phoneNumber ?? emptyString;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'uid': uid,
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  @override
  List<Object?> get props => [id, uid, name, phoneNumber];

  @override
  String toString() {
    return 'Shop { id: $id,uid: $uid, name: $name, phoneNumber: $phoneNumber}';
  }

  static User fromJson(Map<String, Object> json) {
    return User(
      id: json['id'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  static User fromJsonString(dynamic json) {
    return User(
      id: json['id'] as String,
      uid: json['uid'] as String,
      name: json['name'] as String,
      phoneNumber: json['phoneNumber'] as String,
    );
  }

  static User fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    return User(
      id: snap.id,
      uid: snap.get('uid'),
      name: snap.get('name'),
      phoneNumber: snap.get('phoneNumber'),
    );
  }

  Map<String, Object?> toDocument() {
    return {
      'uid': uid,
      'name': name,
      'searchName': name.toLowerCase(),
      'phoneNumber': phoneNumber,
    };
  }

  bool get isEmpty => (this.id == emptyString);
}
