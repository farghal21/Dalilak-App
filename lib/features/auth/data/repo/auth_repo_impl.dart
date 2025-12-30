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

  // ملحوظة: لم نعد بحاجة لدالة _extractErrorMessage هنا
  // لأن ApiResponse الجديد يقوم بهذه المهمة بذكاء داخل ApiHelper

  @override
  Future<Either<String, UserModel>> login(
      {required String email, required String password}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {'email': email, 'password': password},
      );

      // ✅ التعديل الأهم: لو فشل، رجع الرسالة علطول بدون Throw
      if (!response.success) {
        return Left(
            response.message); // الرسالة هنا هتكون "Password must be..."
      }

      LoginResponseModel loginResponseModel =
          LoginResponseModel.fromJson(response.data);

      // تخزين التوكن
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
      // الـ Catch دي هتمسك بس أخطاء الـ Parsing أو أخطاء الكود
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> register(
      {required String fullName,
      required String email,
      required String password}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.register,
        data: {
          'fullName': fullName,
          'email': email,
          'password': password,
          'confirmPassword': password,
        },
      );

      // ✅ التعديل الأهم: لو فشل، رجع الرسالة علطول
      if (!response.success) {
        return Left(response.message);
      }

      return Right(response.message);
    } catch (e) {
      return Left(e.toString());
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

      if (!response.success) {
        return Left(response.message);
      }

      return Right(response.message);
    } catch (e) {
      return Left(e.toString());
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

      if (!response.success) {
        return Left(response.message);
      }

      return Right(response.message);
    } catch (e) {
      return Left(e.toString());
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

      if (!response.success) {
        return Left(response.message);
      }

      return Right(response.message);
    } catch (e) {
      return Left(e.toString());
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

      if (!response.success) {
        return Left(response.message);
      }

      return Right(response.message);
    } catch (e) {
      return Left(e.toString());
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

      if (!response.success) {
        return Left(response.message);
      }

      return Right(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> deleteAccount(
      {required String password}) async {
    try {
      ApiResponse response = await apiHelper.deleteRequest(
        endPoint: EndPoints.deleteAccount,
        isProtected: true,
        data: {
          'currentPassword': password,
          'confirmPassword': password,
        },
      );

      if (!response.success) {
        return Left(response.message);
      }

      return Right(response.message);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
