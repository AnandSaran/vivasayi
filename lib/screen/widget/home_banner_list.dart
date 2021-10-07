import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:story_repository/story_repository.dart';
import 'package:vivasayi/constants/constant.dart';
import 'package:vivasayi/models/data_model/read_story_data_model.dart';
import 'package:vivasayi/models/enum/enum.dart';
import 'package:vivasayi/models/models.dart';
import 'package:vivasayi/util/navigation.dart';

class BannerListView extends StatelessWidget {
  final List<Ads> ads;
  final HomeNavigationItemIdEnum storyScreenId;

  BannerListView({
    Key? key,
    required this.ads,
    required this.storyScreenId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return bannerListView(context, ads, storyScreenId);
  }
}

ListView bannerListView(BuildContext context, List<Ads> ads,
    HomeNavigationItemIdEnum storyScreenId) {
  return ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: ads.length,
    padding:EdgeInsets.only(left: 20.0, bottom: 20.0, top: 10,right: 20.0) ,
    itemBuilder: (context, index) {
      Ads ad = ads[index];
      return Container(
          margin: EdgeInsets.only(left: 8.0),
          child: InkWell(
            onTap: () {
              onTapListItem(context, ad);
            },
            child: ClipRRect(
              borderRadius: new BorderRadius.circular(20.0),
              child: AspectRatio(
                  aspectRatio: 320 / 150,
                  child: CachedNetworkImage(
                    imageUrl: ad.imageUrl,
                    fit: BoxFit.fill,
                  )
                  //  fit: BoxFit.fitWidth,
                  ),
            ),
          ));
    },
  );
}

onTapListItem(BuildContext context, Ads ad) {
  Navigation().pushPageWithArgument(context, ROUTE_READ_STORY,
      ReadStoryDataModel(storyScreenId: getScreenId(ad), story: ad.toStory));
}

getScreenId(Ads ad) {
  if (ad.isHomeBannerStory) {
    return HomeNavigationItemIdEnum.CREATE_HOME_BANNER_STORY;
  } else if (ad.isHomeBannerDirectShopAd) {
    return HomeNavigationItemIdEnum.CREATE_HOME_BANNER_DIRECT_SHOP_ADS;
  } else if (ad.isHomeBannerNearByShopAd) {
    return HomeNavigationItemIdEnum.CREATE_HOME_BANNER_NEAR_BY_SHOP_ADS;
  }
}
