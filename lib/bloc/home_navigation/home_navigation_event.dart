import 'package:equatable/equatable.dart';
import 'package:vivasayi/models/home_navigation_item.dart';

class HomeNavigationEvent extends Equatable {
  const HomeNavigationEvent();

  @override
  List<Object> get props => [];
}

class LoadHomeNavigationList extends HomeNavigationEvent {}

class SelectHomeNavigationItem extends HomeNavigationEvent {
  final HomeNavigationItem homeNavigationItem;

  const SelectHomeNavigationItem(this.homeNavigationItem);

  @override
  List<Object> get props => [homeNavigationItem];

  @override
  String toString() =>
      'SelectHomeNavigationEvent { homeNavigationItem: $homeNavigationItem }';
}

class HomeNavigationListUpdated extends HomeNavigationEvent {
  final List<HomeNavigationItem> homeNavigationItems;

  const HomeNavigationListUpdated(this.homeNavigationItems);

  @override
  List<Object> get props => [homeNavigationItems];
}
