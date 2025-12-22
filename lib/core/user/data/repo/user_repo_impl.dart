import 'package:dalilak_app/core/network/api_helper.dart';
import 'package:dalilak_app/core/network/api_response.dart';
import 'package:dalilak_app/core/network/end_points.dart';
import 'package:dalilak_app/core/user/data/models/user_model.dart';
import 'package:dalilak_app/core/user/data/repo/user_repo.dart';
import 'package:dartz/dartz.dart';

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

//
// // update user data
// Future<Either<String, String>> updateUserData({
//   required String name,
//   required String phone,
//   required XFile? imageFile,
// }) async {
//   try {
//     ApiResponse apiResponse = await apiHelper.putRequest(
//       endPoint: EndPoints.updateProfile,
//       isProtected: true,
//       data: {
//         'name': name,
//         'phone': phone,
//         'image': imageFile != null
//             ? await MultipartFile.fromFile(imageFile.path,
//                 filename: imageFile.name)
//             : null,
//       },
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
