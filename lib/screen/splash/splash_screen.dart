import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/home_screen_data_model.dart';
import 'package:vivasayi/screen/widget/loading_indicator.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/style/theme.dart';
import 'package:vivasayi/util/navigation.dart';
import 'package:vivasayi/util/shared_preference.dart';

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
    initFirebase(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: new BoxDecoration(color: AppColors.appGreen),
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    widgetLogo()
                    //your widgets here...
                  ],
                ))));
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
        showLoadingScreen();
      }
    });
  }

  void listenLocation() {
    _bloc.location.stream.listen((event) {
      print(event);
      showLoadingScreen(currentLocation: event);
    });
  }

  void showLoadingScreen({Position? currentLocation}) {
    Navigation().popAndPushNamed(context, ROUTE_LOADING,
        data: HomeScreenDataModel(currentLocation));
  }

  void listenLocationPermissionDenied() {
    _bloc.locationPermissionDenied.stream.listen((event) {
      if (event) {
        showLoadingScreen();
      }
    });
  }

  initFirebase(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    await SharedPreferenceUtil().init();
    Firebase.initializeApp().whenComplete(() => requestLocation());
  }

  void requestLocation() async {
    await Future.delayed(Duration(milliseconds: 2000));
    _bloc.enableLocationService();
  }
}
