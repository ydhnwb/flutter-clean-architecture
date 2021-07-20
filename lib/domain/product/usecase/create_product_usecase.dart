import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/create_product_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/domain/product/repository/create_product_repository.dart';

class CreateProductUseCase {
  final CreateProductRepository createProductRepository;

  CreateProductUseCase({required this.createProductRepository});

  Future<Either<ProductEntity, Failure>> invoke(CreateProductRequest request){
    return createProductRepository.createProduct(request);
  }
}