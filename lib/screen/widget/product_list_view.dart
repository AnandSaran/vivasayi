import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/util/navigation.dart';

class ProductListView extends StatelessWidget {
  final List<Product> products;
  final Shop shop;
  final HomeNavigationItemIdEnum screenId;

  ProductListView({
    Key? key,
    required this.products,
    required this.shop,
    required this.screenId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return storyListView(context, shop, products, screenId);
  }
}

GridView storyListView(BuildContext context, Shop shop, List<Product> products,
    HomeNavigationItemIdEnum storyScreenId) {
  return GridView.count(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    crossAxisCount: 2,
    children: List.generate(products.length, (index) {
      Product product = products[index];
      return Center(
        child: GestureDetector(
          onTap: () {
            onTapListItem(context, shop, product, storyScreenId);
          },
          child: Column(
            children: <Widget>[
              Container(
                height: 125.0,
                width: 125.0,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha(70),
                          offset: const Offset(2.0, 2.0),
                          blurRadius: 2.0)
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    image: DecorationImage(
                      image: NetworkImage(
                        product.imageUrl.first,
                      ),
                      fit: BoxFit.cover,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  product.name,
                ),
              ),
            ],
          ),
        ),
      );
    }),
  );
}

onTapListItem(BuildContext context, Shop shop, Product product,
    HomeNavigationItemIdEnum storyScreenId) {
  Navigation().pushPageWithArgument(
      context,
      ROUTE_PRODUCT_DETAIL_SCREEN,
      CreateProductDataModel(
          storyScreenId: storyScreenId,
          shop: shop,
          product: product,
          isEdit: true));
}
