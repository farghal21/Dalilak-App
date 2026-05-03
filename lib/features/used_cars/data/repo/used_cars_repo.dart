import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import '../../../../core/cache/cache_data.dart';
import '../../../../core/helper/custom_logger.dart';
import '../../../../core/network/api_response.dart';
import '../models/car_model.dart';

/// Repository implementation for Used Cars feature
/// Handles all API communication for used cars operations
class UsedCarsRepository {
  final Dio _dio;
  final String _baseUrl;

  UsedCarsRepository({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  /// Add a new used car with images
  ///
  /// Authentication: REQUIRED (Bearer Token)
  /// Content-Type: multipart/form-data
  ///
  /// Parameters:
  /// - [carData]: CarModel containing car information
  /// - [images]: List of image files (1-10 images required)
  ///
  /// Returns Either<String, String> - Left: error message, Right: car ID
  Future<Either<String, String>> addCar({
    required CarModel carData,
    required List<File> images,
  }) async {
    try {
      // Validate images count (1-10 images required)
      if (images.isEmpty) {
        return Left('At least one image is required');
      }
      if (images.length > 10) {
        return Left('Maximum 10 images allowed');
      }

      // Create FormData with PascalCase keys as required by backend
      final formData = FormData.fromMap({
        'Name': carData.name,
        'Price': carData.price.toString(), // Backend expects string
        'Description': carData.description,
        'City': carData.city,
        'BuyerPhoneNumber': carData.buyerPhoneNumber,
        if (carData.createdAtYear != DateTime.now().year)
          'CreatedAtYear': carData.createdAtYear,
      });

      // Add images to FormData
      // Important: Key must be 'Images' (PascalCase) for each file
      for (var image in images) {
        final fileName = image.path.split('/').last;
        formData.files.add(
          MapEntry(
            'Images',
            await MultipartFile.fromFile(
              image.path,
              filename: fileName,
            ),
          ),
        );
      }

      CustomLogger.green('📤 Uploading car with ${images.length} images...');

      // Get auth token
      final token = CacheData.accessToken;
      if (token == null || token.isEmpty) {
        return Left('Authentication token not found. Please login again.');
      }

      // Make POST request with authentication
      final response = await _dio.post(
        'AddYourUsedCar',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Parse response
      final apiResponse = ApiResponse.fromResponse(response);

      CustomLogger.green('📥 Add Car Response: ${apiResponse.success}');
      CustomLogger.green('📥 Response Data: ${apiResponse.data}');

      if (apiResponse.success) {
        // Extract car ID from response
        final carId = apiResponse.data is Map
            ? (apiResponse.data['id']?.toString() ??
                apiResponse.data['data']?['id']?.toString() ??
                '')
            : '';
        CustomLogger.green('✓ Car added successfully with ID: $carId');
        return Right(carId);
      } else {
        final errorMessage = apiResponse.message.isEmpty
            ? 'Failed to add car. Please try again.'
            : apiResponse.message;
        CustomLogger.red('✗ Failed to add car: $errorMessage');
        return Left(errorMessage);
      }
    } on DioException catch (e) {
      CustomLogger.red('✗ DioException: ${e.message}');
      return Left(_handleDioError(e));
    } catch (e) {
      CustomLogger.red('✗ Unexpected error: $e');
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Get all used cars with pagination
  ///
  /// Authentication: NOT REQUIRED (Public Endpoint)
  ///
  /// Parameters:
  /// - [page]: Page number (default: 1, minimum: 1)
  /// - [pageSize]: Items per page (default: 10, minimum: 1, maximum: 100)
  ///
  /// Returns Either<String, Map> where Map contains:
  /// - 'cars': List<CarModel>
  /// - 'totalCount': int
  /// - 'page': int
  /// - 'pageSize': int
  /// - 'totalPages': int
  Future<Either<String, Map<String, dynamic>>> getAllCars({
    int page = 1,
    int pageSize = 10,
  }) async {
    try {
      // Validate pagination parameters
      if (page < 1) page = 1;
      if (pageSize < 1) pageSize = 10;
      if (pageSize > 100) pageSize = 100;

      // Make GET request WITHOUT authentication (public endpoint)
      final response = await _dio.get(
        'GetAllUsedCars',
        queryParameters: {
          'page': page,
          'pageSize': pageSize,
        },
        options: Options(
          headers: {
            // Do NOT send Authorization header - this is a public endpoint
          },
        ),
      );

      // Parse response
      final apiResponse = ApiResponse.fromResponse(response);

      CustomLogger.green('📥 API Response Success: ${apiResponse.success}');
      CustomLogger.green(
          '📥 API Response Data Type: ${apiResponse.data.runtimeType}');

      if (apiResponse.success && apiResponse.data != null) {
        // Extract data from response structure: data -> usedCars
        final data = apiResponse.data as Map<String, dynamic>;
        CustomLogger.green('📥 Data keys: ${data.keys.toList()}');

        // Try to get usedCars from nested structure
        final usedCarsList = (data['usedCars'] ??
            data['data']?['usedCars'] ??
            []) as List<dynamic>;

        // Parse cars list
        final cars = usedCarsList
            .map(
                (carJson) => CarModel.fromJson(carJson as Map<String, dynamic>))
            .toList();

        // Build result with pagination metadata
        final result = {
          'cars': cars,
          'totalCount': data['totalCount'] ?? 0,
          'page': data['page'] ?? page,
          'pageSize': data['pageSize'] ?? pageSize,
          'totalPages': data['totalPages'] ?? 0,
        };

        CustomLogger.green(
            '✓ Retrieved ${cars.length} cars (Page $page of ${result['totalPages']})');

        return Right(result);
      } else {
        final errorMessage = apiResponse.message.isEmpty
            ? 'Failed to retrieve cars. Please try again.'
            : apiResponse.message;
        CustomLogger.red('✗ Failed to retrieve cars: $errorMessage');
        return Left(errorMessage);
      }
    } on DioException catch (e) {
      CustomLogger.red('✗ DioException: ${e.message}');
      return Left(_handleDioError(e));
    } catch (e) {
      CustomLogger.red('✗ Unexpected error: $e');
      return Left('An unexpected error occurred. Please try again.');
    }
  }

  /// Get full image URL by appending base URL to relative path
  ///
  /// Example: /used-cars/guid1.jpg -> https://base-url.com/used-cars/guid1.jpg
  String getFullImageUrl(String relativePath) {
    if (relativePath.startsWith('http')) {
      return relativePath; // Already a full URL
    }

    // Remove trailing slash from base URL if exists
    final cleanBaseUrl = _baseUrl.endsWith('/')
        ? _baseUrl.substring(0, _baseUrl.length - 1)
        : _baseUrl;

    // Remove leading slash from relative path if exists
    final cleanPath =
        relativePath.startsWith('/') ? relativePath.substring(1) : relativePath;

    return '$cleanBaseUrl/$cleanPath';
  }

  /// Handle Dio errors and return user-friendly messages
  String _handleDioError(DioException e) {
    if (e.response != null) {
      final statusCode = e.response!.statusCode;
      final data = e.response!.data;

      switch (statusCode) {
        case 400:
          // Bad Request - Validation errors
          if (data is Map<String, dynamic> && data['message'] != null) {
            return data['message'].toString();
          }
          return 'Invalid request. Please check your input and try again.';

        case 401:
          // Unauthorized - Invalid or expired token
          return 'Authentication failed. Please login again.';

        case 403:
          // Forbidden
          return 'You do not have permission to perform this action.';

        case 404:
          // Not Found
          return 'The requested resource was not found.';

        case 500:
          // Internal Server Error
          return 'Server error occurred. Please try again later.';

        default:
          return 'An error occurred (Code: $statusCode). Please try again.';
      }
    }

    // Network errors
    if (e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout) {
      return 'Connection timeout. Please check your internet connection.';
    }

    if (e.type == DioExceptionType.connectionError) {
      return 'No internet connection. Please check your network settings.';
    }

    return 'Network error occurred. Please try again.';
  }
}
