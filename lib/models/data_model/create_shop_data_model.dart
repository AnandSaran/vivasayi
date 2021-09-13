import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/enum/enum.dart';

class CreateProductDataModel {
  CreateProductDataModel({required this.storyScreenId, shop, isEdit})
      : this.shop = shop ??
            Shop(
                id: EMPTY_STRING,
                name: EMPTY_STRING,
                imageUrl: EMPTY_STRING,
                phoneNumber: EMPTY_STRING,
                whatsAppNumber: EMPTY_STRING,
                address: EMPTY_STRING),
        this.isEdit = isEdit ?? false;

  HomeNavigationItemIdEnum storyScreenId;

  Shop shop;

  bool isEdit;
}
