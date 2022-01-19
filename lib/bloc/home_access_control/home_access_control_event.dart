import 'package:equatable/equatable.dart';

class HomeAccessControlEvent extends Equatable {
  const HomeAccessControlEvent();

  @override
  List<Object> get props => [];
}

class IsShowHomeAccess extends HomeAccessControlEvent {
  const IsShowHomeAccess();
}

class IsShowHomeAccessUpdated extends HomeAccessControlEvent {
  final bool isShow;

  const IsShowHomeAccessUpdated(this.isShow);

  @override
  List<Object> get props => [isShow];
}
