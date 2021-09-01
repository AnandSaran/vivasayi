import 'package:vivasayi/constants/string_constants.dart';

import 'enum/enum.dart';

class ShopCategory {
  ShopCategory(
      {this.id = HomeNavigationItemIdEnum.HOME,
      this.title = EMPTY_STRING,
      this.isSelected = false});

  HomeNavigationItemIdEnum id = HomeNavigationItemIdEnum.HOME;
  String title = EMPTY_STRING;
  bool isSelected = false;
}
