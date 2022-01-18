import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:vivasayi/constants/constant.dart';

class Access extends Equatable {
  final String id;
  final List<String> mobile;

  const Access({id, mobile})
      : this.id = id ?? EMPTY_STRING,
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

  static Access fromJson(Map<String, Object> json) {
    return Access(
      id: json['id'] as String,
      mobile: json['mobile'] as List<String>,
    );
  }

  static Access fromSnapshot(DocumentSnapshot snap) {
    if (snap.data() == null) throw Exception();
    final data = snap.data()! as Map<String, dynamic>;

    return Access(
      id: snap.id,
      mobile: data.containsKey('mobile')
          ? List.from(data['mobile'])
          : emptyStringList,
    );
  }
}
