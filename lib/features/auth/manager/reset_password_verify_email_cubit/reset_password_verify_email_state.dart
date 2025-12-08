abstract class ResetPasswordVerifyEmailState {}

class ResetPasswordVerifyEmailInitial extends ResetPasswordVerifyEmailState {}

class ResetPasswordVerifyEmailLoading extends ResetPasswordVerifyEmailState {}

class ResetPasswordVerifyEmailSuccess extends ResetPasswordVerifyEmailState {}

class ResetPasswordVerifyEmailFailure extends ResetPasswordVerifyEmailState {
  final String errorMessage;

  ResetPasswordVerifyEmailFailure(this.errorMessage);
}
