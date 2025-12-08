import 'package:dartz/dartz.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import '../models/chat_response_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiHelper apiHelper;

  HomeRepoImpl(this.apiHelper);

  @override
  Future<Either<String, ChatResponseModel>> sendMessage(
      {required String message}) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.sendMessage,
        data: {
          "message": message,
          "metadata": {
            "source": "mobile",
            "timestamp": DateTime.now().toIso8601String(),
            "language": "ar"
          }
        },
        isProtected: true,
      );

      if (response.status == false) {
        return Left(response.message);
      }

      final ChatResponseModel model =
          ChatResponseModel.fromJson(response.data['data']);
      return Right(model);
    } catch (e) {
      final apiResponse = ApiResponse.fromError(e);
      return Left(apiResponse.message);
    }
  }
}
