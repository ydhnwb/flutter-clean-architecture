import 'package:flutter_clean_architecture/data/login/remote/api/login_api.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';

class LoginApiImpl implements LoginApi {
  @override
  Stream<String> login(LoginRequest loginRequest) {
    return Stream.value("value");
  }
}
