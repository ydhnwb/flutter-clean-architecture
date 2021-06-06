

class LoginRequest {
  late String email;
  late String password;

  LoginRequest({required this.email, required this.password});

  Map<String, dynamic> toJson(){
    return {
      "email": email,
      "password": password
    };
  }
}
