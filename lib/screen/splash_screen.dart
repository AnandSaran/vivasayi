import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/screen/widget/widget.dart';
import 'package:vivasayi/style/theme.dart';
import 'package:vivasayi/util/navigation.dart';
import 'package:vivasayi/util/shared_preference.dart';
import 'package:vivasayi/util/util.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    initFirebase(context);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration:
                const BoxDecoration(color: AppColors.splashBackgroundColor),
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

  initFirebase(BuildContext context) async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
    await SharedPreferenceUtil().init();
    Firebase.initializeApp().whenComplete(() {
      Util().delay(showLoadingScreen,
          duration: const Duration(milliseconds: 2000));
    });
  }

  showLoadingScreen() async {
    Navigation().popAndPushNamed(context, ROUTE_LOADING);
  }
}
