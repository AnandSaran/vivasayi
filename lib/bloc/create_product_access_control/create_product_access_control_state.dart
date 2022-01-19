import 'package:equatable/equatable.dart';

abstract class CreateProductAccessControlState extends Equatable {
  const CreateProductAccessControlState();

  @override
  List<Object> get props => [];
}

class CreateProductAccessControlLoading extends CreateProductAccessControlState {}

class CreateProductAccessControlLoaded extends CreateProductAccessControlState {
  final bool isShow;

  const CreateProductAccessControlLoaded(this.isShow);

  @override
  List<Object> get props => [isShow];

  @override
  String toString() => 'CreateProductAccessControlLoaded { isShow: $isShow }';
}

class CreateProductAccessControlNotLoaded extends CreateProductAccessControlState {}
