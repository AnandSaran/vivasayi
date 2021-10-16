import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_launch/flutter_launch.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vivasayi/bloc/product/products.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/create_product_data_model.dart';
import 'package:vivasayi/models/data_model/create_shop_data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/loading_indicator.dart';
import 'package:vivasayi/screen/widget/product_view.dart';
import 'package:vivasayi/style/theme.dart';
import 'package:vivasayi/style/theme.dart' as AppTheme;
import 'package:vivasayi/util/navigation.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductBloc _bloc;
  late CreateShopDataModel createShopDataModel;
  late Shop shop;
  late HomeNavigationItemIdEnum screenId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createShopDataModel =
        ModalRoute.of(context)!.settings.arguments as CreateShopDataModel;
    shop = createShopDataModel.shop;
    screenId = createShopDataModel.storyScreenId;
    _bloc = BlocProvider.of<ProductBloc>(context);
    _bloc.add(SetShop(shop));
    _bloc.add(LoadProduct(screenId.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.toolBarBackgroundColor,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          shop.name,
          style: (TextStyle(color: Colors.white)),
        ),
        elevation: TOOLBAR_ELEVATION,
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: AppTheme.AppColors.iconColor,
            ),
            onPressed: () => showCreateProductScreen(createShopDataModel),
          ),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Container(
                        color: Colors.white,
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Container(
                                  height: 125.0,
                                  width: 125.0,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withAlpha(70),
                                            offset: const Offset(2.0, 2.0),
                                            blurRadius: 2.0)
                                      ],
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          shop.imageUrl,
                                        ),
                                        fit: BoxFit.cover,
                                      )),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    shop.name,
                                    style:
                                        Theme.of(context).textTheme.headline5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          _buildProductListView(),
                        ])))),
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
                            style:
                                (TextStyle(color: Colors.green, fontSize: 15)),
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
      ),
    );
  }

  void whatsAppOpen() async {
    await FlutterLaunch.launchWhatsapp(
        phone: shop.phoneNumber, message: "Hello");
  }

  _buildProductListView() {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return LoadingIndicator();
      } else if (state is ProductLoaded) {
        return productView(shop, state.products, context, screenId);
      } else {
        return Container();
      }
    });
  }

  showCreateProductScreen(CreateShopDataModel createShopDataModel) {
    Navigation().pushPageWithArgument(
        context,
        ROUTE_CREATE_PRODUCT,
        CreateProductDataModel(
            storyScreenId: screenId, shop: createShopDataModel.shop));
  }
}
