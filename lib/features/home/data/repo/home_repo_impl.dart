import 'package:dalilak_app/features/home/data/models/fetch_chat_messages_response_model.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
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

  @override
  Future<Either<String, FetchChatMessagesData>> fetchChatMessages(
      {required String sessionId}) async {
    try {
      ApiResponse response = await apiHelper.getRequest(
        endPoint: EndPoints.fetchMessages(sessionId),
        isProtected: true,
      );

      if (response.success == true) {
        FetchChatMessagesData fetchData =
            FetchChatMessagesData.fromJson(response.data['data']);
        return Right(fetchData);
      } else {
        throw Exception(response.message);
      }
    } catch (e) {
      ApiResponse errorResponse = ApiResponse.fromError(e);
      return Left(errorResponse.message);
    }
  }

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

      // التحقق من حالة الخطأ 500 أو Timeout
      if (response.statusCode == 500) {
        return Left('السيرفر يواجه مشكلة، حاول مجدداً');
      }

      // التحقق من رسائل الـ Timeout المحددة
      if (response.message.contains('timeout') ||
          response.message.contains('Timeout')) {
        return Left('السيرفر استغرق وقتاً طويلاً، حاول مجدداً');
      }

      if (response.success == true && response.data != null) {
        SendMessageData sendMessageData =
            SendMessageData.fromJson(response.data['data']);
        return Right(sendMessageData);
      } else {
        // نضمن إرجاع رسالة خطأ نصية وليست null
        return Left(response.message);
      }
    } catch (e) {
      // في حالة الكراش الأخير اللي ظهر بـ null
      ApiResponse errorResponse = ApiResponse.fromError(e);
      String errorMessage = errorResponse.message;

      // إضافة رسالة افتراضية في حالة كانت الرسالة فارغة
      if (errorMessage.isEmpty) {
        errorMessage = 'حدث خطأ غير متوقع، حاول مجدداً';
      }

      return Left(errorMessage);
    }
  }
}
