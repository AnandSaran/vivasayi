import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vivasayi/bloc/bloc_provider/bloc_provider.dart';
import 'package:vivasayi/bloc/loading_screen_bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/constants/navigator_constants.dart';
import 'package:vivasayi/models/data_model/home_screen_data_model.dart';
import 'package:vivasayi/screen/widget/widget.dart';
import 'package:vivasayi/util/navigation.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  late LoadingScreenBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LoadingScreenBloc>(context);
    listenBlocStream();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return _widgetLoading();
  }

  _widgetLoading() {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(color: Colors.blue),
            child: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [widgetLogo()],
            ))));
  }

  void listenBlocStream() {
    _bloc.isLogin.stream.listen((event) {
      if (event) {
        showHomeScreen();
      } else {
        showLoginScreen(context);
      }
    });
    listenErrorMessage();
  }

  void listenErrorMessage() {
    _bloc.errorMessage.stream.listen((event) {
      Navigation().showToast(context, event);
    });
  }

  void showHomeScreen() async {
    Navigation()
        .popAndPushNamed(context, ROUTE_HOME, data: getHomeScreenDataModel());
  }

  void showLoginScreen(BuildContext context) async {
    Navigation()
        .popAndPushNamed(context, ROUTE_LOGIN, data: getHomeScreenDataModel());
  }

  HomeScreenDataModel getHomeScreenDataModel() {
    if (ModalRoute.of(context)!.settings.arguments != null) {
      HomeScreenDataModel homeScreenDataModel =
          ModalRoute.of(context)!.settings.arguments as HomeScreenDataModel;
      return homeScreenDataModel;
    } else {
      return HomeScreenDataModel(null);
    }
  }
}
