import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/home_screen_data_model.dart';
import 'package:vivasayi/screen/widget/loading_indicator.dart';
import 'package:vivasayi/util/navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late SplashScreenBloc _bloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<SplashScreenBloc>(context);
    listenBlocStream();
    _bloc.enableLocationService();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingIndicator();
  }

  void listenBlocStream() {
    listenErrorMessage();
    listenIsLocationServiceEnable();
    listenLocationPermissionDenied();
    listenLocation();
  }

  void listenErrorMessage() {
    _bloc.errorMessage.stream.listen((event) {
      Navigation().showToast(context, event);
    });
  }

  void listenIsLocationServiceEnable() {
    _bloc.isLocationServiceEnabled.stream.listen((event) {
      if (event) {
        _bloc.enableLocationPermission();
      } else {
        showHomeScreen();
      }
    });
  }

  void listenLocation() {
    _bloc.location.stream.listen((event) {
      print(event);
      showHomeScreen(currentLocation: event);
    });
  }

  void showHomeScreen({Position? currentLocation}) {
    Navigation().popAndPushNamed(context, ROUTE_HOME,
        data: HomeScreenDataModel(currentLocation));
  }

  void listenLocationPermissionDenied() {
    _bloc.locationPermissionDenied.stream.listen((event) {
      if (event) {
        // openAppSettings();
        showHomeScreen();
      }
    });
  }
}
