class HttpExeption implements Exception {
  final String message;
  final int? statusCode;

  HttpExeption({required this.message, this.statusCode});

  @override
  String toString() {
    return message;
  }
}
