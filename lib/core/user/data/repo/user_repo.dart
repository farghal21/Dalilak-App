import 'package:dalilak_app/core/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';

abstract class UserRepo {
  // get user data
  Future<Either<String, UserModel>> getUserData();

  Future<Either<String, String>> updateUserData({
    required String name,
    required String email,
    String? password, // 👈 ضيف السطر ده ضروري جداً
    required XFile? imageFile,
  });
}
