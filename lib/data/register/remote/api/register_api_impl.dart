import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/common/response/response_wrapper.dart';
import 'package:flutter_clean_architecture/data/register/remote/api/register_api.dart';
import 'package:flutter_clean_architecture/data/register/remote/dto/register_response.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_exception.dart';
import 'package:flutter_clean_architecture/domain/register/entity/register_entity.dart';
import 'package:flutter_clean_architecture/data/register/remote/dto/register_request.dart';

class RegisterApiImpl implements RegisterApi {
  final Dio dio;

  RegisterApiImpl({required this.dio});

  @override
  Future<RegisterEntity> register(RegisterRequest registerRequest) async {
    try{
      final response = await dio.post("auth/register", data: registerRequest.toJson());
      var converted = WrappedResponse<RegisterResponse>.fromJson(response.data, (data) => RegisterResponse.fromJson(data));
      if(response.statusCode == 201){
        var registerEntity = RegisterEntity.toEntity(converted.data!);
        return registerEntity;
      }
      throw BaseException(message: converted.message, code: response.statusCode);
    }on DioError catch(e){
      throw BaseException(message: e.message, code: e.response?.statusCode);
    }on Exception catch(e){
      throw BaseException(message: e.toString());
    }
  }

}