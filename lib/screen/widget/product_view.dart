import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/product_list_view.dart';

Widget productView(Shop shop, List<Product> products, BuildContext context,
    HomeNavigationItemIdEnum id) {
  return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Flexible(
              child: SingleChildScrollView(
            child: ProductListView(
              shop: shop,
              products: products,
              screenId: id,
            ),
          ))));
}
