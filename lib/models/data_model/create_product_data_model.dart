import 'package:product_repository/product_repository.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/enum/enum.dart';

class CreateProductDataModel {
  CreateProductDataModel({required this.storyScreenId, shop, product, isEdit})
      : this.shop = shop ??
            Shop(
                id: EMPTY_STRING,
                name: EMPTY_STRING,
                imageUrl: EMPTY_STRING,
                phoneNumber: EMPTY_STRING,
                whatsAppNumber: EMPTY_STRING,
                address: EMPTY_STRING),
        this.product = product ??
            Product(
              id: EMPTY_STRING,
              name: EMPTY_STRING,
              imageUrl: List.empty(),
              description: EMPTY_STRING,
              qty: EMPTY_STRING,
              scaleType: EMPTY_STRING,
              price: EMPTY_STRING,
            ),
        this.isEdit = isEdit ?? false;

  HomeNavigationItemIdEnum storyScreenId;

  Shop shop;

  Product product;

  bool isEdit;
}
