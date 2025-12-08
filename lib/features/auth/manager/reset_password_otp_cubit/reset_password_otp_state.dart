abstract class ResetPasswordOtpState {}

class ResetPasswordOtpInitial extends ResetPasswordOtpState {}

class ResetPasswordOtpLoading extends ResetPasswordOtpState {}

class ResetPasswordOtpVerified extends ResetPasswordOtpState {}

class ResetPasswordOtpResent extends ResetPasswordOtpState {}

class ResetPasswordOtpFailure extends ResetPasswordOtpState {
  final String errorMessage;

  ResetPasswordOtpFailure(this.errorMessage);
}

class ResetPasswordOtpChanged extends ResetPasswordOtpState {}
