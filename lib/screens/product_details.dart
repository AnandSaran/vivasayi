import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:product_repository/product_repository.dart';
import 'package:provider/src/provider.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivasayi/bloc/create_product_access_control/create_product_access_control.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/create_product_data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screens/prod_details_widget.dart';
import 'package:vivasayi/style/theme.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/util/navigation.dart';

class ProductDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductDetails();
}

class _ProductDetails extends State<ProductDetails> {
  late CreateProductDataModel createProductDataModel;
  late Shop shop;
  late Product product;
  late HomeNavigationItemIdEnum storyScreenId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createProductDataModel =
        ModalRoute.of(context)!.settings.arguments as CreateProductDataModel;
    shop = createProductDataModel.shop;
    product = createProductDataModel.product;
    storyScreenId = createProductDataModel.storyScreenId;
    context
        .read<CreateProductAccessControlBloc>()
        .add(IsShowCreateProductAccess(shop.phoneNumber));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          product.name,
          style: (TextStyle(color: Colors.white)),
        ),
        backgroundColor: AppColors.toolBarBackgroundColor,
        elevation: 5.0,
        actions: <Widget>[
          editProductMenuWidget(),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: ProductDetailsContent(product)),
          Container(
            height: 60,
            color: AppColors.whiteColor,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: OutlinedButton.icon(
                        icon: Icon(
                          Icons.call,
                          color: Colors.green,
                        ),
                        label: Text(
                          CALL_NOW,
                          style: (TextStyle(color: Colors.green, fontSize: 15)),
                        ),
                        onPressed: () {
                          launch(('tel://${shop.phoneNumber}'));
                        },
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(width: 3.0, color: Colors.green),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      child: ElevatedButton.icon(
                        label: Text(WHATSAPP),
                        icon: Image.asset('asset/png/logo_whatsapp.png',
                            width: 40, height: 40, color: Colors.white),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          textStyle: TextStyle(
                            color: Colors.green,
                            fontSize: 15,
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(10.0),
                          ),
                        ),
                        onPressed: () {
                          print("whatsAppOpen");
                          whatsAppOpen();
                        },
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void whatsAppOpen() async {
    await FlutterLaunch.launchWhatsapp(
        phone: shop.phoneNumber, message: "Hello");
  }

  onTapEdit(CreateProductDataModel createProductDataModel) {
    createProductDataModel.isEdit = true;
    Navigation().popAndPushNamed(context, ROUTE_CREATE_PRODUCT,
        data: createProductDataModel);
  }

  editProductMenuWidget() {
    return BlocBuilder<CreateProductAccessControlBloc,
        CreateProductAccessControlState>(builder: (context, state) {
      final isShow = state is CreateProductAccessControlLoaded && state.isShow;
      return Visibility(
        visible: isShow,
        child: IconButton(
          icon: Icon(
            Icons.edit,
            color: Theme.AppColors.iconColor,
          ),
          onPressed: () {
            onTapEdit(createProductDataModel);
          },
        ),
      );
    });
  }
}
