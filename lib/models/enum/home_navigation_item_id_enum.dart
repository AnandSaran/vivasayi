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
  CREATE_SHOP,
  CREATE_HOME_BANNER_STORY,
  CREATE_HOME_BANNER_DIRECT_SHOP_ADS,
  CREATE_HOME_BANNER_NEAR_BY_SHOP_ADS,
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
      case HomeNavigationItemIdEnum.CREATE_SHOP:
        return 'create_shop';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_STORY:
        return 'create_home_banner_story';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_DIRECT_SHOP_ADS:
        return 'create_home_banner_direct_shop_ads';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_NEAR_BY_SHOP_ADS:
        return 'create_home_banner_near_by_shop_ads';
      default:
        return EMPTY_STRING;
    }
  }

  String get title {
    switch (this) {
      case HomeNavigationItemIdEnum.HOME:
        return 'Home';
      case HomeNavigationItemIdEnum.NATURAL_AGRI:
        return 'Natural Agri';
      case HomeNavigationItemIdEnum.MODERN_AGRI:
        return 'Modern Agri';
      case HomeNavigationItemIdEnum.AGRI_MEDICINES:
        return 'Agri Medicines';
      case HomeNavigationItemIdEnum.TERRACE_GARDEN:
        return 'Terrace Garden';
      case HomeNavigationItemIdEnum.AGRI_DOCTORS:
        return 'Agri Doctors';
      case HomeNavigationItemIdEnum.ARTICLES:
        return 'Articles';
      case HomeNavigationItemIdEnum.IRRIGATION:
        return 'Irrigation';
      case HomeNavigationItemIdEnum.NURSERY:
        return 'Nursery';
      case HomeNavigationItemIdEnum.MANURE:
        return 'Manure';
      case HomeNavigationItemIdEnum.MACHINES:
        return 'Machines';
      case HomeNavigationItemIdEnum.EQUIPS:
        return 'Equips';
      case HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS:
        return 'Agri Products';
      case HomeNavigationItemIdEnum.CREATE_SHOP:
        return 'Create Shop';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_STORY:
        return 'Create Home banner story';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_DIRECT_SHOP_ADS:
        return 'Create Home banner direct shop ads';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_NEAR_BY_SHOP_ADS:
        return 'Create Home banner near-by shop ads';
      default:
        return EMPTY_STRING;
    }
  }

  String get collectionName {
    switch (this) {
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_STORY:
        return 'home_banner';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_DIRECT_SHOP_ADS:
        return 'home_banner';
      case HomeNavigationItemIdEnum.CREATE_HOME_BANNER_NEAR_BY_SHOP_ADS:
        return 'home_banner';
      default:
        return this.value;
    }
  }
}
