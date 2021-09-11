import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multiple_stream_builder/multiple_stream_builder.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/screen/widget/loading_indicator.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/util/navigation.dart';

class CreateProductScreen extends StatefulWidget {
  const CreateProductScreen({Key? key}) : super(key: key);

  @override
  _CreateProductScreenState createState() => _CreateProductScreenState();
}

class _CreateProductScreenState extends State<CreateProductScreen> {
  late CreateProductScreenBloc _bloc;
  final FocusNode _fnDescription = FocusNode();
  final FocusNode _fnQty = FocusNode();
  final FocusNode _fnPrice = FocusNode();
  final FocusNode _fnScaleType = FocusNode();
  final rgeDecimalValue = RegExp('[0-9]+[.]?[0-9]*');

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = BlocProvider.of<CreateProductScreenBloc>(context);
    _bloc.initScaleTypeRepository();
    listenErrorMessage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(CREATE_PRODUCT),
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
              _widgetProductImageLayout(),
              SizedBox(
                height: 15,
              ),
              _editTextProductName(),
              _productScaleView(),
              _editTextProductPrice(),
              _editTextProductDescription(),
              _buttonSubmit(),
            ],
          ),
        ),
      ),
    );
  }

  _widgetProductImageLayout() {
    final loadingIndicatorWidth = 130.0;
    final loadingIndicatorHeight = 130.0;

    return StreamBuilder2<bool, List<String>>(
        streams: Tuple2(_bloc.isProductImageUploading, _bloc.productImage),
        builder: (context, snapshots) {
          final isShopImageUploading =
              (snapshots.item1.data == null ? false : snapshots.item1.data);
          final shopImage = (snapshots.item2.data == null
              ? PLACE_HOLDER_PRODUCT
              : snapshots.item2.data![0]);
          return Center(
              child: InkWell(
                  onTap: () {
                    onClickProductImage();
                  },
                  child: AspectRatio(
                      aspectRatio: 3 / 2,
                      child: Stack(fit: StackFit.expand, children: [
                        CachedNetworkImage(imageUrl: shopImage),
                        Visibility(
                            visible: isShopImageUploading!,
                            child: Container(
                                width: loadingIndicatorWidth,
                                height: loadingIndicatorHeight,
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
                      ]))));
        });
  }

  Widget _editTextProductName() {
    return StreamBuilder(
        stream: _bloc.productName,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              onChanged: (text) {
                _bloc.changeProductName(text);
              },
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_fnQty);
              },
              textInputAction: TextInputAction.next,
              maxLines: 1,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  errorText: snapshot.error?.toString(),
                  labelText: PRODUCT_NAME,
                  labelStyle: TextStyle(fontSize: 14.0),
                  border: OutlineInputBorder()),
            ),
          );
        });
  }

  Widget _editTextProductDescription() {
    return StreamBuilder(
        stream: _bloc.description,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              onChanged: (text) {
                _bloc.changeDescription(text);
              },
              focusNode: _fnDescription,
              onFieldSubmitted: (term) {},
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              maxLines: 5,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                  errorText: snapshot.error?.toString(),
                  labelText: DESCRIPTION,
                  labelStyle: TextStyle(fontSize: 14.0),
                  border: OutlineInputBorder()),
            ),
          );
        });
  }

  Widget _editTextProductPrice() {
    return StreamBuilder(
        stream: _bloc.price,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: TextFormField(
              onChanged: (text) {
                _bloc.changePrice(text);
              },
              focusNode: _fnPrice,
              onFieldSubmitted: (term) {
                FocusScope.of(context).requestFocus(_fnDescription);
              },
              textInputAction: TextInputAction.next,
              maxLines: 1,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(rgeDecimalValue),
              ],
              decoration: InputDecoration(
                  errorText: snapshot.error?.toString(),
                  labelText: PRICE,
                  labelStyle: TextStyle(fontSize: 14.0),
                  border: OutlineInputBorder()),
            ),
          );
        });
  }

  Widget _editTextProductQty() {
    return StreamBuilder(
        stream: _bloc.qty,
        builder: (context, AsyncSnapshot<String> snapshot) {
          return TextFormField(
            onChanged: (text) {
              _bloc.changeQty(text);
            },
            focusNode: _fnQty,
            onFieldSubmitted: (term) {
              FocusScope.of(context).requestFocus(_fnPrice);
            },
            textInputAction: TextInputAction.next,
            maxLines: 1,
            textCapitalization: TextCapitalization.sentences,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.allow(rgeDecimalValue),
            ],
            decoration: InputDecoration(
                errorText: snapshot.error?.toString(),
                labelText: QTY,
                labelStyle: TextStyle(fontSize: 14.0),
                border: OutlineInputBorder()),
          );
        });
  }

  _productScaleView() {
    return Padding(
        padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Expanded(
              child: _editTextProductQty(),
              flex: 2,
            ),
            SizedBox(width: 20),
            Expanded(
              child: _ddScaleType(),
              flex: 1,
            )
          ],
        ));
  }

  _ddScaleType() {
    return StreamBuilder2<String, List<String>>(
        streams: Tuple2(_bloc.scaleType, _bloc.scaleTypes),
        builder: (context, snapshots) {
          final scaleType = (snapshots.item1.data == null
              ? SCALE_TYPE_SELECT
              : snapshots.item1.data);
          List<String> scaleTypes = (snapshots.item2.data == null
              ? [SCALE_TYPE_SELECT]
              : snapshots.item2.data!);
          return Container(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                border: Border.all(
                    color: Colors.grey, style: BorderStyle.solid, width: 1),
              ),
              child: DropdownButton<String>(
                value: scaleType,
                icon: const Icon(Icons.keyboard_arrow_down),
                iconSize: 24,
                elevation: 16,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    _bloc.changeScaleType(newValue);
                  }
                },
                items: scaleTypes.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ));
        });
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

  void listenErrorMessage() {
    _bloc.errorMessage.stream.listen((event) {
      Navigation().showToast(context, event);
    });
  }

  onClickProductImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      File? croppedFile = await ImageCropper.cropImage(
          sourcePath: pickedFile.path,
          aspectRatioPresets: [
            CropAspectRatioPreset.ratio3x2,
          ],
          androidUiSettings: AndroidUiSettings(
              toolbarTitle: CROP_IMAGE,
              toolbarColor: Theme.AppColors.toolBarBackgroundColor,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              lockAspectRatio: true),
          iosUiSettings: IOSUiSettings(
            minimumAspectRatio: 1.0,
          ));
      if (croppedFile != null) {
        _bloc.onPickImage(croppedFile);
      }
    }
  }
}
