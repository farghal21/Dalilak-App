import 'package:dalilak_app/core/user/data/models/user_model.dart';

abstract class UserState {}

// get user states
class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserGetSuccess extends UserState {
  UserModel userModel;

  UserGetSuccess({required this.userModel});
}

class UserGetError extends UserState {
  String error;

  UserGetError({required this.error});
}

// update Account states
class UserUpdateSuccess extends UserState {
  String message;

  UserUpdateSuccess({required this.message});
}

class UserUpdateError extends UserState {
  String error;

  UserUpdateError({required this.error});
}

class UserUpdateLoading extends UserState {}

// delete Account states
class UserDeleteSuccess extends UserState {
  String message;

  UserDeleteSuccess({required this.message});
}

class UserDeleteError extends UserState {
  String error;

  UserDeleteError({required this.error});
}

class UserDeleteLoading extends UserState {}

// change language state
class UserChangeLanguageState extends UserState {}

class UserImageSelectedState extends UserState {}

// ضيف الحالة دي في ملف user_state.dart
class UserUpdateNeedsVerification extends UserState {
  final String email;
  UserUpdateNeedsVerification({required this.email});
}

class UserChangePasswordVisibilityState extends UserState {}
