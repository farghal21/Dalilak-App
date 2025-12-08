abstract class RegisterOtpState {}

class RegisterOtpInitial extends RegisterOtpState {}

class RegisterOtpLoading extends RegisterOtpState {}

class RegisterOtpVerified extends RegisterOtpState {}

class RegisterOtpResent extends RegisterOtpState {}

class RegisterOtpFailure extends RegisterOtpState {
  final String errorMessage;

  RegisterOtpFailure(this.errorMessage);
}

class RegisterOtpChanged extends RegisterOtpState {}
