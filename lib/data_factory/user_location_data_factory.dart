import 'package:geolocator/geolocator.dart';
import 'package:location_repository/location_repository.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/constants/constant.dart';

class DefaultLocationDataFactory {
  generateOtherShopDefaultLocation(Position? currentLocation) {
    if (currentLocation != null) {
      return Location(currentLocation.latitude, currentLocation.longitude);
    } else {
      return Location(DEFAULT_OTHER_SHOP_LOCATION_LATITUDE,
          DEFAULT_OTHER_SHOP_LOCATION_LONGITUDE);
    }
  }

  generateNurseryShopDefaultLocation(Position? currentLocation) {
    if (currentLocation != null) {
      return Location(currentLocation.latitude, currentLocation.longitude);
    } else {
      return Location(DEFAULT_NURSERY_SHOP_LOCATION_LATITUDE,
          DEFAULT_NURSERY_SHOP_LOCATION_LONGITUDE);
    }
  }
}
