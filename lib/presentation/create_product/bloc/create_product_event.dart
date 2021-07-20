import 'package:equatable/equatable.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/create_product_request.dart';

abstract class CreateProductPageEvent extends Equatable {}

class CreateProductPageEventCreateProduct implements CreateProductPageEvent {
  final CreateProductRequest createProductRequest;

  CreateProductPageEventCreateProduct({required this.createProductRequest});

  @override
  List<Object?> get props => [createProductRequest];

  @override
  bool? get stringify => false;
  
}