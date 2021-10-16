import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:product_repository/product_repository.dart';
import 'package:vivasayi/constants/constant.dart';

class ProductDetailsContent extends StatelessWidget {
  final Product product;
  late List<String> productImages;
  late List<String> descriptions;

  ProductDetailsContent(this.product) {
    productImages = product.imageUrl;
    descriptions = product.description
        .trim()
        .split(SYMBOL_SINGLE_DOT)
        .where((element) => element.trim().length > 0)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            margin: EdgeInsets.only(left: 8.0),
            color: Colors.white,
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: productImages.length,
              itemBuilder: (context, index) {
                return Container(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                    child: CachedNetworkImage(
                      imageUrl: productImages[index],
                      height: 150,
                      width: 300,
                    ),
                  ),
                );
              },
            ),
          ),
          Visibility(
            visible: descriptions.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              color: Colors.white,
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      DESCRIPTION,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20),
                    ),
                  )),
            ),
          ),
          Visibility(
            visible: descriptions.isNotEmpty,
            child: Container(
              margin: EdgeInsets.only(left: 16.0),
              color: Colors.white,
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: descriptions.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Column(
                        children: <Widget>[
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                child: RichText(
                                  text: TextSpan(
                                    text: '• ',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                        fontSize: 30),
                                    children: <TextSpan>[
                                      TextSpan(text: ''),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 16.0,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Container(width: 320,
                                    child: Text(
                                      descriptions[index].trim() +
                                          SYMBOL_SINGLE_DOT,
                                      style: TextStyle(
                                          fontSize: 16.0,
                                          color: Colors.black,
                                          fontWeight: FontWeight.normal),
                                      maxLines: 10,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
