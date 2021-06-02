import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_failure.dart';
import 'package:flutter_clean_architecture/domain/login/entity/login_entity.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_result.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/domain/login/repository/login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<Either<LoginEntity, Failure>> login(LoginRequest loginRequest) async {
      var loginEntity = LoginEntity(id: 1, name: "Prieyudha Akadita S", email: "yudhanewbie@gmail.com", token: "123");
      return Left(loginEntity);
      // return Right(CacheFailure());
  }
}
