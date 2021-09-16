import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_repository/shop_repository.dart';
import 'package:vivasayi/bloc/product/products.dart';
import 'package:vivasayi/models/data_model/create_shop_data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/screen/widget/loading_indicator.dart';
import 'package:vivasayi/screen/widget/product_view.dart';
import 'package:vivasayi/style/theme.dart';

class ProductScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  late ProductBloc _bloc;
  late CreateShopDataModel createShopDataModel;
  late Shop shop;
  late HomeNavigationItemIdEnum storyScreenId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    createShopDataModel =
        ModalRoute.of(context)!.settings.arguments as CreateShopDataModel;
    shop = createShopDataModel.shop;
    storyScreenId = createShopDataModel.storyScreenId;
    _bloc = BlocProvider.of<ProductBloc>(context);
    _bloc.add(SetShop(shop.id));
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
        elevation: 5.0,
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
                          icon: Icon(Icons.star_outline),
                          label: Text("Call Now"),
                          onPressed: () => print("it's pressed"),
                          style: ElevatedButton.styleFrom(
                            side: BorderSide(width: 2.0, color: Colors.blue),
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
                          label: Text('Whatsapp'),
                          icon: Icon(Icons.chat),
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
                          onPressed: () {},
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

  _buildProductListView() {
    return BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
      if (state is ProductLoading) {
        return LoadingIndicator();
      } else if (state is ProductLoaded) {
        return productView(shop, state.products, context, storyScreenId);
      } else {
        return Container();
      }
    });
  }
}
