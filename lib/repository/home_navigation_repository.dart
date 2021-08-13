import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/models/home_navigation_item.dart';

class HomeNavigationRepository {
  List<HomeNavigationItem> homeNavigationItems() {
    return generateHomeNavigationList();
  }

  generateHomeNavigationList() => [
        HomeNavigationItem(
          id: HomeNavigationItemIdEnum.NATURAL_AGRI,
          title: HomeNavigationItemIdEnum.NATURAL_AGRI.title,
          imagePath: 'asset/svg/natural_agri.svg',
        ),
        HomeNavigationItem(
          id: HomeNavigationItemIdEnum.MODERN_AGRI,
          title: HomeNavigationItemIdEnum.MODERN_AGRI.title,
          imagePath: 'asset/svg/modern_agri.svg',
        ),
        HomeNavigationItem(
          id: HomeNavigationItemIdEnum.AGRI_MEDICINES,
          title: HomeNavigationItemIdEnum.AGRI_MEDICINES.title,
          imagePath: 'asset/svg/agri_medicine.svg',
        ),
        HomeNavigationItem(
          id: HomeNavigationItemIdEnum.TERRACE_GARDEN,
          title: HomeNavigationItemIdEnum.TERRACE_GARDEN.title,
          imagePath: 'asset/svg/terrace_garden.svg',
        ),
        HomeNavigationItem(
          id: HomeNavigationItemIdEnum.AGRI_DOCTORS,
          title: HomeNavigationItemIdEnum.AGRI_DOCTORS.title,
          imagePath: 'asset/svg/doctor.svg',
        ),
        HomeNavigationItem(
          id: HomeNavigationItemIdEnum.ARTICLES,
          title: HomeNavigationItemIdEnum.ARTICLES.title,
          imagePath: 'asset/svg/book.svg',
        ),
        HomeNavigationItem(
            id: HomeNavigationItemIdEnum.HOME,
            title: HomeNavigationItemIdEnum.HOME.title,
            imagePath: 'asset/svg/home.svg',
            orientation: HomeNavigationItemOrientationEnum.BOTTOM,
            isSelected: true),
        HomeNavigationItem(
            id: HomeNavigationItemIdEnum.IRRIGATION,
            title: HomeNavigationItemIdEnum.IRRIGATION.title,
            imagePath: 'asset/svg/irrigation.svg',
            orientation: HomeNavigationItemOrientationEnum.BOTTOM),
        HomeNavigationItem(
            id: HomeNavigationItemIdEnum.NURSERY,
            title: HomeNavigationItemIdEnum.NURSERY.title,
            imagePath: 'asset/svg/nursery.svg',
            orientation: HomeNavigationItemOrientationEnum.BOTTOM),
        HomeNavigationItem(
            id: HomeNavigationItemIdEnum.MANURE,
            title: HomeNavigationItemIdEnum.MANURE.title,
            imagePath: 'asset/svg/shop.svg',
            orientation: HomeNavigationItemOrientationEnum.BOTTOM),
        HomeNavigationItem(
            id: HomeNavigationItemIdEnum.MACHINES,
            title: HomeNavigationItemIdEnum.MACHINES.title,
            imagePath: 'asset/svg/machine.svg',
            orientation: HomeNavigationItemOrientationEnum.BOTTOM),
        HomeNavigationItem(
            id: HomeNavigationItemIdEnum.EQUIPS,
            title: HomeNavigationItemIdEnum.EQUIPS.title,
            imagePath: 'asset/svg/fertilizer.svg',
            orientation: HomeNavigationItemOrientationEnum.BOTTOM),
        HomeNavigationItem(
            id: HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS,
            title: HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS.title,
            imagePath: 'asset/svg/agri_product.svg',
            orientation: HomeNavigationItemOrientationEnum.BOTTOM),
      ];
}
