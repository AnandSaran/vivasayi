import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/models/enum/enum.dart';

import 'home_banner_list.dart';

Widget bannerView(
    List<Ads> ads, BuildContext context, HomeNavigationItemIdEnum id) {
  return Container(
      color: Colors.white,
      height: 180,
      child: BannerListView(ads: ads, storyScreenId: id));
}
