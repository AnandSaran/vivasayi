import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/enum/enum.dart';

extension StringExtension on String {
  String capitalizeFirstChar() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }

  HomeNavigationItemIdEnum toHomeNavigationItemId() {
    switch (this) {
      case 'home':
        return HomeNavigationItemIdEnum.HOME;
      case 'natural_agri':
        return HomeNavigationItemIdEnum.NATURAL_AGRI;
      case 'modern_agri':
        return HomeNavigationItemIdEnum.MODERN_AGRI;
      case 'agri_medicines':
        return HomeNavigationItemIdEnum.AGRI_MEDICINES;
      case 'terrace_garden':
        return HomeNavigationItemIdEnum.TERRACE_GARDEN;
      case 'agri_doctors':
        return HomeNavigationItemIdEnum.AGRI_DOCTORS;
      case 'articles':
        return HomeNavigationItemIdEnum.ARTICLES;
      case 'irrigation':
        return HomeNavigationItemIdEnum.IRRIGATION;
      case 'nursery':
        return HomeNavigationItemIdEnum.NURSERY;
      case 'manure':
        return HomeNavigationItemIdEnum.MANURE;
      case 'machines':
        return HomeNavigationItemIdEnum.MACHINES;
      case 'equips':
        return HomeNavigationItemIdEnum.EQUIPS;
      case 'agricultural_products':
        return HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS;
      case 'create_shop':
        return HomeNavigationItemIdEnum.CREATE_SHOP;
      default:
        return HomeNavigationItemIdEnum.HOME;
    }
  }

  String replaceSpaceWithNewLine() {
    return this.replaceAll(SYMBOL_SPACE, SYMBOL_NEW_LINE);
  }
}
