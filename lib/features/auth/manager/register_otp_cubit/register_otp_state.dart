abstract class RegisterOtpState {}

class RegisterOtpInitial extends RegisterOtpState {}

class RegisterOtpLoading extends RegisterOtpState {}

class RegisterOtpVerified extends RegisterOtpState {
  final String message;

  RegisterOtpVerified(this.message);
}

class RegisterOtpResend extends RegisterOtpState {
  final String message;

  RegisterOtpResend(this.message);
}

class RegisterOtpFailure extends RegisterOtpState {
  final String errorMessage;

  RegisterOtpFailure(this.errorMessage);
}

class RegisterOtpChanged extends RegisterOtpState {}
