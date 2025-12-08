import 'package:dio/dio.dart';

import '../cache/cache_data.dart';
import '../cache/cache_helper.dart';
import '../cache/cache_key.dart';
import '../helper/custom_logger.dart';
import 'api_response.dart';
import 'end_points.dart';

class ApiHelper {
  ApiHelper() {
    initDio();
  }

  Dio dio = Dio(BaseOptions(
    baseUrl: EndPoints.baseUrl,
    connectTimeout: Duration(seconds: 10),
    receiveTimeout: Duration(seconds: 10),
  ));

  void initDio() {
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      CustomLogger.green("--- Headers : ${options.headers.toString()}");
      CustomLogger.green("--- endpoint : ${options.path.toString()}");
      return handler.next(options);
    }, onResponse: (response, handler) {
      CustomLogger.green("--- Response : ${response.data.toString()}");
      return handler.next(response);
    }, onError: (DioException error, handler) async {
      CustomLogger.red("--- Error : ${error.response?.data.toString()}");
      //ApiResponse apiResponse = ApiResponse.fromError(error);
      // if (error.response?.data['message'].contains('expired')) {
      //   // refresh token
      //   try {
      //     final apiHelper = getIt<ApiHelper>();
      //     ApiResponse apiResponse = await apiHelper.postRequest(
      //       endPoint: EndPoints.refreshToken,
      //       sendRefreshToken: true,
      //       isProtected: true,
      //     );
      //     if (apiResponse.status) {
      //       // must update token
      //       CacheData.accessToken = apiResponse.data['access_token'];
      //       await CacheHelper.saveData(
      //           key: CacheKeys.accessToken, value: CacheData.accessToken);
      //
      //       // Retry original request
      //       final options = error.requestOptions;
      //       if (options.data is FormData) {
      //         final oldFormData = options.data as FormData;
      //
      //         // Convert FormData to map so it can be rebuilt
      //         final Map<String, dynamic> formMap = {};
      //         for (var entry in oldFormData.fields) {
      //           formMap[entry.key] = entry.value;
      //         }
      //
      //         // Add files if any
      //         for (var file in oldFormData.files) {
      //           formMap[file.key] = file.value;
      //         }
      //
      //         // Rebuild new FormData
      //         options.data = FormData.fromMap(formMap);
      //       }
      //       options.headers['Authorization'] =
      //           'Bearer ${CacheData.accessToken}';
      //       final response = await dio.fetch(options);
      //       return handler.resolve(response);
      //     } else {
      //       // must logout
      //       CacheHelper.removeData(key: CacheKeys.accessToken);
      //       CacheHelper.removeData(key: CacheKeys.refreshToken);
      //       // MyNavigator.goTo(screen: () => LoginScreen(), isReplace: true);
      //       AppConstants.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      //         LoginView.routeName,
      //         (route) => false,
      //       );
      //       return handler.next(error);
      //     }
      //   } catch (e) {
      //     CacheHelper.removeData(key: CacheKeys.accessToken);
      //     CacheHelper.removeData(key: CacheKeys.refreshToken);
      //     // MyNavigator.goTo(screen: () => LoginScreen(), isReplace: true);
      //     AppConstants.navigatorKey.currentState!.pushNamedAndRemoveUntil(
      //       LoginView.routeName,
      //       (route) => false,
      //     );
      //     return handler.next(error);
      //   }
      // }

      return handler.next(error);
    }));
  }

  Future<ApiResponse> postRequest({required String endPoint,
    Map<String, dynamic>? data,
    bool isProtected = false,
    bool sendRefreshToken = false}) async {
    return ApiResponse.fromResponse(
      await dio.post(
        endPoint,
        data: data,
        options: Options(headers: {
          'Content-Type': 'application/json',
          if (isProtected)
            'Authorization':
            'Bearer ${sendRefreshToken ? CacheHelper.getData(
                key: CacheKeys.refreshToken) : CacheData.accessToken}',
        }),
      ),
    );
  }

  Future<ApiResponse> getRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isProtected = false,
  }) async {
    return ApiResponse.fromResponse(
      await dio.get(
        endPoint,
        data: data,
        options: Options(headers: {
          if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
        }),
      ),
    );
  }

  Future<ApiResponse> putRequest({required String endPoint,
    Map<String, dynamic>? data,
    bool isProtected = false}) async {
    return ApiResponse.fromResponse(
      await dio.put(
        endPoint,
        data: data,
        options: Options(headers: {
          if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
        }),
      ),
    );
  }

  Future<ApiResponse> deleteRequest({
    required String endPoint,
    Map<String, dynamic>? data,
    bool isProtected = false,
  }) async {
    return ApiResponse.fromResponse(
      await dio.delete(
        endPoint,
        data: data,
        options: Options(
          headers: {
            if (isProtected) 'Authorization': 'Bearer ${CacheData.accessToken}',
          },
        ),
      ),
    );
  }
}
