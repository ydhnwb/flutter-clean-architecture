import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/data/common/errors/error.mapper.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_exception.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/login/entity/login_entity.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final LoginApi loginApi;

  LoginRepositoryImpl({ required this.loginApi });

  @override
  Future<Either<LoginEntity, Failure>> login(LoginRequest loginRequest) async {
    try{
      var result = await loginApi.login(loginRequest);
      return Left(result);
    } on BaseException catch(e){
      return Right(BaseFailure(message: e.message, code: e.code!));
      // String errorMessage = ErrorMapper.getErrorMessage(e.httpStatusCode);
      // return Right(Failure(message: errorMessage));
    }
  }
  
}
