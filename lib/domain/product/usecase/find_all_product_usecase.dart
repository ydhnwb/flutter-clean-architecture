import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/domain/product/repository/get_product_repository.dart';

class FindAllProductUseCase {
  final GetProductRepository getProductRepository;

  FindAllProductUseCase({required this.getProductRepository});

  Future<Either<List<ProductEntity>, Failure>> invoke(){
    return getProductRepository.getAllProduct();
  }
}