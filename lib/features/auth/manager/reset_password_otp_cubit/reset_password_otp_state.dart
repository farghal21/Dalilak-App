abstract class ResetPasswordOtpState {}

class ResetPasswordOtpInitial extends ResetPasswordOtpState {}

class ResetPasswordOtpLoading extends ResetPasswordOtpState {}

class ResetPasswordOtpVerified extends ResetPasswordOtpState {
  final String message;

  ResetPasswordOtpVerified(this.message);
}

class ResetPasswordOtpResend extends ResetPasswordOtpState {
  final String message;

  ResetPasswordOtpResend(this.message);
}

class ResetPasswordOtpFailure extends ResetPasswordOtpState {
  final String errorMessage;

  ResetPasswordOtpFailure(this.errorMessage);
}

class ResetPasswordOtpChanged extends ResetPasswordOtpState {}
