import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';

abstract class GetProductRepository {
  Future<Either<List<ProductEntity>, Failure>> getAllProduct();
  Future<Either<ProductEntity, Failure>> getSingleProduct(String id);
}