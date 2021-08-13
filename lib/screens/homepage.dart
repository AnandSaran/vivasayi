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
            return homeContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.NATURAL_AGRI:
            return naturalAgriContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.MODERN_AGRI:
            return _modernAgriContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.AGRI_MEDICINES:
            return _agriMedicinesContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.TERRACE_GARDEN:
            return _terraceGardenContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.AGRI_DOCTORS:
            return _agriDoctorsContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.ARTICLES:
            return _articlesContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.IRRIGATION:
            return _irrigationContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.NURSERY:
            return _nurseryContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.MANURE:
            return _manureContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.MACHINES:
            return _machinesContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.EQUIPS:
            return _equipsContentScreen(selectedNavigationItem.id.title);
          case HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS:
            return _agriculturalProductsContentScreen(
                selectedNavigationItem.id.title);
        }
      } else {
        return Container();
      }
    });
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

  homeContentScreen(String id) {
    return HomeContentScreen(
      id: id,
    );
  }

  naturalAgriContentScreen(String id) {
    return NaturalAgriScreen(
      id: id,
    );
  }

  _modernAgriContentScreen(String id) {
    return ModernAgriScreen(
      id: id,
    );
  }

  _agriMedicinesContentScreen(String id) {
    return AgriMedicinesScreen(
      id: id,
    );
  }

  _terraceGardenContentScreen(String id) {
    return TerraceGardenScreen(
      id: id,
    );
  }

  _agriDoctorsContentScreen(String id) {
    return AgriDoctorScreen(
      id: id,
    );
  }

  _articlesContentScreen(String id) {
    return ArticlesScreen(
      id: id,
    );
  }

  _irrigationContentScreen(String id) {
    return IrrigationScreen(
      id: id,
    );
  }

  _nurseryContentScreen(String id) {
    return NurseryScreen(
      id: id,
    );
  }

  _manureContentScreen(String id) {
    return ManureScreen(
      id: id,
    );
  }

  _machinesContentScreen(String id) {
    return MachinesScreen(
      id: id,
    );
  }

  _equipsContentScreen(String id) {
    return EquipsScreen(
      id: id,
    );
  }

  _agriculturalProductsContentScreen(String id) {
    return AgriProductsScreen(
      id: id,
    );
  }
}
