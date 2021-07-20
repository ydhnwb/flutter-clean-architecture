import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/update_product_request.dart';

abstract class DetailProductPageEvent extends Equatable{}

class DetailProductPageEventFindProductById implements DetailProductPageEvent {
  final String id;

  DetailProductPageEventFindProductById({required this.id});

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => false;
}

class DetailProductPageEventUpdateProduct implements DetailProductPageEvent {
  final UpdateProductRequest updateProductRequest;
  final String id;

  DetailProductPageEventUpdateProduct({required this.updateProductRequest, required this.id});

  @override
  List<Object?> get props => [updateProductRequest, id];

  @override
  bool? get stringify => false;

}

class DetailProductPageEvenetDeleteById implements DetailProductPageEvent {
  final String id;

  DetailProductPageEvenetDeleteById({required this.id});

  @override
  List<Object?> get props => [id];

  @override
  bool? get stringify => false;
}