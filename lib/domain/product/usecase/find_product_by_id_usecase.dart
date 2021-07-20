import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/domain/product/repository/get_product_repository.dart';

class FindProductByIdUseCase {
  final GetProductRepository getProductRepository;

  FindProductByIdUseCase({required this.getProductRepository});

  Future<Either<ProductEntity, Failure>> invoke(String id){
    return getProductRepository.getSingleProduct(id);
  }
}