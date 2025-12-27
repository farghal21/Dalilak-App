import 'package:dalilak_app/core/network/api_helper.dart';
import 'package:dalilak_app/core/network/api_response.dart';
import 'package:dalilak_app/core/network/end_points.dart';
import 'package:dalilak_app/core/user/data/models/user_model.dart';
import 'package:dalilak_app/core/user/data/repo/user_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UserRepoImpl extends UserRepo {
  UserRepoImpl({required this.apiHelper});

  ApiHelper apiHelper;

  UserModel userModel = UserModel();

  // get user data
  @override
  Future<Either<String, UserModel>> getUserData() async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getUserData,
        isProtected: true,
      );

      if (response.success) {
        userModel = UserModel.fromJson(response.data['data']);
        return Right(userModel);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }

  @override
  Future<Either<String, String>> updateUserData({
    required String name,
    required String email,
    String? password, // 👈 ضفنا الباسورد هنا عشان لو هنحتاجه
    XFile? imageFile, // 👈 وضفنا ملف الصورة
  }) async {
    try {
      // 1. تجهيز البيانات النصية الأول
      Map<String, dynamic> dataMap = {
        'FullName': name,
        'Email': email,
      };

      // 2. لو المستخدم باعت باسورد (في حالة تغيير الإيميل)، بنضيفه للطلب
      if (password != null && password.isNotEmpty) {
        dataMap['CurrentPassword'] =
            password; // 👈 الاسم ده مهم جداً زي Postman
      }

      // 3. تحويل الماب لـ FormData عشان نقدر نضيف ملفات
      FormData formData = FormData.fromMap(dataMap);

      // 4. إضافة الصورة لو موجودة
      if (imageFile != null) {
        formData.files.add(MapEntry(
          'ProfileImage', // 👈 نفس الاسم اللي في Postman في خانة الـ File
          await MultipartFile.fromFile(
            imageFile.path,
            filename: imageFile.path.split('/').last,
          ),
        ));
      }

      // 5. إرسال الطلب (PUT)
      ApiResponse response = await apiHelper.putRequest(
        endPoint: EndPoints.updateProfile, // تأكد إن الرابط '/api/Auth/profile'
        data: formData,
        isProtected: true,
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

  // update user data

//
// Future<Either<String, String>> deleteUserData() async {
//   try {
//     ApiResponse apiResponse = await apiHelper.deleteRequest(
//       endPoint: EndPoints.deleteUser,
//       isProtected: true,
//     );
//
//     if (apiResponse.status) {
//       return right(apiResponse.message);
//     } else {
//       throw Exception(apiResponse.message);
//     }
//   } catch (e) {
//     ApiResponse apiResponse = ApiResponse.fromError(e);
//     return Left(apiResponse.message);
//   }
// }
}
