import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/style/theme.dart';

class AgriProductsScreen extends StatelessWidget {
  final HomeNavigationItemIdEnum id;

  const AgriProductsScreen({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Icon(
                        Icons.filter_alt_sharp,
                        color: AppColors.appGreen,
                      ),
                    ),
                    Text("Filter"),
                    Expanded(flex: 3, child: SizedBox()),
                    Flexible(
                      flex: 5,
                      child: Container(
                        margin: EdgeInsets.all(3),
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                              color: AppColors.appGreen, // set border color
                              width: 2.0), // set border width
                          borderRadius: BorderRadius.all(Radius.circular(
                              10.0)), // set rounded corner radius
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                              hintText: 'Location',
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.location_pin,
                                  color: AppColors.appGreen)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Flexible(
                  child: SingleChildScrollView(
                    child: GridView.count(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      crossAxisCount: 2,
                      children: List.generate(10, (index) {
                        return Center(
                          child: Column(
                            children: <Widget>[
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                        'https://picsum.photos/500/500?random=$index',
                                      ),
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              Text(
                                'Product $index',
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
