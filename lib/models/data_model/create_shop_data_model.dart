import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/enum/enum.dart';

class CreateShopDataModel {
  CreateShopDataModel({required this.storyScreenId, shop, isEdit})
      : this.shop = shop ??
            Shop(
                id: EMPTY_STRING,
                name: EMPTY_STRING,
                imageUrl: EMPTY_STRING,
                phoneNumber: EMPTY_STRING,
                whatsAppNumber: EMPTY_STRING,
                address: EMPTY_STRING,
                shopCategories: List.empty()),
        this.isEdit = isEdit ?? false;

  HomeNavigationItemIdEnum storyScreenId;

  Shop shop;

  bool isEdit;
}
