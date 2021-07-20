import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/product/repository/delete_product_repository.dart';

class DeleteProductUseCase {
  final DeleteProductRepository deleteProductRepository;

  DeleteProductUseCase({required this.deleteProductRepository});

  Future<Either<bool, Failure>> invoke(String id){
    return deleteProductRepository.delete(id);
  }
}