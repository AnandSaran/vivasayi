import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:story_repository/extension/extension.dart';
import 'package:story_repository/src/entities/entities.dart';

@immutable
class Ads {
  final String id;
  final String title;
  final String subTitle;
  final String imageUrl;
  final String content;
  final bool isHomeBannerStory;
  final bool isHomeBannerDirectShopAd;
  final bool isHomeBannerNearByShopAd;

  Ads(
      {required this.id,
      required this.title,
      required this.subTitle,
      required this.imageUrl,
      required this.content,
      isHomeBannerStory,
      isHomeBannerDirectShopAd,
      isHomeBannerNearByShopAd})
      : this.isHomeBannerStory = isHomeBannerStory ?? false,
        this.isHomeBannerDirectShopAd = isHomeBannerDirectShopAd ?? false,
        this.isHomeBannerNearByShopAd = isHomeBannerNearByShopAd ?? false;

  Ads copyWith() {
    return Ads(
      id: id,
      title: title,
      subTitle: subTitle,
      imageUrl: imageUrl,
      content: content,
      isHomeBannerStory: isHomeBannerStory,
      isHomeBannerDirectShopAd: isHomeBannerDirectShopAd,
      isHomeBannerNearByShopAd: isHomeBannerNearByShopAd,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        subTitle.hashCode ^
        imageUrl.hashCode ^
        content.hashCode ^
        isHomeBannerStory.hashCode ^
        isHomeBannerDirectShopAd.hashCode ^
        isHomeBannerNearByShopAd.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is Ads &&
            runtimeType == other.runtimeType &&
            id == other.id &&
            title == other.title &&
            subTitle == other.subTitle &&
            imageUrl == other.imageUrl &&
            content == other.content &&
            isHomeBannerStory == other.isHomeBannerStory &&
            isHomeBannerDirectShopAd == other.isHomeBannerDirectShopAd &&
            isHomeBannerNearByShopAd == other.isHomeBannerNearByShopAd;
  }

  @override
  String toString() {
    return 'Ads{id: $id, title: $title, subTitle: $subTitle, imageUrl: $imageUrl, content: $content, isHomeBannerStory: $isHomeBannerStory,isHomeBannerDirectShopAd: $isHomeBannerDirectShopAd,isHomeBannerNearByShopAd: $isHomeBannerNearByShopAd}';
  }

  static Ads fromEntity(AdsEntity entity) {
    var myJSON = jsonDecode(entity.content);
    Document quilDocument = Document.fromJson(myJSON);

    return Ads(
      id: entity.id,
      title: quilDocument.title,
      subTitle: quilDocument.subtitle,
      imageUrl: quilDocument.imageUrl,
      content: entity.content,
      isHomeBannerStory: entity.isHomeBannerStory,
      isHomeBannerDirectShopAd: entity.isHomeBannerDirectShopAd,
      isHomeBannerNearByShopAd: entity.isHomeBannerNearByShopAd,
    );
  }
}
