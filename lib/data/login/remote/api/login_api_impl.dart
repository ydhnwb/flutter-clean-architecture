import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/common/response/response_wrapper.dart';
import 'package:flutter_clean_architecture/data/login/remote/api/login_api.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_request.dart';
import 'package:flutter_clean_architecture/data/login/remote/dto/login_response.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_exception.dart';
import 'package:flutter_clean_architecture/domain/login/entity/login_entity.dart';

class LoginApiImpl implements LoginApi {
  final Dio dio;

  LoginApiImpl({required this.dio});

  @override
  Future<LoginEntity> login(LoginRequest loginRequest) async {
    print("eeexcc ggg");
    final response = await dio.get("users/1");
    if(response.statusCode == 200){
      print("eeexcc jjjj");
      // var converted = WrappedResponse<LoginResponse>.fromJson(response.data, (data) => LoginResponse.fromJson(data));
      return LoginEntity(id: 1, token: "token", email: "ssss", name: "ssss@gmail.com");
    }
    print("eeexcc");
    throw ServerException();
  }


}
