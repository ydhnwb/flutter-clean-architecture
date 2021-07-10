class RegisterRequest {
  final String name;
  final String email;
  final String password;

  RegisterRequest({ required this.name, required this.email, required this.password });

  Map<String, dynamic> toJson(){
    return {
      "name": this.name,
      "email": this.email,
      "password": this.password
    };
  }
}