import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';

abstract class LoginApi {
  Stream<String> login(LoginRequest loginRequest);
}
