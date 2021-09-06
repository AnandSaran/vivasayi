import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/bloc/bloc.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/extension/extension.dart';
import 'package:vivasayi/models/models.dart';
import 'package:vivasayi/repository/repository.dart';

class CreateShopProfileScreenBloc extends BlocBase {
  final ShopCategoryRepository shopCategoryRepository;
  final ShopRepository shopRepository;

  final errorMessage = BehaviorSubject<String>();
  final _shopImage = BehaviorSubject<String>();
  final _isShopImageUploading = BehaviorSubject<bool>();
  final _shopName = BehaviorSubject<String>();
  final _phoneNumber = BehaviorSubject<String>();
  final _whatsAppNumber = BehaviorSubject<String>();
  final _locationName = BehaviorSubject<PickResult>();
  final _location = BehaviorSubject<PickResult>();
  final _shopCategory = BehaviorSubject<List<ShopCategory>>();
  var progressButtonState = BehaviorSubject<ButtonState>();

  CreateShopProfileScreenBloc(
      {required this.shopCategoryRepository, required this.shopRepository});

  @override
  Future<void> dispose() async {
    await errorMessage.drain();
    errorMessage.close();

    await _shopImage.drain();
    _shopImage.close();

    await _isShopImageUploading.drain();
    _isShopImageUploading.close();

    await _shopName.drain();
    _shopName.close();

    await _phoneNumber.drain();
    _phoneNumber.close();

    await _whatsAppNumber.drain();
    _whatsAppNumber.close();

    await _locationName.drain();
    _locationName.close();

    await _location.drain();
    _location.close();

    await _shopCategory.drain();
    _shopCategory.close();

    await progressButtonState.drain();
    progressButtonState.close();
  }

  Function(String) get changeErrorMessage => errorMessage.sink.add;

  Stream<String> get shopName =>
      _shopName.stream.transform(_streamValidateShopName);

  Stream<bool> get isShopImageUploading => _isShopImageUploading.stream
      .transform(_streamValidateIsShopImageUploading);

  Stream<String> get shopImage =>
      _shopImage.stream.transform(_streamValidateShopImage);

  Stream<String> get phoneNumber =>
      _phoneNumber.stream.transform(_streamValidateMobileNumber);

  Stream<String> get whatsAppNumber =>
      _whatsAppNumber.stream.transform(_streamValidateWhatsAppMobileNumber);

  Stream<String> get locationName =>
      _locationName.stream.transform(_streamValidateLocationName);

  Stream<GeoFirePoint> get location =>
      _location.stream.transform(_streamValidateLocation);

  Stream<List<ShopCategory>> get shopCategory =>
      _shopCategory.stream.transform(_streamValidateShopCategory);

  Function(String) get changeShopImage => _shopImage.sink.add;

  Function(String) get changeShopName => _shopName.sink.add;

  Function(String) get changePhoneNumber => _phoneNumber.sink.add;

  Function(String) get changeWhatsAppNumber => _whatsAppNumber.sink.add;

  Function(List<ShopCategory>) get changeShopCategory => _shopCategory.sink.add;

  Function(PickResult) get changeLocationName => _locationName.sink.add;

  Function(PickResult) get changeLocation => _location.sink.add;

  Function(bool) get changeShopImageUploading => _isShopImageUploading.sink.add;

  Function(ButtonState) get changeProgressButtonState =>
      progressButtonState.sink.add;

  onMapPick(PickResult mapPickResult) {
    changeLocation(mapPickResult);
    changeLocationName(mapPickResult);
  }

  final _streamValidateShopName =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (shopName, sink) {
    if (shopName.trim().isNotEmpty) {
      sink.add(shopName);
    } else {
      sink.addError(ERROR_SHOP_NAME);
    }
  });

  final _streamValidateIsShopImageUploading =
      StreamTransformer<bool, bool>.fromHandlers(
          handleData: (isShopImageUploading, sink) {
    sink.add(isShopImageUploading);
  });

  final _streamValidateShopImage =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (shopImage, sink) {
    sink.add(shopImage);
  });

  final _streamValidateShopCategory =
      StreamTransformer<List<ShopCategory>, List<ShopCategory>>.fromHandlers(
          handleData: (shopCategory, sink) {
    sink.add(shopCategory);
  });

  final _streamValidateMobileNumber =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (mobileNumber, sink) {
    if (mobileNumber.trim().isNotEmpty &&
        mobileNumber.trim().length > MINIMUM_PHONE_NUMBER_LENGTH) {
      sink.add(mobileNumber);
    } else {
      sink.addError(ERROR_PHONE_NUMBER);
    }
  });

  final _streamValidateWhatsAppMobileNumber =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (whatsAppNumber, sink) {
    if (whatsAppNumber.trim().isNotEmpty &&
        whatsAppNumber.trim().length > MINIMUM_PHONE_NUMBER_LENGTH) {
      sink.add(whatsAppNumber);
    } else {
      sink.addError(ERROR_WHATSAPP);
    }
  });

  final _streamValidateLocation =
      StreamTransformer<PickResult, GeoFirePoint>.fromHandlers(
          handleData: (mapPickResult, sink) {
    var geometry = mapPickResult.geometry;
    if (geometry != null) {
      final location = geometry.location;
      final geo = Geoflutterfire();
      GeoFirePoint geoFirePoint =
          geo.point(latitude: location.lat, longitude: location.lng);
      sink.add(geoFirePoint);
    } else {
      sink.addError(ERROR_SHOP_LOCATION);
    }
  });

  final _streamValidateLocationName =
      StreamTransformer<PickResult, String>.fromHandlers(
          handleData: (mapPickResult, sink) {
    final address = mapPickResult.adrAddress;
    if (address != null) {
      sink.add(address);
    } else {
      sink.addError(ERROR_SHOP_LOCATION);
    }
  });

  initShopCategory() {
    changeShopCategory(shopCategoryRepository.homeNavigationItems());
  }

  onPickImage(XFile? pickedFile) {
    if (pickedFile != null) {
      final path = pickedFile.path;
      uploadImage(path);
    }
  }

  uploadImage(String path) {
    File documentImage = File(path);
    _uploadFileToFireStorage(documentImage);
  }

  _uploadFileToFireStorage(File file) async {
    changeShopImageUploading(true);
    Reference storageReference =
        FirebaseStorage.instance.ref().child(SHOP_IMAGE + file.name);
    UploadTask uploadTask = storageReference.putFile(file);
    return await uploadTask
        .whenComplete(() => null)
        .then((value) => storageReference.getDownloadURL().then((fileURL) {
              changeShopImageUploading(false);
              changeShopImage(fileURL);
              return fileURL;
            }));
  }

  createShop() {
    changeProgressButtonState(ButtonState.loading);
    /*final initialPosition = LatLng(1.3030126608349877, 103.81539875160469);
    final geo = Geoflutterfire();
    GeoFirePoint geoFirePoint = geo.point(
        latitude: initialPosition.latitude,
        longitude: initialPosition.longitude);*/
    List<String> shopCategories = _shopCategory.value
        .where((element) => element.isSelected)
        .map((e) => e.id.value)
        .toList();
    String address = _locationName.value.adrAddress!;
    var geometry = _location.value.geometry!;
    final location = geometry.location;
    final geo = Geoflutterfire();
    GeoFirePoint geoFirePoint =
        geo.point(latitude: location.lat, longitude: location.lng);

    Shop shop = new Shop(
        name: _shopName.value,
        imageUrl: _shopImage.value,
        phoneNumber: _phoneNumber.value,
        whatsAppNumber: _whatsAppNumber.value,
        address: address,
        geoFirePoint: geoFirePoint,
        shopCategories: shopCategories);
    shopRepository
        .addNewShop(shop)
        .whenComplete(() => changeProgressButtonState(ButtonState.success));
  }

  validateForm() {
    bool isValidShopName = validateShopName();
    bool isValidShopImage = validateShopImage();
    bool isValidPhoneNumber = validatePhoneNumber();
    bool isValidWhatsAppNumber = validateWhatsAppNumber();
    bool isValidShopCategory = validateShopCategory();
    bool isValidLocation = validateLocation();

    if (isValidShopName &&
        isValidShopImage &&
        isValidPhoneNumber &&
        isValidWhatsAppNumber &&
        isValidLocation &&
        isValidShopCategory) {
      createShop();
    }
  }

  bool validateShopName() {
    if (_shopName.hasValue && _shopName.value.trim().isNotEmpty) {
      return true;
    } else {
      _shopName.sink.addError(ERROR_SHOP_NAME);
      return false;
    }
  }

  bool validateShopImage() {
    if (_shopImage.hasValue && _shopImage.value.trim().isNotEmpty) {
      return true;
    } else {
      changeErrorMessage(ERROR_SHOP_IMAGE);
      //  _shopImage.sink.addError(ERROR_SHOP_NAME);
      return false;
    }
  }

  bool validatePhoneNumber() {
    if (_phoneNumber.hasValue &&
        _phoneNumber.value.trim().isNotEmpty &&
        _phoneNumber.value.trim().length > MINIMUM_PHONE_NUMBER_LENGTH) {
      return true;
    } else {
      _phoneNumber.sink.addError(ERROR_PHONE_NUMBER);
      return false;
    }
  }

  bool validateWhatsAppNumber() {
    if (_whatsAppNumber.hasValue &&
        _whatsAppNumber.value.trim().isNotEmpty &&
        _whatsAppNumber.value.trim().length > MINIMUM_PHONE_NUMBER_LENGTH) {
      return true;
    } else {
      _whatsAppNumber.sink.addError(ERROR_WHATSAPP);
      return false;
    }
  }

  bool validateShopCategory() {
    if (_shopCategory.value.any((element) => element.isSelected)) {
      return true;
    } else {
      changeErrorMessage(ERROR_SHOP_CATEGORY);
      return false;
    }
  }

  bool validateLocation() {
    if (_location.hasValue) {
      return true;
    } else {
      changeErrorMessage(ERROR_SHOP_CATEGORY);
      return false;
    }
  }
}
