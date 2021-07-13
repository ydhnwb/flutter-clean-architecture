import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';

abstract class PrimaryTabState extends Equatable{}


class PrimaryTabStateInit implements PrimaryTabState {
  @override
  List<Object?> get props => [];

  @override
  bool? get stringify => false;
}

class PrimaryTabStateLoading implements PrimaryTabState {
  final bool isLoading;

  PrimaryTabStateLoading({required this.isLoading});

  @override
  List<Object?> get props => [isLoading];

  @override
  bool? get stringify => false;

}

class PrimaryTabStateShowMessage implements PrimaryTabState {
  final String message;

  PrimaryTabStateShowMessage({required this.message});

  @override
  List<Object?> get props => [message];

  @override
  bool? get stringify => false;
  
}


class PrimaryTabStateProducts implements PrimaryTabState{
  final List<ProductEntity> products;

  PrimaryTabStateProducts ({required this.products});

  @override
  List<Object?> get props => [products];

  @override
  bool? get stringify => false;
  
}