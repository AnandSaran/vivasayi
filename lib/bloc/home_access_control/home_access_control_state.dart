import 'package:equatable/equatable.dart';

abstract class HomeAccessControlState extends Equatable {
  const HomeAccessControlState();

  @override
  List<Object> get props => [];
}

class HomeAccessControlLoading extends HomeAccessControlState {}

class HomeAccessControlLoaded extends HomeAccessControlState {
  final bool isShow;

  const HomeAccessControlLoaded(this.isShow);

  @override
  List<Object> get props => [isShow];

  @override
  String toString() => 'HomeAccessControlLoaded { isShow: $isShow }';
}

class HomeAccessControlNotLoaded extends HomeAccessControlState {}
