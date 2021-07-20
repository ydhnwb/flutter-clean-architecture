import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';


abstract class DeleteProductRepository {
  Future<Either<bool, Failure>> delete(String id);
}