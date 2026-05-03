import 'package:dalilak_app/core/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, String>> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  });

  Future<Either<String, String>> verifyEmail({
    required String email,
    required String otp,
  });

  Future<Either<String, String>> forgetPassword({
    required String email,
  });

  Future<Either<String, String>> verifyOtp({
    required String email,
    required String otp,
  });

  Future<Either<String, String>> resendOtp({
    required String email,
  });

  Future<Either<String, String>> resetPassword({
    required String email,
    required String password,
  });

  // 👇 التعديل هنا: الدالة الآن تطلب الباسورد
  Future<Either<String, String>> deleteAccount({required String password});
}
