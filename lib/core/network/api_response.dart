import 'package:dio/dio.dart';

import '../helper/custom_logger.dart';
import '../utils/app_strings.dart';

class ApiResponse {
  final bool status;
  final int statusCode;
  final dynamic data;
  final String message;

  ApiResponse({
    required this.status,
    required this.statusCode,
    this.data,
    required this.message,
  });

  // Factory method to handle Dio responses
  factory ApiResponse.fromResponse(Response response) {
    return ApiResponse(
      status: response.data["success"] ?? false,
      statusCode: response.statusCode ?? 500,
      data: response.data,
      message: response.data["message"]['ar'] ?? AppStrings.unknownError['ar'],
    );
  }

  // Factory method to handle Dio or other exceptions
  factory ApiResponse.fromError(dynamic error) {
    // ignore: avoid_print
    CustomLogger.red(error.toString());
    if (error is DioException) {
      // ignore: avoid_print
      return ApiResponse(
        status: false,
        data: error.response?.data,
        statusCode:
        error.response != null ? error.response!.statusCode ?? 500 : 500,
        message: _handleDioError(error),
      );
    } else {
      return ApiResponse(
        status: false,
        statusCode: 500,
        message: AppStrings.unknownError['ar']!,
      );
    }
  }

  static String _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return AppStrings.connectionTimeout['ar']!;
      case DioExceptionType.sendTimeout:
        return AppStrings.sendTimeout['ar']!;
      case DioExceptionType.receiveTimeout:
        return AppStrings.receiveTimeout['ar']!;
      case DioExceptionType.badResponse:
        return _handleServerError(error.response);
      case DioExceptionType.cancel:
        return AppStrings.requestCancelled['ar']!;
      case DioExceptionType.connectionError:
        return AppStrings.noInternet['ar']!;
      default:
        return AppStrings.unknownError['ar']!;
    }
  }

  /// Handling errors from the server response
  static String _handleServerError(Response? response) {
    if (response == null) return AppStrings.noResponse['ar']!;
    if (response.data is Map<String, dynamic>) {
      if (response.data["message"] != null) {
        return response.data["message"]['ar'] ?? AppStrings.serverError['ar']!;
      }
      return AppStrings.serverError['ar']!;
    }
    return "${AppStrings.serverError['ar']!}: ${response.statusMessage}";
  }
}
