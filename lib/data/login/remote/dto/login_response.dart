import 'package:flutter_clean_architecture/data/common/util/serializable.dart';

class LoginResponse implements Serializable {
  int? id;
  String? name;
  String? email;
  String? token;

  LoginResponse({ this.id, this.name, this.email, this.token });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(id: json["id"], name: json["name"], email: json["email"], token: json["token"]);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id" : this.id,
      "name": this.name,
      "email": this.email,
      "token": this.token
    };
  }

}