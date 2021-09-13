import 'dart:async';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:product_repository/product_repository.dart';
import 'package:progress_state_button/progress_button.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shop_repository/src/models/shop.dart';
import 'package:vivasayi/bloc/bloc_provider/bloc_provider.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/extension/extension.dart';
import 'package:vivasayi/repository/repository.dart';

class CreateProductScreenBloc extends BlocBase {
  final ProductRepository productRepository;
  final ScaleTypeRepository scaleTypeRepository;

  final errorMessage = BehaviorSubject<String>();
  final _productImage = BehaviorSubject<List<String>>();
  final _isProductImageUploading = BehaviorSubject<bool>();
  final _productName = BehaviorSubject<String>();
  final _description = BehaviorSubject<String>();
  final _qty = BehaviorSubject<String>();
  final _price = BehaviorSubject<String>();
  final _scaleType = BehaviorSubject<String>();
  final scaleTypes = BehaviorSubject<List<String>>();
  var progressButtonState = BehaviorSubject<ButtonState>();
  late Shop _shop;
  bool isEdit = false;
  String id = EMPTY_STRING;

  CreateProductScreenBloc(
      {required this.productRepository, required this.scaleTypeRepository});

  initScaleTypeRepository() {
    List<String> scaleTypes = scaleTypeRepository.scaleType();
    changeScaleType(scaleTypes.first);
    changeScaleTypes(scaleTypes);
  }

  setShop(Shop shop) {
    _shop = shop;
    productRepository.setProductCollection(shop.id);
  }

  setProduct(Product product) {
    isEdit = true;
    id = product.id;
    changeProductName(product.name);
    changeProductImage(product.imageUrl);
    changeDescription(product.description);
    changeQty(product.qty);
    changeScaleType(product.scaleType);
    changePrice(product.price);
  }

  @override
  Future<void> dispose() async {
    await errorMessage.drain();
    errorMessage.close();

    await _productImage.drain();
    _productImage.close();

    await _isProductImageUploading.drain();
    _isProductImageUploading.close();

    await _productName.drain();
    _productName.close();

    await _description.drain();
    _description.close();

    await _qty.drain();
    _qty.close();

    await _price.drain();
    _price.close();

    await _scaleType.drain();
    _scaleType.close();

    await scaleTypes.drain();
    scaleTypes.close();

    await progressButtonState.drain();
    progressButtonState.close();
  }

  Stream<String> get productName =>
      _productName.stream.transform(_streamValidateProductName);

  Stream<bool> get isProductImageUploading => _isProductImageUploading.stream
      .transform(_streamValidateIsProductImageUploading);

  Stream<List<String>> get productImage =>
      _productImage.stream.transform(_streamValidateProductImage);

  Stream<String> get description =>
      _description.stream.transform(_streamValidateDescription);

  Stream<String> get qty => _qty.stream.transform(_streamValidateQty);

  Stream<String> get price => _price.stream.transform(_streamValidatePrice);

  Stream<String> get scaleType =>
      _scaleType.stream.transform(_streamValidateScaleType);

  Function(String) get changeErrorMessage => errorMessage.sink.add;

  Function(String) get changeProductName => _productName.sink.add;

  Function(bool) get changeProductImageUploading =>
      _isProductImageUploading.sink.add;

  Function(List<String>) get changeProductImage => _productImage.sink.add;

  Function(String) get changeDescription => _description.sink.add;

  Function(String) get changeQty => _qty.sink.add;

  Function(String) get changePrice => _price.sink.add;

  Function(String) get changeScaleType => _scaleType.sink.add;

  Function(List<String>) get changeScaleTypes => scaleTypes.sink.add;

  Function(ButtonState) get changeProgressButtonState =>
      progressButtonState.sink.add;

  final _streamValidateProductName =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (productName, sink) {
    if (productName.trim().isNotEmpty) {
      sink.add(productName);
    } else {
      sink.addError(ERROR_PRODUCT_NAME);
    }
  });

  final _streamValidateIsProductImageUploading =
      StreamTransformer<bool, bool>.fromHandlers(
          handleData: (isProductImageUploading, sink) {
    sink.add(isProductImageUploading);
  });

  final _streamValidateProductImage =
      StreamTransformer<List<String>, List<String>>.fromHandlers(
          handleData: (data, sink) {
    sink.add(data);
  });

  final _streamValidateDescription =
      StreamTransformer<String, String>.fromHandlers(
          handleData: (description, sink) {
    if (description.trim().isNotEmpty) {
      sink.add(description);
    } else {
      sink.addError(ERROR_DESCRIPTION);
    }
  });

  final _streamValidateQty =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.trim().isNotEmpty) {
      sink.add(data);
    } else {
      sink.addError(ERROR_QTY);
    }
  });

  final _streamValidatePrice =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.trim().isNotEmpty) {
      sink.add(data);
    } else {
      sink.addError(ERROR_PRICE);
    }
  });

  final _streamValidateScaleType =
      StreamTransformer<String, String>.fromHandlers(handleData: (data, sink) {
    if (data.trim().isNotEmpty) {
      sink.add(data);
    } else {
      sink.addError(ERROR_SCALE_TYPE);
    }
  });

  onPickImage(File pickedFile) {
    final path = pickedFile.path;
    uploadImage(path);
  }

  uploadImage(String path) {
    File documentImage = File(path);
    _uploadFileToFireStorage(documentImage);
  }

  _uploadFileToFireStorage(File file) async {
    changeProductImageUploading(true);
    Reference storageReference = FirebaseStorage.instance
        .ref()
        .child(PRODUCT_IMAGE + _shop.id + SYMBOL_FORWARD_SLASH + file.name);
    UploadTask uploadTask = storageReference.putFile(file);
    return await uploadTask
        .whenComplete(() => null)
        .then((value) => storageReference.getDownloadURL().then((fileURL) {
              changeProductImageUploading(false);
              changeProductImage([fileURL]);
              return fileURL;
            }));
  }

  void validateForm() {
    bool isValidProductName = validateProductName();
    bool isValidProductImage = validateProductImage();
    bool isValidQty = validateQty();
    bool isValidPrice = validatePrice();

    if (isValidProductName &&
        isValidProductImage &&
        isValidQty &&
        isValidPrice) {
      if (isEdit) {
        updateProduct();
      } else {
        createProduct();
      }
    }
  }

  createProduct() {
    changeProgressButtonState(ButtonState.loading);
    Product product = generateProduct();
    productRepository
        .addNewProduct(product)
        .whenComplete(() => changeProgressButtonState(ButtonState.success));
  }

  updateProduct() {
    changeProgressButtonState(ButtonState.loading);
    Product product = generateProduct();
    productRepository
        .updateProduct(product)
        .whenComplete(() => changeProgressButtonState(ButtonState.success));
  }

  bool validateProductName() {
    if (_productName.hasValue && _productName.value.trim().isNotEmpty) {
      return true;
    } else {
      _productName.sink.addError(ERROR_PRODUCT_NAME);
      return false;
    }
  }

  bool validateProductImage() {
    if (_productImage.hasValue && _productImage.value.isNotEmpty) {
      return true;
    } else {
      changeErrorMessage(ERROR_PRODUCT_IMAGE);
      //  _productImage.sink.addError(ERROR_PRODUCT_IMAGE);
      return false;
    }
  }

  bool validateQty() {
    if (_qty.hasValue && _qty.value.trim().isNotEmpty) {
      return true;
    } else {
      _qty.sink.addError(ERROR_QTY);
      return false;
    }
  }

  bool validatePrice() {
    if (_price.hasValue && _price.value.trim().isNotEmpty) {
      double? price = double.tryParse(_price.value.trim());
      return price != null;
    } else {
      _price.sink.addError(ERROR_PRICE);
      return false;
    }
  }

  Product generateProduct() {
    Product product = new Product(
        id: id,
        name: _productName.value.trim(),
        imageUrl: _productImage.value,
        description: _description.value,
        qty: _qty.value,
        scaleType: _scaleType.value,
        price: _price.value);
    return product;
  }
}
