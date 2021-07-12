// class ServerException implements Exception{
//   final int httpStatusCode;

//   ServerException({required this.httpStatusCode});
// }

// class CacheException implements Exception{
//   final int localStatusCode;

//   CacheException({required this.localStatusCode});
// }

class BaseException implements Exception {
  final String message;
  int? code = 0;

  BaseException({required this.message, this.code});
}
