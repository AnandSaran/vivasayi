import 'dart:collection';

import 'package:flutter_quill/flutter_quill.dart';

extension QuillDocumentExtension on Document {
  String get title {
    return stringAt(1);
  }

  String get subtitle {
    return stringAt(2);
  }

  String get imageUrl {
    return image();
  }

  String stringAt(int stringAtPosition) {
    int position = 0;
    String result = '';
    List<Operation> operations = this.toDelta().toList();
    for (var element in operations) {
      if (element.value is String &&
          element.value.toString().trim().isNotEmpty) {
        position = position + 1;

        if (position == stringAtPosition) {
          result = element.value.toString().trim();
          break;
        }
      }
    }
    return result;
  }

  String image() {
    try {
      List<Operation> operation = this.toDelta().toList();
      var element =
          operation.firstWhere((element) => element.value is LinkedHashMap);
      LinkedHashMap map = element.value;
      var value =
          map.entries.firstWhere((element) => element.key == 'image').value;
      return value;
    } catch (IterableElementError) {
      return '';
    }
  }
}
