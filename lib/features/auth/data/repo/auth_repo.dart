import 'package:dartz/dartz.dart';

import '../../../../core/user/data/models/user_model.dart';

abstract class AuthRepo {
  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  });

  Future<Either<String, UserModel>> login({
    required String email,
    required String password,
  });
}
