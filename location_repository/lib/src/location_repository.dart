import 'package:geocoding/geocoding.dart' as GeoCoding;
import 'package:location_repository/constants/constant.dart';

import 'model/model.dart';

class LocationRepository {
  Future<String> getAddress(Location location) async {
    List<GeoCoding.Placemark> placeMarks =
        await GeoCoding.placemarkFromCoordinates(
            location.latitude, location.longitude);
    String address = EMPTY_STRING;
    if (placeMarks.first.subLocality != null &&
        placeMarks.first.subLocality!.isNotEmpty) {
      address = placeMarks.first.subLocality!;
    } else if (placeMarks.first.locality != null &&
        placeMarks.first.locality!.isNotEmpty) {
      address = placeMarks.first.locality!;
    } else if (placeMarks.first.thoroughfare != null &&
        placeMarks.first.thoroughfare!.isNotEmpty) {
      address = placeMarks.first.thoroughfare!;
    } else if (placeMarks.first.subAdministrativeArea != null &&
        placeMarks.first.subAdministrativeArea!.isNotEmpty) {
      address = placeMarks.first.subAdministrativeArea!;
    }
    return address;
  }
}
