import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/update_product_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';

abstract class UpdateProductRepository {
  Future<Either<ProductEntity, Failure>> updateProduct(UpdateProductRequest updateProductRequest, String id);
}