import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vivasayi/bloc/home_navigation/home_navigation.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/extension/extension.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/models/home_navigation_item.dart';
import 'package:vivasayi/models/models.dart';
import 'package:vivasayi/screen/widget/widget.dart';
import 'package:vivasayi/screens/agri_doctor_screen.dart';
import 'package:vivasayi/screens/agri_products_screen.dart';
import 'package:vivasayi/screens/articles_screen.dart';
import 'package:vivasayi/screens/equips_screen.dart';
import 'package:vivasayi/screens/home_content_screen.dart';
import 'package:vivasayi/screens/irrigation_screen.dart';
import 'package:vivasayi/screens/modern_agri_screen.dart';
import 'package:vivasayi/screens/natural_agri_screen.dart';
import 'package:vivasayi/screens/nursery_screen.dart';
import 'package:vivasayi/screens/terrace_garden_screen.dart';
import 'package:vivasayi/style/theme.dart';
import 'package:vivasayi/style/theme.dart' as Theme;
import 'package:vivasayi/util/navigation.dart';

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
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
              color: Theme.AppColors.iconColor,
            ),
            onPressed: () => showCreateContentDialog(),
          ),
        ],
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
            return homeContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.NATURAL_AGRI:
            return naturalAgriContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.MODERN_AGRI:
            return _modernAgriContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.AGRI_MEDICINES:
            return _agriMedicinesContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.TERRACE_GARDEN:
            return _terraceGardenContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.AGRI_DOCTORS:
            return _agriDoctorsContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.ARTICLES:
            return _articlesContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.IRRIGATION:
            return _irrigationContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.NURSERY:
            return _nurseryContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.MANURE:
            return _manureContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.MACHINES:
            return _machinesContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.EQUIPS:
            return _equipsContentScreen(selectedNavigationItem.id);
          case HomeNavigationItemIdEnum.AGRICULTURAL_PRODUCTS:
            return _agriculturalProductsContentScreen(
                selectedNavigationItem.id);
          default:
            return homeContentScreen(HomeNavigationItemIdEnum.HOME);
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
        return navigationList(topNavigationList, AppColors.whiteColor);
      } else {
        return Container();
      }
    });
  }

  ListView navigationList(
      List<HomeNavigationItem> navigationList, Color bgColor) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: navigationList.length,
      itemBuilder: (context, index) {
        var navigationItem = navigationList[index];
        return Container(
            color: bgColor,
            child: InkWell(
              onTap: () {
                _onClickNavigationItem(navigationItem);
              },
              child: Opacity(
                opacity: navigationItem.isSelected ? OPACITY_100 : OPACITY_50,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    dividerSpace(height: 17),
                    SvgPicture.asset(
                      navigationItem.imagePath,
                      width: HOME_NAVIGATION_ITEM_WIDTH,
                      height: HOME_NAVIGATION_ITEM_HEIGHT,
                      color: AppColors.iconColorGreen,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                        child: Text(
                          navigationItem.title.replaceSpaceWithNewLine(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: (navigationItem.isSelected
                                  ? 14
                                  : 12),
                              fontWeight: (navigationItem.isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
    );
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

        return navigationList(bottomNavigationList, AppColors.lightGrey);
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

  homeContentScreen(HomeNavigationItemIdEnum id) {
    return HomeContentScreen(
      id: id,
    );
  }

  naturalAgriContentScreen(HomeNavigationItemIdEnum id) {
    return NaturalAgriScreen(
      id: id,
    );
  }

  _modernAgriContentScreen(HomeNavigationItemIdEnum id) {
    return ModernAgriScreen(
      id: id,
    );
  }

  _agriMedicinesContentScreen(HomeNavigationItemIdEnum id) {
    return AgriMedicinesScreen(
      id: id,
    );
  }

  _terraceGardenContentScreen(HomeNavigationItemIdEnum id) {
    return TerraceGardenScreen(
      id: id,
    );
  }

  _agriDoctorsContentScreen(HomeNavigationItemIdEnum id) {
    return AgriDoctorScreen(
      id: id,
    );
  }

  _articlesContentScreen(HomeNavigationItemIdEnum id) {
    return ArticlesScreen(
      id: id,
    );
  }

  _irrigationContentScreen(HomeNavigationItemIdEnum id) {
    return IrrigationScreen(
      id: id,
    );
  }

  _nurseryContentScreen(HomeNavigationItemIdEnum id) {
    return NurseryScreen(
      id: id,
    );
  }

  _manureContentScreen(HomeNavigationItemIdEnum id) {
    return ManureScreen(
      id: id,
    );
  }

  _machinesContentScreen(HomeNavigationItemIdEnum id) {
    return MachinesScreen(
      id: id,
    );
  }

  _equipsContentScreen(HomeNavigationItemIdEnum id) {
    return EquipsScreen(
      id: id,
    );
  }

  _agriculturalProductsContentScreen(HomeNavigationItemIdEnum id) {
    return AgriProductsScreen(
      id: id,
    );
  }

  showCreateContentDialog() {
    Widget option1 =
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.HOME);
    Widget option2 =
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.NATURAL_AGRI);
    Widget option3 =
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.MODERN_AGRI);
    Widget option4 = generateCreateStoryDialogOption(
        HomeNavigationItemIdEnum.AGRI_MEDICINES);
    Widget option5 = generateCreateStoryDialogOption(
        HomeNavigationItemIdEnum.TERRACE_GARDEN);
    /* Widget option6 =
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.AGRI_DOCTORS);*/
    Widget option7 =
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.ARTICLES);
    Widget option8 =
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.CREATE_SHOP);
    Widget option9 =
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.CREATE_HOME_BANNER_STORY);
    Widget option10=
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.CREATE_HOME_BANNER_DIRECT_SHOP_ADS);
    Widget option11=
        generateCreateStoryDialogOption(HomeNavigationItemIdEnum.CREATE_HOME_BANNER_NEAR_BY_SHOP_ADS);

    SimpleDialog dialog = SimpleDialog(
      children: <Widget>[
        option1,
        option2,
        option3,
        option4,
        option5,
        /*option6,*/
        option7,
        option8,
        option9,
        option10,
        option11,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return dialog;
      },
    );
  }

  Widget generateCreateStoryDialogOption(
      HomeNavigationItemIdEnum homeNavigationItemId) {
    return SimpleDialogOption(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Text(homeNavigationItemId.title),
      ),
      onPressed: () {
        onClickCreateContentDialogItem(homeNavigationItemId);
      },
    );
  }

  void onClickCreateContentDialogItem(
      HomeNavigationItemIdEnum homeNavigationItemId) {
    switch (homeNavigationItemId) {
      case HomeNavigationItemIdEnum.CREATE_SHOP:
        showCreateShopProfilePage();
        break;
      default:
        showCreateStoryPage(homeNavigationItemId);
        break;
    }
  }

  void showCreateStoryPage(HomeNavigationItemIdEnum id) {
    ReadStoryDataModel readStoryDataModel =
        ReadStoryDataModel(storyScreenId: id);
    Navigation()
        .popAndPushNamed(context, ROUTE_CREATE_STORY, data: readStoryDataModel);
  }

  void showCreateShopProfilePage() {
    Navigation().popAndPushNamed(context, ROUTE_CREATE_SHOP_PROFILE);
  }
}
