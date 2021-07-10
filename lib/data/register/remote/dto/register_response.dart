import 'package:flutter_clean_architecture/data/common/util/serializable.dart';

class RegisterResponse extends Serializable{
  late int id;
  late String name;
  late String email;
  late String token;

  RegisterResponse({ required this.id,required this.name, required this.email, required this.token });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    return RegisterResponse(id: json["id"], name: json["name"], email: json["email"], token: json["token"]);
  }


  @override
  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email,
      "token": this.token
    };
  }

}