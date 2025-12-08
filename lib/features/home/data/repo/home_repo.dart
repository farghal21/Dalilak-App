import 'package:dartz/dartz.dart';

import '../models/chat_response_model.dart';

abstract class HomeRepo {
  Future<Either<String, ChatResponseModel>> sendMessage({
    required String message,
  });
}
