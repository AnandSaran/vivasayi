import 'package:vivasayi/constants/string_constants.dart';

import 'enum/enum.dart';

class HomeNavigationItem {
  HomeNavigationItem(
      {this.title = EMPTY_STRING,
      this.imagePath = EMPTY_STRING,
      this.orientation = HomeNavigationItemOrientationEnum.TOP,
      this.isSelected = false});

  String title = EMPTY_STRING;
  String imagePath = EMPTY_STRING;
  HomeNavigationItemOrientationEnum orientation =
      HomeNavigationItemOrientationEnum.TOP;
  bool isSelected = false;
}
