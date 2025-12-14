import 'package:dartz/dartz.dart';

import '../../../../core/cache/cache_data.dart';
import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_key.dart';
import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../../../../core/user/data/models/user_model.dart';
import '../models/login_response_model.dart';
import 'auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  ApiHelper apiHelper;

  AuthRepoImpl({required this.apiHelper});

  @override
  Future<Either<String, UserModel>> login(
      {required String email, required String password}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'email': email, 'password': password},
      );

      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(response.data);

      if (loginResponseModel.success == null ||
          loginResponseModel.success == false) {
        throw Exception(loginResponseModel.message!);
      }

      // store tokens
      await CacheHelper.saveData(
          key: CacheKeys.accessToken,
          value: loginResponseModel.data!.accessToken);
      await CacheHelper.saveData(
          key: CacheKeys.refreshToken,
          value: loginResponseModel.data!.refreshToken);
      CacheData.accessToken = loginResponseModel.data!.accessToken;
      CacheData.refreshToken = loginResponseModel.data!.refreshToken;

      return Right(loginResponseModel.data!.user!);
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  @override
  Future<Either<String, String>> register(
      {
        required String fullName,
      required String email,
      required String password}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'fullName' : fullName,
          'email': email,
          'password': password,
          'confirmPassword': password,
        },
      );

      if (response.success == false) {
        throw Exception(response.message);
      }

      return Right(response.message);
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  @override
  Future<Either<String, String>> forgetPassword({required String email}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.forgotPassword,
        data: {
          'email': email,
        },
      );

      if (response.success == false) {
        throw Exception(response.message);
      }

      return Right(response.message);
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  @override
  Future<Either<String, String>> verifyEmail(
      {required String email, required String otp}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.verifyEmail,
        data: {
          'email': email,
          'otpCode': otp,
        },
      );

      if (response.success == false) {
        throw Exception(response.message);
      }

      return Right(response.message);
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }


  @override
  Future<Either<String, String>> verifyOtp(
      {required String email, required String otp}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.verifyOtp,
        data: {
          'email': email,
          'otpCode': otp,
        },
      );

      if (response.success == false) {
        throw Exception(response.message);
      }

      return Right(response.message);
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  @override
  Future<Either<String, String>> resendOtp({required String email}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.resendOtp,
        data: {
          'email': email,
        },
      );

      if (response.success == false) {
        throw Exception(response.message);
      }

      return Right(response.message);
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  @override
  Future<Either<String, String>> resetPassword(
      {required String email, required String password}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.resetPassword,
        data: {
          'email': email,
          'password': password,
          'confirmPassword': password,
        },
      );

      if (response.success == false) {
        throw Exception(response.message);
      }

      return Right(response.message);
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }
}
