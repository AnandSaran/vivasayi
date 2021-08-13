import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProductDescription extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProductDescription();
}

class _ProductDescription extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Color(0xFF1a1a4b),
        ),
        centerTitle: true,
        title: Text(
          'Product Name',
          style: (TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.white,
        elevation: 5.0,
      ),
      body: Container(
          color: Colors.white,
          child: Expanded(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.white,
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Container(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0),
                            child: Image.asset(
                              'asset/svg/seedimage.png',
                              height: 200,
                              width: 250,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Flexible(
                      child: ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: 10,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: Column(
                                children: <Widget>[
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Container(
                                        height: 72.0,
                                        width: 72.0,
                                        decoration: BoxDecoration(
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black.withAlpha(
                                                      70),
                                                  offset: const Offset(
                                                      2.0, 2.0),
                                                  blurRadius: 2.0)
                                            ],
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(12.0)),
                                            image: DecorationImage(
                                              image: ExactAssetImage(
                                                'asset/svg/seedimage.png',
                                              ),
                                              fit: BoxFit.cover,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
                                      Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment
                                                .start,
                                            crossAxisAlignment: CrossAxisAlignment
                                                .start,
                                            children: <Widget>[
                                              Text(
                                                'My item header',
                                                style: TextStyle(
                                                    fontSize: 14.0,
                                                    color: Colors.black87,
                                                    fontWeight: FontWeight
                                                        .bold),
                                              ),
                                              Text(
                                                'Item Subheader goes here Lorem Ipsumxcvxvxdvdxvdsvdsvsdvsdvsvsv is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                                maxLines: 4,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Colors.black54,
                                                    fontWeight: FontWeight
                                                        .normal),
                                              )
                                            ],
                                          )),
                                    ],
                                  ),
                                  Divider(),
                                ],
                              ),
                            );
                          })),
                ],
              ),
            ),
          ),
      ),
    );
  }
}
