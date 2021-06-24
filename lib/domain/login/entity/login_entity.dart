
import 'package:flutter_clean_architecture/data/login/remote/dto/login_response.dart';

class LoginEntity {
  int id;
  String name;
  String email;
  String token;

  LoginEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.token
    });

  factory LoginEntity.toEntity(LoginResponse loginResponse){
    return LoginEntity(
        id: loginResponse.id!,
        name: loginResponse.name!,
        email: loginResponse.email!,
        token: loginResponse.token!
    );
  }

  Map toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "token": token
  };

  
}
