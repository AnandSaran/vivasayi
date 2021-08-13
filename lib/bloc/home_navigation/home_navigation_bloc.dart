import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vivasayi/repository/home_navigation_repository.dart';

import 'home_navigation.dart';

class HomeNavigationBloc
    extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  final HomeNavigationRepository _homeNavigationRepository;

  HomeNavigationBloc(
      {required HomeNavigationRepository homeNavigationRepository})
      : _homeNavigationRepository = homeNavigationRepository,
        super(HomeNavigationLoading());

  @override
  Stream<HomeNavigationState> mapEventToState(
      HomeNavigationEvent event) async* {
    if (event is LoadHomeNavigationList) {
      yield* _mapLoadHomeNavigationListToState();
    }
    if (event is SelectHomeNavigationItem) {
      yield* _mapSelectHomeNavigationItemToState(event);
    } else if (event is HomeNavigationListUpdated) {
      yield* _mapHomeNavigationListUpdateToState(event);
    }
  }

  Stream<HomeNavigationState> _mapLoadHomeNavigationListToState() async* {
    add(HomeNavigationListUpdated(
        _homeNavigationRepository.homeNavigationItems()));
  }

  Stream<HomeNavigationState> _mapSelectHomeNavigationItemToState(
      SelectHomeNavigationItem event) async* {
    var list = _homeNavigationRepository.homeNavigationItems();
    list.firstWhere((element) => element.isSelected).isSelected = false;
    list
        .firstWhere((element) => element.id == event.homeNavigationItem.id)
        .isSelected = true;
    add(HomeNavigationListUpdated(list));
  }

  Stream<HomeNavigationState> _mapHomeNavigationListUpdateToState(
      HomeNavigationListUpdated event) async* {
    yield HomeNavigationLoaded(homeNavigationList: event.homeNavigationItems);
  }

  @override
  Future<void> close() {
    return super.close();
  }
}
