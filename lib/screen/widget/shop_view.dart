import 'package:flutter/material.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/shop_list_view.dart';

Widget shopView(
    List<Shop> shops, BuildContext context, HomeNavigationItemIdEnum id) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
      child:  ShopListView(
          shops: shops,
          screenId: id,
    ),
  );
}
