import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/constants/constant.dart';

class UserAccess extends Equatable {
  final String id;
  final List<String> mobile;

  const UserAccess({id, mobile})
      : this.id = id ?? emptyString,
        this.mobile = mobile ?? emptyStringList;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'mobile': mobile,
    };
  }

  @override
  List<Object?> get props => [
        id,
        mobile,
      ];

  @override
  String toString() {
    return 'Access { id: $id, mobile: $mobile}';
  }

  static UserAccess fromJson(Map<String, Object> json) {
    return UserAccess(
      id: json['id'] as String,
      mobile: json['mobile'] as List<String>,
    );
  }

  static UserAccess fromSnapshot(DocumentSnapshot snap) {
    if (snap.data() == null) throw Exception();
    final data = snap.data()! as Map<String, dynamic>;

    return UserAccess(
      id: snap.id,
      mobile: data.containsKey('mobile')
          ? List.from(data['mobile']).cast<String>()
          : emptyStringList,
    );
  }
}
