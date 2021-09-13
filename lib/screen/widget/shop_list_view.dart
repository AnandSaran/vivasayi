import 'package:flutter/material.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/create_product_data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/util/navigation.dart';

class ShopListView extends StatelessWidget {
  final List<Shop> shops;
  final HomeNavigationItemIdEnum screenId;

  ShopListView({
    Key? key,
    required this.shops,
    required this.screenId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return storyListView(context, shops, screenId);
  }
}

GridView storyListView(BuildContext context, List<Shop> shops,
    HomeNavigationItemIdEnum storyScreenId) {
  return GridView.count(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    scrollDirection: Axis.vertical,
    crossAxisCount: 2,
    children: List.generate(shops.length, (index) {
      Shop shop = shops[index];
      return Center(
          child: InkWell(
        onTap: () {
          onTapListItem(context, shop, storyScreenId);
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
                      shop.imageUrl,
                    ),
                    fit: BoxFit.cover,
                  )),
            ),
            Text(
              shop.name,
              style: Theme.of(context).textTheme.headline5,
            ),
          ],
        ),
      ));
    }),
  );
}

onTapListItem(
    BuildContext context, Shop shop, HomeNavigationItemIdEnum storyScreenId) {
  Navigation().pushPageWithArgument(
      context,
      ROUTE_CREATE_PRODUCT,
      CreateProductDataModel(
          storyScreenId: storyScreenId, shop: shop, isEdit: true));
}
