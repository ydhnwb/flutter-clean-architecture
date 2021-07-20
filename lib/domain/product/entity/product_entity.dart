import 'package:flutter_clean_architecture/data/product/remote/dto/product_response.dart';
import 'package:flutter_clean_architecture/domain/product/entity/user_product_entity.dart';

class ProductEntity {
  late int id;
  late String name;
  late int price;
  late UserProductEntity user;

  ProductEntity({required this.id, required this.name, required this.price, required this.user});

  factory ProductEntity.fromJson(Map<String, dynamic> json) {
    return ProductEntity(id: json["id"], name: json["name"], price: json["price"], user: UserProductEntity.fromJson(json["user"]));
  }

  factory ProductEntity.toEntity(ProductResponse res){
    return ProductEntity(
        id: res.id!,
        name: res.name!,
        price: res.price!,
        user: UserProductEntity.toEntity(res.user!)
    );
  }

  Map<String, dynamic> toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "user": this.user.toJson()
    };
  }
}