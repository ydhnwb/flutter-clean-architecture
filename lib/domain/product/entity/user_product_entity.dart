class UserProductEntity {
  late int id;
  late String name;
  late String email;


  UserProductEntity({required this.id, required this.name, required this.email});

  factory UserProductEntity.fromJson(Map<String, dynamic> json){
    return UserProductEntity(id: json["id"], name: json["name"], email: json["email"]);
  }

  Map toJson(){
    return {
      "id": this.id,
      "name": this.name,
      "email": this.email
    };
  }
}