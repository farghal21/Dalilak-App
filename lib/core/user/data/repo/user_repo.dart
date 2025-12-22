import 'package:dalilak_app/core/user/data/models/user_model.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  // get user data
  Future<Either<String, UserModel>> getUserData();
}
