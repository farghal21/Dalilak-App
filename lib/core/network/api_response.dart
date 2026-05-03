import 'package:dio/dio.dart';
import '../helper/custom_logger.dart';

class ApiResponse {
  final bool success;
  final int statusCode;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.success,
    required this.statusCode,
    this.data,
    required this.message,
  });

  // Factory method to handle Dio responses
  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(
      success: response.data is Map
          ? (response.data["success"] ?? true)
          : true, // افترضنا النجاح لو الداتا مش ماب
      statusCode: response.statusCode ?? 200,
      data: response.data,
      message: response.data is Map ? (response.data["message"] ?? '') : '',
    );
  }

  // Factory method to handle Dio or other exceptions
  factory ApiResponse.fromError(dynamic error) {
    // ignore: avoid_print
    print("🛑 Error Caught in ApiResponse: $error");

    if (error is DioException) {
      return ApiResponse(
        success: false,
        data: error.response?.data,
        statusCode: error.response?.statusCode ?? 500,
        message: _handleDioError(error), // هنا بنجيب الرسالة الصح
      );
    } else {
      return ApiResponse(
        success: false,
        statusCode: 500,
        message: error.toString(), // عرض الخطأ المباشر لو مش Dio
      );
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return "Connection timeout, please try again.";
      case DioExceptionType.sendTimeout:
        return "Send timeout, please check your internet.";
      case DioExceptionType.receiveTimeout:
        return "Receive timeout, please try again later.";
      case DioExceptionType.badResponse:
        return _handleServerError(error.response);
      case DioExceptionType.cancel:
        return "Request was cancelled.";
      case DioExceptionType.connectionError:
        return "No internet connection.";
      default:
        return "Unknown error occurred.";
    }
  }

  /// Handling errors from the server response
  static String _handleServerError(Response? response) {
    if (response == null) return "No response from server.";

    final data = response.data;
    CustomLogger.red("----- Raw Server Error: $data");

    // 1️⃣ الحالة الأولى: لو الرد نص مباشر (String)
    // دي الحالة اللي بتحصل معاك في رسالة الباسورد
    if (data is String) {
      return data;
    }

    // 2️⃣ الحالة الثانية: لو الرد JSON (Map)
    if (data is Map<String, dynamic>) {
      // أولوية 1: مفتاح 'message'
      if (data['message'] != null) {
        if (data['message'] is List) {
          return (data['message'] as List).join('\n');
        }
        return data['message'].toString();
      }

      // أولوية 2: مفتاح 'error'
      if (data['error'] != null) {
        return data['error'].toString();
      }

      // أولوية 3: مفتاح 'errors' (ممكن يكون Map أو List)
      if (data['errors'] != null) {
        if (data['errors'] is Map) {
          // تجميع القيم من الماب (مثل Laravel validation)
          return (data['errors'] as Map)
              .values
              .map((e) => e.toString())
              .join('\n');
        }
        if (data['errors'] is List) {
          return (data['errors'] as List).join('\n');
        }
        return data['errors'].toString();
      }
    }

    // لو فشلنا في استخراج رسالة مخصصة، نرجع رسالة الحالة
    return response.statusMessage ?? "Unknown Error Occurred";
  }
}
