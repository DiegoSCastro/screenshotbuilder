import 'package:dio/dio.dart';

class CustomException implements Exception {
  dynamic message;
  int? statusCode;
  CustomException.otherException(String msg) {
    message = msg;
  }
  CustomException.fromDioException(DioException dioException) {
    if (message == null) {
      switch (dioException.type) {
        case DioExceptionType.cancel:
          message = "Request to API server was cancelled";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.connectionTimeout:
          message = "Connection timeout with API server!";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.connectionError:
          message = "Connection to API server failed!";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.receiveTimeout:
          message = "Receive timeout in connection with API server";
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.badResponse:
          message = _handleBadResponse(dioException);
          statusCode = dioException.response?.statusCode;
          break;
        case DioExceptionType.sendTimeout:
          message = "Send timeout in connection with API server";
          statusCode = dioException.response?.statusCode;
          break;
        default:
          message = _handleBadResponse(dioException);
          statusCode = dioException.response?.statusCode;
          break;
      }
    }
  }

  String? _handleBadResponse(DioException exception) {
    try {
      final response = exception.response?.data as Map?;
      if (response != null && response['message'] != null) {
        return "${response["message"]}";
      } else {
        return _handleError(exception.response!.statusCode);
      }
    } catch (_) {
      return _handleError(exception.response?.statusCode);
    }
  }

  String _handleError(statusCode) {
    switch (statusCode) {
      case 400:
        return 'An error occured';
      case 401:
        return 'Unauthorized request';
      case 404:
        return 'The requested resource was not found';
      case 500:
        return 'Internal server error';
      default:
        return 'Something went wrong';
    }
  }

  @override
  String toString() => message.toString();
}


