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
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) {
    // TODO: implement register
    throw UnimplementedError();
  }
}
