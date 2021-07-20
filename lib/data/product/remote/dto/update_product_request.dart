class UpdateProductRequest {
  late String name;
  late int price;

  UpdateProductRequest({required this.name, required this.price});

  Map<String, dynamic> toJson(){
    return {
      "name": this.name,
      "price": this.price
    };
  }
}