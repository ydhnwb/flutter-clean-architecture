import 'package:flutter_clean_architecture/data/product/remote/dto/product_user_response.dart';

class UserProductEntity {
  late int id;
  late String name;
  late String email;


  UserProductEntity({required this.id, required this.name, required this.email});

  factory UserProductEntity.fromJson(Map<String, dynamic> json){
    return UserProductEntity(id: json["id"], name: json["name"], email: json["email"]);
  }

  factory UserProductEntity.toEntity(UserProductResponse res){
    return UserProductEntity(
        id: res.id!,
        name: res.name!,
        email: res.email!
    );
  }

  Map toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email
    };
  }
}