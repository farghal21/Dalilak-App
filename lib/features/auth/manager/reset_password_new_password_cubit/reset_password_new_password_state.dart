abstract class ResetPasswordNewPasswordState {}

class ResetPasswordNewPasswordInitial extends ResetPasswordNewPasswordState {}

class ResetPasswordNewPasswordLoading extends ResetPasswordNewPasswordState {}

class ResetPasswordNewPasswordSuccess extends ResetPasswordNewPasswordState {}

class ResetPasswordNewPasswordFailure extends ResetPasswordNewPasswordState {
  final String errorMessage;

  ResetPasswordNewPasswordFailure(this.errorMessage);
}

class ResetPasswordNewPasswordToggled extends ResetPasswordNewPasswordState {}
