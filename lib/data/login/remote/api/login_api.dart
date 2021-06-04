import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/domain/login/entity/login_entity.dart';

abstract class LoginApi {
  Future<LoginEntity> login(LoginRequest loginRequest);
}
