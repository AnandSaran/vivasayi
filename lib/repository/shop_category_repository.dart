import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/models/home_navigation_item.dart';
import 'package:vivasayi/models/models.dart';

class ShopCategoryRepository {
  List<ShopCategory> homeNavigationItems() {
    return generateShopCategoryList();
  }

  generateShopCategoryList() => [
        ShopCategory(
            id: HomeNavigationItemIdEnum.IRRIGATION,
            title: HomeNavigationItemIdEnum.IRRIGATION.title),
        ShopCategory(
            id: HomeNavigationItemIdEnum.NURSERY,
            title: HomeNavigationItemIdEnum.NURSERY.title),
        ShopCategory(
            id: HomeNavigationItemIdEnum.MANURE,
            title: HomeNavigationItemIdEnum.MANURE.title),
        ShopCategory(
            id: HomeNavigationItemIdEnum.MACHINES,
            title: HomeNavigationItemIdEnum.MACHINES.title),
        ShopCategory(
            id: HomeNavigationItemIdEnum.EQUIPS,
            title: HomeNavigationItemIdEnum.EQUIPS.title),
        ShopCategory(
            id: HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS,
            title: HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS.title),
      ];
}
