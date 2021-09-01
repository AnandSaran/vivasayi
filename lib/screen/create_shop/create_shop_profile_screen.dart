import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/models.dart';
import 'package:vivasayi/screen/widget/widgets.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/util/navigation.dart';

class CreateShopProfileScreen extends StatefulWidget {
  final initialPosition = LatLng(-33.8567844, 151.213108);

  @override
  _CreateShopProfileScreenState createState() =>
      _CreateShopProfileScreenState();
}

class _CreateShopProfileScreenState extends State<CreateShopProfileScreen> {
  late CreateShopProfileBloc _bloc;
  final FocusNode _fnPhoneNumber = FocusNode();
  final FocusNode _fnWhatsAppNumber = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<CreateShopProfileBloc>(context);
    _bloc.initShopCategory();
    listenErrorMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.AppColors.toolBarBackgroundColor,
        elevation: TOOLBAR_ELEVATION,
      ),
      body: Container(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              SizedBox(
                height: 15,
              ),
              _widgetShopImageLayout(),
              SizedBox(
                height: 15,
              ),
              _editTextShopName(),
              PhoneNumber(
                  edgeInsets: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  label: PHONE_NUMBER,
                  stream: _bloc.phoneNumber,
                  function: _bloc.changePhoneNumber,
                  textInputAction: TextInputAction.next,
                  fnCurrentFocus: _fnPhoneNumber,
                  fnNextFocus: _fnWhatsAppNumber),
              PhoneNumber(
                  edgeInsets: EdgeInsets.fromLTRB(20, 10, 20, 10),
                  label: WHATSAPP_NUMBER,
                  stream: _bloc.whatsAppNumber,
                  function: _bloc.changeWhatsAppNumber,
                  textInputAction: TextInputAction.done,
                  fnCurrentFocus:_fnWhatsAppNumber,
                  fnNextFocus: null),
              _textShopLocation(),
              _textSelectShopCategory(),
              _listViewShopCategory(),
              _buttonSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  _widgetShopImageLayout() {
    final imageViewWidth = 130.0;
    final imageViewHeight = 130.0;

    return StreamBuilder2<bool, String>(
        streams: Tuple2(_bloc.isShopImageUploading, _bloc.shopImage),
        builder: (context, snapshots) {
          final isShopImageUploading =
              (snapshots.item1.data == null ? false : snapshots.item1.data);
          final isShopImage = (snapshots.item2.data == null
              ? PLACE_HOLDER_SHOP
              : snapshots.item2.data);
          return Center(
              child: InkWell(
            onTap: () {
              onClickShopImage();
            },
            child: Stack(
              children: [
                Container(
                  width: imageViewWidth,
                  height: imageViewHeight,
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 4, color: Theme.AppColors.whiteColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            isShopImage!,
                          ))),
                ),
                Visibility(
                    visible: isShopImageUploading!,
                    child: Container(
                        width: imageViewWidth,
                        height: imageViewHeight,
                        child: Align(
                            alignment: Alignment.center,
                            child: LoadingIndicator()))),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 4,
                          color: Theme.AppColors.whiteColor,
                        ),
                        color: Theme.AppColors.accentColor,
                      ),
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                    )),
              ],
            ),
          ));
        });
  }

  Widget _editTextShopName() {
    return StreamBuilder(
        stream: _bloc.shopName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              onChanged: (companyName) {
                _bloc.changeShopName(companyName);
              },
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_fnPhoneNumber);
              },
              textInputAction: TextInputAction.next,
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  errorText: snapshot.error?.toString(),
                  labelText: SHOP_NAME,
                  labelStyle: TextStyle(fontSize: 14.0),
                  border: OutlineInputBorder()),
            ),
          );
        });
  }

  Widget _textShopLocation() {
    return InkWell(
        onTap: () {
          onClickShopLocation();
        },
        child: Container(
            margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
            decoration: BoxDecoration(
                borderRadius: new BorderRadius.all(Radius.circular(4.0)),
                border: Border.all(color: Colors.grey)),
            child: Text(
              SELECT_YOU_LOCATION,
              style: new TextStyle(
                fontSize: 14.0,
              ),
            )));
  }

  Widget _listViewShopCategory() {
    return StreamBuilder(
        stream: _bloc.shopCategory,
        builder: (context, AsyncSnapshot<List<ShopCategory>> snapshot) {
          return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: snapshot.hasData ? snapshot.data?.length : 0,
              itemBuilder: (BuildContext ctxt, int index) {
                ShopCategory site = snapshot.data![index];
                return Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                    child: new CheckboxListTile(
                      title: new Text(site.title),
                      value: site.isSelected,
                      onChanged: (bool? value) {
                        if (value != null) {
                          site.isSelected = value;
                          _bloc.changeShopCategory(snapshot.data!);
                        }
                      },
                    ));
              });
        });
  }

  Padding _textSelectShopCategory() {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: Text(SELECT_SHOP_CATEGORY,
          style: TextStyle(
            fontSize: 16,
          )),
    );
  }

  Widget _buttonSubmit() {
    return StreamBuilder(
      stream: _bloc.progressButtonState,
      builder: (context, progressButtonState) {
        return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: ProgressButton.icon(
                iconedButtons: {
                  ButtonState.idle: IconedButton(
                      text: ACTION_SUBMIT,
                      icon: Icon(Icons.send, color: Theme.AppColors.iconColor),
                      color: Theme.AppColors.buttonColorIdle),
                  ButtonState.loading: IconedButton(
                      text: ACTION_LOADING,
                      color: Theme.AppColors.buttonColorLoading),
                  ButtonState.fail: IconedButton(
                      text: ACTION_FAILED,
                      icon:
                          Icon(Icons.cancel, color: Theme.AppColors.iconColor),
                      color: Theme.AppColors.buttonColorFail),
                  ButtonState.success: IconedButton(
                      text: ACTION_SUCCESS,
                      icon: Icon(
                        Icons.check_circle,
                        color: Theme.AppColors.iconColor,
                      ),
                      color: Theme.AppColors.buttonColorSuccess)
                },
                onPressed: () {
                  _bloc.validateForm();
                },
                state: progressButtonState.hasData
                    ? progressButtonState.data! as ButtonState
                    : ButtonState.idle));
      },
    );
  }

  onClickShopImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    _bloc.onPickImage(pickedFile);
  }

  onClickShopLocation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          apiKey: API_KEY_MAP, // Put YOUR OWN KEY here.
          onPlacePicked: (result) {
            print(result.formattedAddress);

            if (result.geometry != null) {
              //result.geometry.location;
            }
            Navigator.of(context).pop();
          },
          initialPosition: widget.initialPosition,
          useCurrentLocation: true,
        ),
      ),
    );
  }

  void listenErrorMessage() {
    _bloc.errorMessage.stream.listen((event) {
      Navigation().showToast(context, event);
    });
  }
}
