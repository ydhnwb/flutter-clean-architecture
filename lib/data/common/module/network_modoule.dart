import 'package:dio/dio.dart';

class NetworkModule {
  Dio _dio = new Dio();
  String _baseUrl = "https://golang-heroku.herokuapp.com/api/";
}
