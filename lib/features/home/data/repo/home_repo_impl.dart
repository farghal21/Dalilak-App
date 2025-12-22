import 'package:dalilak_app/features/home/data/models/fetch_chat_messages_response_model.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/network/api_helper.dart';
import '../../../../core/network/api_response.dart';
import '../../../../core/network/end_points.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiHelper apiHelper;

  HomeRepoImpl(this.apiHelper);

  @override
  Future<Either<String, String>> startChat() async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.startChat,
        isProtected: true,
      );

      if (response.success == true) {
        return Right(response.data['data']['sessionId']);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }

  // @override
  // Future<Either<String, ChatResponseModel>> fetchChatMessages(
  //     {required String sessionId}) {
  //   // TODO: implement fetchChatMessages
  //   throw UnimplementedError();
  // }

  @override
  Future<Either<String, SendMessageData>> sendMessage({
    required String sessionId,
    required int userId,
    required String message,
  }) async {
    try {
      ApiResponse response = await apiHelper.postRequest(
        endPoint: EndPoints.sendMessage,
        data: {
          'sessionId': sessionId,
          'userId': userId,
          'message': message,
        },
        isProtected: true,
      );

      if (response.success == true) {
        SendMessageData sendMessageData =
            SendMessageData.fromJson(response.data['data']);
        return Right(sendMessageData);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }
}
