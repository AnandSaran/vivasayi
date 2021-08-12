import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vivasayi/models/toplist.dart';
import 'package:vivasayi/screens/product_details.dart';
import 'package:vivasayi/screens/product_widget.dart';
import 'package:vivasayi/style/theme.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
          _homeList(),
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

  Widget _homeList() {
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
