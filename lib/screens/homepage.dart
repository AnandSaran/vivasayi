import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vivasayi/bloc/home_navigation/home_navigation.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/models/home_navigation_item.dart';
import 'package:vivasayi/screens/agri_doctor_screen.dart';
import 'package:vivasayi/screens/agri_products.dart';
import 'package:vivasayi/screens/articles_screen.dart';
import 'package:vivasayi/screens/equips_screen.dart';
import 'package:vivasayi/screens/home_content_screen.dart';
import 'package:vivasayi/screens/irrigation_screen.dart';
import 'package:vivasayi/screens/modern_agri_screen.dart';
import 'package:vivasayi/screens/natural_agri_screen.dart';
import 'package:vivasayi/screens/nursery_screen.dart';
import 'package:vivasayi/screens/product_widget.dart';
import 'package:vivasayi/screens/terrace_garden_screen.dart';
import 'package:vivasayi/style/theme.dart';

import 'agri_medicines_screen.dart';
import 'machines_screen.dart';
import 'manure_screen.dart';

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
      body: _bodyWidget(),
    );
  }

  _bodyWidget() {
    return Column(
      children: [
        _topNavigationWidget(),
        _homeContentWidget(),
        _bottomNavigationWidget(),
      ],
    );
  }

  _homeContentWidget() {
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
        builder: (context, state) {
      if (state is HomeNavigationLoaded) {
        var selectedNavigationItem = state.homeNavigationList
            .firstWhere((element) => element.isSelected);
        switch (selectedNavigationItem.id) {
          case HomeNavigationItemIdEnum.HOME:
            return homeContentScreen();
          case HomeNavigationItemIdEnum.NATURAL_AGRI:
            return naturalAgriContentScreen();
          case HomeNavigationItemIdEnum.MODERN_AGRI:
            return _modernAgriContentScreen();
          case HomeNavigationItemIdEnum.AGRI_MEDICINES:
            return _agriMedicinesContentScreen();
          case HomeNavigationItemIdEnum.TERRACE_GARDEN:
            return _terraceGardenContentScreen();
          case HomeNavigationItemIdEnum.AGRI_DOCTORS:
            return _agriDoctorsContentScreen();
          case HomeNavigationItemIdEnum.ARTICLES:
            return _articlesContentScreen();
          case HomeNavigationItemIdEnum.IRRIGATION:
            return _irrigationContentScreen();
          case HomeNavigationItemIdEnum.NURSERY:
            return _nurseryContentScreen();
          case HomeNavigationItemIdEnum.MANURE:
            return _manureContentScreen();
          case HomeNavigationItemIdEnum.MACHINES:
            return _machinesContentScreen();
          case HomeNavigationItemIdEnum.EQUIPS:
            return _equipsContentScreen();
          case HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS:
            return _agriculturalProductsContentScreen();
        }
      } else {
        return Container();
      }
    });
  }

  Widget _homeContentScreen() {
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

  _topNavigationWidget() {
    return Container(
      height: 100,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
        child: _topNavigationList(),
      ),
    );
  }

  _topNavigationList() {
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
        builder: (context, state) {
      if (state is HomeNavigationLoaded) {
        var topNavigationList = state.homeNavigationList
            .where((element) =>
                element.orientation == HomeNavigationItemOrientationEnum.TOP)
            .toList();
        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: topNavigationList.length,
          itemBuilder: (context, index) {
            var navigationItem = topNavigationList[index];
            return Container(
                width: 90,
                color: Colors.white,
                child: InkWell(
                  onTap: () {
                    _onClickNavigationItem(navigationItem);
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Opacity(
                        opacity: navigationItem.isSelected
                            ? OPACITY_100
                            : OPACITY_50,
                        child: SvgPicture.asset(navigationItem.imagePath),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(
                          child: Text(
                            navigationItem.title,
                            textAlign: TextAlign.center,
                            style: TextStyle(color: Colors.black, fontSize: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ));
          },
        );
      } else {
        return Container();
      }
    });
  }

  Container _bottomNavigationWidget() {
    return Container(
      height: 100,
      color: AppColors.lightGrey,
      child: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: _bottomNavigationList(),
      ),
    );
  }

  _bottomNavigationList() {
    return BlocBuilder<HomeNavigationBloc, HomeNavigationState>(
        builder: (context, state) {
      if (state is HomeNavigationLoaded) {
        var bottomNavigationList = state.homeNavigationList
            .where((element) =>
                element.orientation == HomeNavigationItemOrientationEnum.BOTTOM)
            .toList();

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: bottomNavigationList.length,
          itemBuilder: (context, index) {
            var navigationItem = bottomNavigationList[index];

            return Container(
              width: 80,
              color: AppColors.lightGrey,
              child: InkWell(
                onTap: () {
                  _onClickNavigationItem(navigationItem);
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Opacity(
                      opacity:
                          navigationItem.isSelected ? OPACITY_100 : OPACITY_50,
                      child: SvgPicture.asset(navigationItem.imagePath),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          navigationItem.title,
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      } else {
        return Container();
      }
    });
  }

  void _onClickNavigationItem(HomeNavigationItem navigationItem) {
    context
        .read<HomeNavigationBloc>()
        .add(SelectHomeNavigationItem(navigationItem));
  }

  homeContentScreen() {
    return HomeContentScreen();
  }

  naturalAgriContentScreen() {
    return NaturalAgriScreen();
  }

  _modernAgriContentScreen() {
    return ModernAgriScreen();
  }

  _agriMedicinesContentScreen() {
    return AgriMedicinesScreen();
  }

  _terraceGardenContentScreen() {
    return TerraceGardenScreen();
  }

  _agriDoctorsContentScreen() {
    return AgriDoctorScreen();
  }

  _articlesContentScreen() {
    return ArticlesScreen();
  }

  _irrigationContentScreen() {
    return IrrigationScreen();
  }

  _nurseryContentScreen() {
    return NurseryScreen();
  }

  _manureContentScreen() {
    return ManureScreen();
  }

  _machinesContentScreen() {
    return MachinesScreen();
  }

  _equipsContentScreen() {
    return EquipsScreen();
  }

  _agriculturalProductsContentScreen() {
    return AgriProductsScreen();
  }
}
