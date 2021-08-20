import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vivasayi/screens/prod_details_widget.dart';
import 'package:vivasayi/style/theme.dart';

class ProductDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductDetails();
}

class _ProductDetails extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        centerTitle: true,
        title: Text(
          'Product details',
          style: (TextStyle(color: Colors.white)),
        ),
        backgroundColor: AppColors.toolBarBackgroundColor,
        elevation: 5.0,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ProductDetailsContent(),
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
}
