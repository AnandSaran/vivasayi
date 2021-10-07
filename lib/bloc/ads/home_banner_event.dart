import 'package:equatable/equatable.dart';
import 'package:story_repository/story_repository.dart';

class HomeBannerEvent extends Equatable {
  const HomeBannerEvent();

  @override
  List<Object> get props => [];
}

class LoadAds extends HomeBannerEvent {}

class AddAd extends HomeBannerEvent {
  final Ads ads;

  const AddAd(this.ads);

  @override
  List<Object> get props => [ads];

  @override
  String toString() => 'AddAds { ads: $ads }';
}

class UpdateAd extends HomeBannerEvent {
  final Ads updatedAds;

  const UpdateAd(this.updatedAds);

  @override
  List<Object> get props => [updatedAds];

  @override
  String toString() => 'UpdateAds { updatedAds: $updatedAds }';
}

class DeleteAds extends HomeBannerEvent {
  final Ads ads;

  const DeleteAds(this.ads);

  @override
  List<Object> get props => [ads];

  @override
  String toString() => 'DeleteAds { deletedAds: $ads }';
}

class AdsUpdated extends HomeBannerEvent {
  final List<Ads> ads;

  const AdsUpdated(this.ads);

  @override
  List<Object> get props => [ads];
}
