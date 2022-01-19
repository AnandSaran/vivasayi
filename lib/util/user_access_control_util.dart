import 'package:user_repository/user_repository.dart';
import 'package:vivasayi/models/enum/user_access_enum.dart';

class UserAccessControlUtil {
  static final UserAccessControlUtil _userAccessControlUtil =
      UserAccessControlUtil._internal();

  factory UserAccessControlUtil() {
    return _userAccessControlUtil;
  }

  UserAccessControlUtil._internal();

  bool isValidToHomeAccessIcon(
      String phoneNumber, List<UserAccess> userAccess) {
    return userAccess.any((element) =>
        element.id == UserAccessEnum.ALL_ACCESS.value &&
        element.mobile.contains(phoneNumber));
  }

  bool isValidToCreateProductAccessIcon(
      String userPhoneNumber, String shopPhoneNumber) {
    return userPhoneNumber == shopPhoneNumber;
  }
}
