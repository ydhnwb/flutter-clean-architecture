import 'package:flutter_clean_architecture/data/register/remote/dto/register_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/register/entity/register_entity.dart';
import 'package:flutter_clean_architecture/domain/register/repository/register_repository.dart';
import 'package:dartz/dartz.dart';

class RegisterUseCase {
  final RegisterRepository registerRepository;

  RegisterUseCase({required this.registerRepository});

  Future<Either<RegisterEntity, Failure>> invoke(RegisterRequest registerRequest) async {
    return await registerRepository.register(registerRequest);
  }
}