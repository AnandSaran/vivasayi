import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class AdsEntity extends Equatable {
  final String id;
  final String userId;
  final String content;
  final String genre;
  final bool isHomeBannerStory;
  final bool isHomeBannerDirectShopAd;
  final bool isHomeBannerNearByShopAd;

  const AdsEntity({id,
    required this.userId,
    required this.content,
    required this.genre,
    isHomeBannerStory,
    isHomeBannerDirectShopAd,
    isHomeBannerNearByShopAd})
      : this.id = id ?? '',
        this.isHomeBannerStory = isHomeBannerStory ?? false,
        this.isHomeBannerDirectShopAd = isHomeBannerDirectShopAd ?? false,
        this.isHomeBannerNearByShopAd = isHomeBannerNearByShopAd ?? false;

  Map<String, Object?> toJson() {
    return {
      'id': id,
      'userId': userId,
      'content': content,
      'genre': genre,
    };
  }

  @override
  List<Object?> get props =>
      [
        id,
        userId,
        content,
        genre,
        isHomeBannerStory,
        isHomeBannerDirectShopAd,
        isHomeBannerNearByShopAd
      ];

  @override
  String toString() {
    return 'AdsEntity { id: $id, userId: $userId, content: $content, genre: $genre, isHomeBannerStory: $isHomeBannerStory,isHomeBannerDirectShopAd: $isHomeBannerDirectShopAd,isHomeBannerNearByShopAd: $isHomeBannerNearByShopAd}';
  }

  static AdsEntity fromJson(Map<String, Object> json) {
    return AdsEntity(
      id: json['id'] as String,
      userId: json['userId'] as String,
      content: json['content'] as String,
      genre: json['genre'] as String,
    );
  }

  static AdsEntity fromSnapshot(DocumentSnapshot snap) {
    final data = snap.data();
    if (data == null) throw Exception();
    bool isHomeBannerStory = false;
    bool isHomeBannerDirectShopAd = false;
    bool isHomeBannerNearByShopAd = false;
    try {
      isHomeBannerStory = snap.get('home_banner_story');
    } catch (e) {

    }
    try {
      isHomeBannerDirectShopAd = snap.get('home_banner_direct_shop_ads');
    } catch (e) {

    }
    try {
      isHomeBannerNearByShopAd = snap.get('home_banner_near_by_shop_ads');
    } catch (e) {

    }
    return AdsEntity(
        id: snap.id,
        userId: snap.get('userId'),
    content: snap.get('content'),
    genre: snap.get('genre'),
    isHomeBannerStory
        :isHomeBannerStory,
    isHomeBannerDirectShopAd:isHomeBannerDirectShopAd,
    isHomeBannerNearByShopAd
    :
    isHomeBannerNearByShopAd);
  }

  Map<String, Object?> toDocument() {
    return {
      'userId': userId,
      'content': content,
      'genre': genre,
      'isHomeBannerStory': isHomeBannerStory,
      'isHomeBannerDirectShopAd': isHomeBannerDirectShopAd,
      'isHomeBannerNearByShopAd': isHomeBannerNearByShopAd,
      'date': Timestamp.now(),
    };
  }
}
