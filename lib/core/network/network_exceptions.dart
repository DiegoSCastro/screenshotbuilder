/// Simple API-style error for repository layers (no Dio).
class CustomException implements Exception {
  CustomException(this.message);

  final dynamic message;

  @override
  String toString() => message.toString();
}
