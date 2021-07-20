class CreateProductRequest {
  late String name;
  late int price;

  CreateProductRequest({required this.name, required this.price});

  Map<String, dynamic> toJson(){
    return {
      "name": this.name,
      "price": this.price
    };
  }
}