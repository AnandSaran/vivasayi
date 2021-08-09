import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vivasayi/models/toplist.dart';
import 'package:vivasayi/style/theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  /*List<String> items = [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
    "Item 6",
    "Item 7",
    "Item 8"
  ];

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    final headerList =   ListView.builder(
      itemBuilder: (context, index) {
        EdgeInsets padding = index == 0?const EdgeInsets.only(
            left: 20.0, right: 10.0, top: 4.0, bottom: 30.0):const EdgeInsets.only(
            left: 10.0, right: 10.0, top: 4.0, bottom: 30.0);

        return   Padding(
          padding: padding,
          child:   InkWell(
            onTap: () {
              print('Card selected');
            },
            child:   Container(
              decoration:   BoxDecoration(
                borderRadius:   BorderRadius.circular(10.0),
                color: Colors.lightGreen,
                boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(70),
                      offset: const Offset(3.0, 10.0),
                      blurRadius: 15.0)
                ],
                image:   DecorationImage(
                  image:   ExactAssetImage(
                      'assets/img_${index%items.length}.jpg'),
                  fit: BoxFit.fitHeight,
                ),
              ),
//                                    height: 200.0,
              width: 200.0,
              child:   Stack(
                children: <Widget>[
                    Align(
                    alignment: Alignment.bottomCenter,
                    child:   Container(
                        decoration:   BoxDecoration(
                            color: const Color(0xFF273A48),
                            borderRadius:   BorderRadius.only(
                                bottomLeft:   Radius.circular(10.0),
                                bottomRight:   Radius.circular(10.0))),
                        height: 30.0,
                        child:   Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                              Text(
                              '${items[index%items.length]}',
                              style:   TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  )
                ],
              ),
            ),
          ),
        );
      },
      scrollDirection: Axis.horizontal,
      itemCount: items.length,
    );

    final body =   Scaffold(
      appBar:   AppBar(
        title:   Text(widget.title),
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[
            IconButton(icon:   Icon(Icons.shopping_cart, color: Colors.white,), onPressed: (){})
        ],
      ),
      backgroundColor: Colors.transparent,
      body:   Container(
        child:   Stack(
          children: <Widget>[
              Padding(
              padding:   EdgeInsets.only(top: 10.0),
              child:   Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                    Align(
                    alignment: Alignment.centerLeft,
                    child:   Padding(
                        padding:   EdgeInsets.only(left: 8.0),
                        child:   Text(
                          'Recent Items',
                          style:   TextStyle(color: Colors.white70),
                        )),
                  ),
                    Container(
                      height: 300.0, width: _width, child: headerList),
                    Expanded(child:
                  ListView.builder(itemBuilder: (context, index) {
                    return   ListTile(
                      title:   Column(
                        children: <Widget>[
                            Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                Container(
                                height: 72.0,
                                width: 72.0,
                                decoration:   BoxDecoration(
                                    color: Colors.lightGreen,
                                    boxShadow: [
                                        BoxShadow(
                                          color:
                                          Colors.black.withAlpha(70),
                                          offset: const Offset(2.0, 2.0),
                                          blurRadius: 2.0)
                                    ],
                                    borderRadius:   BorderRadius.all(
                                          Radius.circular(12.0)),
                                    image:   DecorationImage(
                                      image:   ExactAssetImage(
                                        'assets/img_${index%items.length}.jpg',
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                                SizedBox(
                                width: 8.0,
                              ),
                                Expanded(
                                  child:   Column(
                                    mainAxisAlignment:
                                    MainAxisAlignment.start,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                        Text(
                                        'My item header',
                                        style:   TextStyle(
                                            fontSize: 14.0,
                                            color: Colors.black87,
                                            fontWeight: FontWeight.bold),
                                      ),
                                        Text(
                                        'Item Subheader goes here\nLorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                        style:   TextStyle(
                                            fontSize: 12.0,
                                            color: Colors.black54,
                                            fontWeight: FontWeight.normal),
                                      )
                                    ],
                                  )),
                                Icon(
                                Icons.shopping_cart,
                                color: const Color(0xFF273A48),
                              )
                            ],
                          ),
                            Divider(),
                        ],
                      ),
                    );
                  }))
                ],
              ),
            ),
          ],
        ),
      ),
    );

    return   Container(
      decoration:   BoxDecoration(
        color: const Color(0xFF273A48),
      ),
      child:   Stack(
        children: <Widget>[
            CustomPaint(
            size:   Size(_width, _height),
            painter:   Background(),
          ),
          body,
        ],
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.appGreen,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Container(
            height: 100,
            color: Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 90,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset(details[index]['image']),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              details[index]['name'],
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(color: Colors.black, fontSize: 12),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
          _productList(),
          Container(
            height: 100,
            color: AppColors.lightGrey,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: details.length,
                itemBuilder: (context, index) {
                  return Container(
                    width: 80,
                    color: AppColors.lightGrey,
                    child: InkWell(
                      onTap: () {
                        print(detailsBottom[index]['name']);
                        if ('Irrigation' == detailsBottom[index]['name']) {
                          print(detailsBottom[index]['name']);
                        }
                      },
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(detailsBottom[index]['image']),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                detailsBottom[index]['name'],
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.black, fontSize: 12),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productList() {
    return Expanded(
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
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  height: 72.0,
                                  width: 72.0,
                                  decoration: BoxDecoration(
                                      boxShadow: [
                                        BoxShadow(
                                            color: Colors.black.withAlpha(70),
                                            offset: const Offset(2.0, 2.0),
                                            blurRadius: 2.0)
                                      ],
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12.0)),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'My item header',
                                      style: TextStyle(
                                          fontSize: 14.0,
                                          color: Colors.black87,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Item Subheader goes here Lorem Ipsumxcvxvxdvdxvdsvdsvsdvsdvsvsv is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry',
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          fontSize: 12.0,
                                          color: Colors.black54,
                                          fontWeight: FontWeight.normal),
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
    );
  }
}

/*
          Expanded(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: ListView.builder(
                    itemCount: 20,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: SizedBox(
                          height: 100.0,
                          width: 100.0,
                          child: Image.asset(
                            'asset/svg/seedimage.png',
                            height: 200,
                            width: 100,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                        isThreeLine: true,
                        title: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Text(
                            "List item $index",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Text(
                              'Suspendisse cursus laoreet sapien, in lobortis justo posuere vitae. Aliquam commodo posuere tellus in lacinia. Nullam ac eleifend odio. Donec aliquam semper tellus a condimentum.'),
                        ),
                      );
                    }),
              ),
            ),
          ),
*/
