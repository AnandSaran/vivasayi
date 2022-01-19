import 'package:location_repository/constants/string_constant.dart';

enum UserAccessEnum { ALL_ACCESS }

extension UserAccessEnumExtension on UserAccessEnum {
  String get value {
    switch (this) {
      case UserAccessEnum.ALL_ACCESS:
        return 'all_access';
      default:
        return EMPTY_STRING;
    }
  }
}
