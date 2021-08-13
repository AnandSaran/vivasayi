import 'package:equatable/equatable.dart';
import 'package:vivasayi/models/home_navigation_item.dart';

abstract class HomeNavigationState extends Equatable {
  const HomeNavigationState();

  @override
  List<Object> get props => [];
}

class HomeNavigationLoading extends HomeNavigationState {}

class HomeNavigationLoaded extends HomeNavigationState {
  const HomeNavigationLoaded({
    this.homeNavigationList = const <HomeNavigationItem>[],
  });

  final List<HomeNavigationItem> homeNavigationList;

  @override
  List<Object> get props => [homeNavigationList];
}
