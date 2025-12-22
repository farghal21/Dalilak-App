import 'package:dalilak_app/features/chat_history/data/models/get_chat_history_response_model.dart';
import 'package:dartz/dartz.dart';

abstract class ChatHistoryRepo {
  Future<Either<String, List<Sessions>>> fetchChatHistory();
  Future<Either<String, String>> renameSession(
      {required String newName, required String sessionId});
  Future<Either<String, String>> removeSession({required String sessionId});
}
