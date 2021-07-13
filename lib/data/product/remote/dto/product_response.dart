import 'package:flutter_clean_architecture/data/common/util/serializable.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/product_user_response.dart';

class ProductResponse implements Serializable {
  int? id;
  String? name;
  int? price;
  UserProductResponse? user;

  ProductResponse(
      {required this.id,
      required this.name,
      required this.price,
      required this.user});

  factory ProductResponse.fromJson(Map<String, dynamic> json) {
    return ProductResponse(
        id: json["id"],
        name: json["name"],
        price: json["price"],
        user: UserProductResponse.fromJson(json["user"]));
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      "id": this.id,
      "name": this.name,
      "price": this.price,
      "user": this.user?.toJson()
    };
  }
}
