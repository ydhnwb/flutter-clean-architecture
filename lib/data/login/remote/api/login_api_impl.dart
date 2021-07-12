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
    try{
      final response = await dio.post("auth/login", data: loginRequest.toJson());
      var converted = WrappedResponse<LoginResponse>.fromJson(response.data, (data) => LoginResponse.fromJson(data));
      if(response.statusCode == 200){
        return LoginEntity(
          id: converted.data!.id!, 
          token: converted.data!.token!, 
          email: converted.data!.email!, 
          name: converted.data!.name!
        );
      }
      throw BaseException(message: converted.message, code: response.statusCode);
    }on DioError catch(e){
      throw BaseException(message: e.message, code: e.response?.statusCode);
    }on Exception catch(e){
      throw BaseException(message: e.toString());
    }
  }
}
