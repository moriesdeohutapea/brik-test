class ServerException implements Exception {
  final String message;

  ServerException(this.message);

  @override
  String toString() => message;
}

class CacheException implements Exception {
  final String message;

  CacheException([this.message = 'An error occurred in local cache']);
}

class NetworkException implements Exception {
  final String message;

  NetworkException([this.message = 'No internet connection']);
}
