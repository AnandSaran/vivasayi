import 'package:equatable/equatable.dart';

class CreateProductAccessControlEvent extends Equatable {
  const CreateProductAccessControlEvent();

  @override
  List<Object> get props => [];
}

class IsShowCreateProductAccess extends CreateProductAccessControlEvent {
  final String shopPhoneNumber;

  const IsShowCreateProductAccess(this.shopPhoneNumber);

  @override
  List<Object> get props => [shopPhoneNumber];
}

class IsShowCreateProductAccessUpdated extends CreateProductAccessControlEvent {
  final bool isShow;

  const IsShowCreateProductAccessUpdated(this.isShow);

  @override
  List<Object> get props => [isShow];
}
