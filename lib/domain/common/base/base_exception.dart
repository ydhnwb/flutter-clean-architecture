class ServerException implements Exception{
  final int httpStatusCode;

  ServerException({required this.httpStatusCode});
}

class CacheException implements Exception{
  final int localStatusCode;

  CacheException({required this.localStatusCode});
}
