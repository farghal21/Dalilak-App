abstract class ResetPasswordVerifyEmailState {}

class ResetPasswordVerifyEmailInitial extends ResetPasswordVerifyEmailState {}

class ResetPasswordVerifyEmailLoading extends ResetPasswordVerifyEmailState {}

class ResetPasswordVerifyEmailSuccess extends ResetPasswordVerifyEmailState {
  final String message ;
  final String email;
  ResetPasswordVerifyEmailSuccess({required this.message, required this.email});
}

class ResetPasswordVerifyEmailFailure extends ResetPasswordVerifyEmailState {
  final String errorMessage;

  ResetPasswordVerifyEmailFailure(this.errorMessage);
}
