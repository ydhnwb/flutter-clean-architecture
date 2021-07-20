import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/product/remote/api/product_api.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/update_product_request.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/create_product_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_exception.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/domain/product/repository/create_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/repository/delete_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/repository/get_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/repository/update_product_repository.dart';

class ProductRepositoryImpl implements GetProductRepository, CreateProductRepository, UpdateProductRepository, DeleteProductRepository {
  final ProductApi productApi;

  ProductRepositoryImpl({required this.productApi});

  @override
  Future<Either<List<ProductEntity>, Failure>> getAllProduct() async {
    try{
      var products = await productApi.findAllProduct();
      return Left(products);
    }on BaseException catch(e){
      return Right(BaseFailure(code: e.code!, message: e.message));
    }
  }

  @override
  Future<Either<ProductEntity, Failure>> getSingleProduct(String id) async{
    try{
      var product = await productApi.findProductById(id);
      return Left(product);
    }on BaseException catch(e){
      return Right(BaseFailure(code: e.code!, message: e.message));
    }
  }

  @override
  Future<Either<ProductEntity, Failure>> createProduct(CreateProductRequest createProductRequest) async {
    try{
      var product = await productApi.create(createProductRequest);
      return Left(product);
    }on BaseException catch(e){
      return Right(BaseFailure(message: e.message, code: e.code!));
    }
  }

  @override
  Future<Either<bool, Failure>> delete(String id) async {
    try{
      var _ = await productApi.delete(id);
      return Left(true);
    }on BaseException catch(e){
      return Right(BaseFailure(code: e.code!, message: e.message));
    }
  }

  @override
  Future<Either<ProductEntity, Failure>> updateProduct(UpdateProductRequest updateProductRequest, String id) async{
    try{
      var product = await productApi.update(updateProductRequest, id);
      return Left(product);
    }on BaseException catch(e){
      return Right(BaseFailure(code: e.code!, message: e.message));
    }
  }

}