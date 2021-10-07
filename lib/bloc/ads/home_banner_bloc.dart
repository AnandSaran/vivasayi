import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story_repository/story_repository.dart';

import 'home_banner_event.dart';
import 'home_banner_state.dart';

class HomeBannerBloc extends Bloc<HomeBannerEvent, HomeBannerState> {
  final FirestoreHomeBannerAdsRepository _adsRepository;
  StreamSubscription? _storySubscription;

  HomeBannerBloc(
      {required FirestoreHomeBannerAdsRepository homeBannerAdsRepository})
      : _adsRepository = homeBannerAdsRepository,
        super(AdLoading());

  @override
  Stream<HomeBannerState> mapEventToState(HomeBannerEvent event) async* {
    if (event is LoadAds) {
      yield* _mapLoadAdsToState();
    } else if (event is AddAd) {
      yield* _mapAddAdsToState(event);
    } else if (event is UpdateAd) {
      yield* _mapUpdateAdsToState(event);
    } else if (event is DeleteAds) {
      yield* _mapDeleteAdsToState(event);
    } else if (event is AdsUpdated) {
      yield* _mapAdsUpdateToState(event);
    }
  }

  Stream<HomeBannerState> _mapLoadAdsToState() async* {
    _storySubscription?.cancel();
    _storySubscription = _adsRepository.stories().listen(
          (storyGenres) => add(AdsUpdated(storyGenres)),
        );
  }

  Stream<HomeBannerState> _mapAddAdsToState(AddAd event) async* {
    //  _storyRepository.addNewAds(event.story);
  }

  Stream<HomeBannerState> _mapUpdateAdsToState(UpdateAd event) async* {
    //_storyRepository.updateAdsGenre(event.updatedAds);
  }

  Stream<HomeBannerState> _mapDeleteAdsToState(DeleteAds event) async* {
    // _storyRepository.deleteAdsGenre(event.story);
  }

  Stream<HomeBannerState> _mapAdsUpdateToState(AdsUpdated event) async* {
    yield AdLoaded(event.ads);
  }

  @override
  Future<void> close() {
    _storySubscription?.cancel();
    return super.close();
  }
}
