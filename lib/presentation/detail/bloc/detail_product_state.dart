import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';

abstract class DetailProductPageState extends Equatable{}

class DetailProductPageStateInit implements DetailProductPageState{
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

}

class DetailProductPageStateIsLoading implements DetailProductPageState{
  final bool isLoading;

  DetailProductPageStateIsLoading({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];

  @override
  bool? get stringify => false;
}

class DetailProductPageStateReceiveProduct implements DetailProductPageState {
  final ProductEntity productEntity;
  DetailProductPageStateReceiveProduct({required this.productEntity});

  @override
  List<Object?> get props => [productEntity];

  @override
  bool? get stringify => false;
}

class DetailProductPageStateSuccessUpdate implements DetailProductPageState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;

}

class DetailProductPageStateShowMessage implements DetailProductPageState {
  final String message;

  DetailProductPageStateShowMessage({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => false;
  
}