import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';
import 'package:shop_repository/shop_repository.dart';
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
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(product.name,
          style: (TextStyle(color: Colors.white)),
        ),
        backgroundColor: AppColors.toolBarBackgroundColor,
        elevation: 5.0,
        actions: <Widget>[
          Builder(
            builder: (context) => IconButton(
              icon: Icon(
                Icons.edit,
                color: Theme.AppColors.iconColor,
              ),
              onPressed: () {
                onTapEdit(createProductDataModel);
              },
            ),
          )
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child:
          ProductDetailsContent(product)),
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
    );
  }

  onTapEdit(CreateProductDataModel createProductDataModel) {
    createProductDataModel.isEdit = true;
    Navigation()
        .popAndPushNamed(context, ROUTE_CREATE_PRODUCT, data: createProductDataModel);
  }
}
