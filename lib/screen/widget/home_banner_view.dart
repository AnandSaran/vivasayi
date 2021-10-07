import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/models/enum/enum.dart';

import 'home_banner_list.dart';

Widget bannerView(
    List<Ads> ads, BuildContext context, HomeNavigationItemIdEnum id) {
  return Container(
      margin: EdgeInsets.only(left: 20.0, bottom: 20.0, top: 10),
      color: Colors.white,
      height: 150,
      child: BannerListView(ads: ads, storyScreenId: id));
}
