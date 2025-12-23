import 'package:dalilak_app/features/home/data/models/fetch_chat_messages_response_model.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<String, String>> startChat();

  Future<Either<String, FetchChatMessagesData>> fetchChatMessages({
    required String sessionId,
  });

  Future<Either<String, SendMessageData>> sendMessage({
    required String sessionId,
    required int userId,
    required String message,
  });
}
