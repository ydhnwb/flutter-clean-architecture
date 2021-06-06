import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/common/interceptor/request_interceptor.dart';

class NetworkModule {
  final Dio _dio = new Dio();
  final String _baseUrl = "https://golang-heroku.herokuapp.com/api/";
  final RequestInterceptor requestInterceptor;

  NetworkModule({required this.requestInterceptor});

  BaseOptions _dioOptions(){
    BaseOptions opts = BaseOptions();
    opts.baseUrl = _baseUrl;
    opts.connectTimeout = 60000;
    opts.receiveTimeout = 60000;
    opts.sendTimeout = 60000;
    return opts;
  }


  Dio provideDio(){
    _dio.options = _dioOptions();
    _dio.interceptors.add(requestInterceptor);
    return _dio;
  }
}
