import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/login/entity/login_entity.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';

class LoginUseCase {
  final LoginRepository loginRepository;

  LoginUseCase({required this.loginRepository});

  Future<Either<LoginEntity, Failure>> login(LoginRequest loginRequest) async {
    return await loginRepository.login(loginRequest);
  }

}