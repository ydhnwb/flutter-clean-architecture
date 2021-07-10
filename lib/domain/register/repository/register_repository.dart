import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/register/remote/dto/register_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/register/entity/register_entity.dart';

abstract class RegisterRepository {
  Future<Either<RegisterEntity, Failure>> register(RegisterRequest registerRequest);
}