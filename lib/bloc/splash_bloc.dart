import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import 'package:vivasayi/bloc/bloc_provider/bloc_provider.dart';

class SplashScreenBloc extends BlocBase {
  final errorMessage = BehaviorSubject<String>();
  final isLocationServiceEnabled = BehaviorSubject<bool>();
  final location = BehaviorSubject<Position>();
  final locationPermissionDenied = BehaviorSubject<bool>();

  @override
  Future<void> dispose() async {
    await errorMessage.drain();
    errorMessage.close();

    await isLocationServiceEnabled.drain();
    isLocationServiceEnabled.close();

    await location.drain();
    location.close();

    await locationPermissionDenied.drain();
    locationPermissionDenied.close();
  }

  Function(String) get changeErrorMessage => errorMessage.sink.add;

  Function(bool) get changeLocationServiceEnabled =>
      isLocationServiceEnabled.sink.add;

  Function(Position) get changeLocation => location.sink.add;

  Function(bool) get changeLocationPermissionDenied =>
      locationPermissionDenied.sink.add;

  Future<void> enableLocationService() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await Location().requestService();
    }
    print("serviceEnabled " + serviceEnabled.toString());
    changeLocationServiceEnabled(serviceEnabled);
  }

  enableLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        changeLocationPermissionDenied(true);
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      changeLocationPermissionDenied(true);
      return;
    }

    Position position = await Geolocator.getCurrentPosition();
    changeLocation(position);
  }
}
