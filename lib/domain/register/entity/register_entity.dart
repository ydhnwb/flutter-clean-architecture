import 'package:flutter_clean_architecture/data/register/remote/dto/register_response.dart';

class RegisterEntity {
  late int id;
  late String name;
  late String email;
  late String token;

  RegisterEntity({ required this.id, required this.name, required this.email, required this.token });

  factory RegisterEntity.toEntity(RegisterResponse registerResponse){
    return RegisterEntity(
      id: registerResponse.id, 
      name: registerResponse.name, 
      email: registerResponse.email, 
      token: registerResponse.token
    );
  }

  // Map toJson() => {
  //   "id": id,
  //   "name": name,
  //   "email": email,
  //   "token": token
  // };
}