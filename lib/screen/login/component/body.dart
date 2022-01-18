import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location/location.dart';
import 'package:vivasayi/bloc/bloc_provider/bloc_provider.dart';
import 'package:vivasayi/bloc/login_screen_bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/data_factory/data_factory.dart';
import 'package:vivasayi/models/data_model/home_screen_data_model.dart';
import 'package:vivasayi/screen/widget/phone_number.dart';
import 'package:vivasayi/screen/widget/widget.dart';
import 'package:vivasayi/style/theme.dart';
import 'package:vivasayi/util/navigation.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

import 'background.dart';

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late LoginScreenBloc _bloc;
  late Size size;
  final FocusNode _fnPhoneNumber = FocusNode();

  @override
  void initState() {
    super.initState();
    _bloc = BlocProvider.of<LoginScreenBloc>(context);
    listenBlocStream();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size;
  }

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              _textTitle(),
              widgetDividerSpace(height: size.height * 0.03),
              widgetLogo(),
              widgetDividerSpace(height: size.height * 0.03),
              PhoneNumber(
                  edgeInsets: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  label: labelPhoneNumber,
                  stream: _bloc.phoneNumber,
                  function: _bloc.changePhoneNumber,
                  textInputAction: TextInputAction.next,
                  fnCurrentFocus: _fnPhoneNumber,
                  fnNextFocus: null),
              widgetDividerSpace(height: size.height * 0.01),
              _buttonSubmit(),
            ]),
      ),
    );
  }

  Widget _textTitle() {
    return  Text(
      APP_NAME,
      style: TextStyle(color: Colors.black, fontSize: 26),
    );
  }

  Widget _buttonSubmit() {
    return StreamBuilder(
        stream: _bloc.progressButtonState,
        builder: (context, progressButtonState) {
          return StreamBuilder(
            stream: _bloc.isOtpVerified,
            builder: (context, snapshot) {
              bool isOtpVerified =
                  snapshot.hasData ? snapshot.data as bool : false;
              if (isOtpVerified && !progressButtonState.hasData) {
                onClickLoginFormSubmit(isOtpVerified);
              }
              return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: ProgressButton.icon(
                      iconedButtons: {
                        ButtonState.idle: IconedButton(
                            text:
                                isOtpVerified ? labelSubmit : labelVerifyPhone,
                            icon: const Icon(Icons.send,
                                color: AppColors.iconColorWhite),
                            color: AppColors.buttonColorIdle),
                        ButtonState.loading: IconedButton(
                            text: labelLoading,
                            color: AppColors.buttonColorLoading),
                        ButtonState.fail: IconedButton(
                            text: labelFailed,
                            icon: const Icon(Icons.cancel,
                                color: AppColors.iconColorWhite),
                            color: AppColors.buttonColorFail),
                        ButtonState.success: IconedButton(
                            text: labelSuccess,
                            icon: const Icon(
                              Icons.check_circle,
                              color: AppColors.iconColorWhite,
                            ),
                            color: AppColors.buttonColorSuccess)
                      },
                      onPressed: () {
                        onClickLoginFormSubmit(isOtpVerified);
                      },
                      state: progressButtonState.hasData
                          ? progressButtonState.data as ButtonState
                          : ButtonState.idle));
            },
          );
        });
  }

  void onClickLoginFormSubmit(bool isOtpVerified) {
    isOtpVerified ? _bloc.validateLoginForm() : _bloc.generateOtp();
  }

  void listenBlocStream() {
    listenIsShowOtpDialog();
    listenLoginSuccess();
    listenErrorMessage();
    listUserChange();
  }

  listenIsShowOtpDialog() {
    _bloc.isShowOtpDialog.stream.listen((event) {
      if (event) {
        _showOtpDialog();
      } else {
        _closeOtpDialog();
      }
    });
  }

  void listenLoginSuccess() {
    _bloc.logInSuccess.stream.listen((event) {
      if (event) {
        showHomeScreen();
      } else {
        showToast(context, errorSomethingWentWrong);
        _bloc.changeProgressButtonState(ButtonState.fail);
      }
    });
  }

  void listenErrorMessage() {
    _bloc.errorMessage.stream.listen((event) {
      showToast(context, event);
    });
  }

  _showOtpDialog() {
    _bloc.resetOtp();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            title:  Text(titleVerify),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                _editTextOtp(),
                _buttonOtpSubmit(),
              ],
            ));
      },
    );
  }

  _closeOtpDialog() {
    Navigation().pop(context);
  }

  Widget _editTextOtp() {
    return StreamBuilder(
        stream: _bloc.otp,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: TextFormField(
              textInputAction: TextInputAction.done,
              onChanged: (otp) {
                _bloc.changeOtp(otp);
              },
              maxLines: 1,
              maxLength: 6,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  errorText: snapshot.error != null
                      ? snapshot.error as String
                      : EMPTY_STRING,
                  errorMaxLines: 10,
                  labelText: hintEnterOtp,
                  border: const OutlineInputBorder()),
            ),
          );
        });
  }

  Widget _buttonOtpSubmit() {
    return ElevatedButton(
      onPressed: () => {onClickOtpSubmit()},
      style: ElevatedButton.styleFrom(
          primary: AppColors.buttonColorIdle,
          textStyle: const TextStyle(fontSize: 15)),
      child: const Text(
        labelSubmit,
      ),
    );
  }

  onClickOtpSubmit() {
    _bloc.otpSubmit();
  }

  void listUserChange() {
    _bloc.isLogin.stream.listen((event) {
      if (event) {
        showHomeScreen();
      }
    });
  }

  void showHomeScreen() async {
    Navigation().popAndPushNamed(context, ROUTE_HOME,
        data: getHomeScreenDataModel());
  }

  HomeScreenDataModel getHomeScreenDataModel() {
    if(ModalRoute.of(context)!.settings.arguments!=null) {
      HomeScreenDataModel homeScreenDataModel =
      ModalRoute
          .of(context)!
          .settings
          .arguments as HomeScreenDataModel;
      return homeScreenDataModel;
    }else{
      return HomeScreenDataModel(null);
    }
  }
}
