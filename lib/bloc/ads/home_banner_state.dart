import 'package:equatable/equatable.dart';
import 'package:story_repository/story_repository.dart';

abstract class HomeBannerState extends Equatable {
  const HomeBannerState();

  @override
  List<Object> get props => [];
}

class AdLoading extends HomeBannerState {}

class AdLoaded extends HomeBannerState {
  final List<Ads> ads;

  const AdLoaded([this.ads = const []]);

  @override
  List<Object> get props => [ads];

  @override
  String toString() => 'AdLoaded { ads: $ads }';
}

class AdNotLoaded extends HomeBannerState {}
