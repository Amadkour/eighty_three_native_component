class ServerException implements Exception {
  final String message;
  final int statusCode;
  final Map<String, dynamic> errors;
  ServerException({
    required this.message,
    required this.statusCode,
    this.errors = const <String,dynamic>{},
  });
}

class CacheException implements Exception {}

class NetworkException implements Exception {}

///can be used for throwing [NoInternetException]
class NoInternetException implements Exception {
  late String _message;

  NoInternetException([String message = 'NoInternetException Occurred']) {
    _message = message;
  }

  @override
  String toString() {
    return _message;
  }
}
