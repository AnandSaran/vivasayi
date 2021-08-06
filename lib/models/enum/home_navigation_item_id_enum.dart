import 'package:vivasayi/constants/constant.dart';

enum HomeNavigationItemIdEnum {
  HOME,
  NATURAL_AGRI,
  MODERN_AGRI,
  AGRI_MEDICINES,
  TERRACE_GARDEN,
  AGRI_DOCTORS,
  ARTICLES,
  IRRIGATION,
  NURSERY,
  MANURE,
  MACHINES,
  EQUIPS,
  AGRICULTURAL_PRODUCTS,
}

extension HomeNavigationItemIdEnumExtension on HomeNavigationItemIdEnum {
  String get value {
    switch (this) {
      case HomeNavigationItemIdEnum.HOME:
        return 'home';
      case HomeNavigationItemIdEnum.NATURAL_AGRI:
        return 'natural_agri';
      case HomeNavigationItemIdEnum.MODERN_AGRI:
        return 'modern_agri';
      case HomeNavigationItemIdEnum.AGRI_MEDICINES:
        return 'agri_medicines';
      case HomeNavigationItemIdEnum.TERRACE_GARDEN:
        return 'terrace_garden';
      case HomeNavigationItemIdEnum.AGRI_DOCTORS:
        return 'agri_doctors';
      case HomeNavigationItemIdEnum.ARTICLES:
        return 'articles';
      case HomeNavigationItemIdEnum.IRRIGATION:
        return 'irrigation';
      case HomeNavigationItemIdEnum.NURSERY:
        return 'nursery';
      case HomeNavigationItemIdEnum.MANURE:
        return 'manure';
      case HomeNavigationItemIdEnum.MACHINES:
        return 'machines';
      case HomeNavigationItemIdEnum.EQUIPS:
        return 'equips';
      case HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS:
        return 'agricultural_products';
      default:
        return EMPTY_STRING;
    }
  }
}