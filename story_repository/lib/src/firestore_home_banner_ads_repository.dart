import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:story_repository/constants/constant.dart';
import 'package:story_repository/src/models/story.dart';
import 'package:story_repository/src/story_repository.dart';

import 'entities/entities.dart';
import 'models/models.dart';

class FirestoreHomeBannerAdsRepository {
  var adsCollection = FirebaseFirestore.instance.collection(COL_HOME_BANNER);

  Stream<List<Ads>> stories() {
    return adsCollection
        .orderBy(FIELD_DATE, descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs
          .map((doc) => Ads.fromEntity(AdsEntity.fromSnapshot(doc)))
          .toList();
    });
  }
}
