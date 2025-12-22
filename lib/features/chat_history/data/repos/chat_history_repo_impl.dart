import 'package:dalilak_app/core/network/api_helper.dart';
import 'package:dalilak_app/core/network/api_response.dart';
import 'package:dalilak_app/core/network/end_points.dart';
import 'package:dalilak_app/features/chat_history/data/models/get_chat_history_response_model.dart';
import 'package:dalilak_app/features/chat_history/data/repos/chat_history_repo.dart';
import 'package:dartz/dartz.dart';

class ChatHistoryRepoImpl extends ChatHistoryRepo {
  ApiHelper apiHelper;
  ChatHistoryRepoImpl({required this.apiHelper});

  @override
  Future<Either<String, List<Sessions>>> fetchChatHistory() async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        endPoint: EndPoints.getChatHistory,
        isProtected: true,
      );

      if (response.success == true) {
        Data tripsResponseModel = Data.fromJson(response.data['data']);
        return Right(tripsResponseModel.sessions!);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }

  @override
  Future<Either<String, String>> renameSession(
      {required String newName, required String sessionId}) async {
    try {
      ApiResponse response = await apiHelper.putRequest(
        endPoint: EndPoints.renameSession(sessionId),
        data: {
          'newName': newName,
        },
        isProtected: true,
      );

      if (response.success == true) {
        return Right(response.message);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }

  @override
  Future<Either<String, String>> removeSession(
      {required String sessionId}) async {
    try {
      ApiResponse response = await apiHelper.deleteRequest(
        endPoint: EndPoints.removeSession(sessionId),
        isProtected: true,
      );

      if (response.success == true) {
        return Right(response.message);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }
}
