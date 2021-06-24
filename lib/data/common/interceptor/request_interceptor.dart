import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/common/module/shared_pref_module.dart';

class RequestInterceptor extends Interceptor {
  final SharedPreferenceModule pref;

  RequestInterceptor({required this.pref});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    String userData = pref.getUserData();
    if(userData.isNotEmpty){
      String token = jsonDecode(userData)['token'];
      options.headers["Authorization"] = token;
    }
    return super.onRequest(options, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    print("=== Dio Error Occured ===");
    print(err.message);
    // consider to remap this error to generic error.
    return super.onError(err, handler);

  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return super.onResponse(response, handler);
  }

}