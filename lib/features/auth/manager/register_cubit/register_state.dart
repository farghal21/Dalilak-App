abstract class RegisterState {}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterSuccess extends RegisterState {}

class RegisterFailure extends RegisterState {
  final String errorMessage;

  RegisterFailure(this.errorMessage);
}

class VisibilityToggled extends RegisterState {}

class OtpUpdated extends RegisterState {}

class OtpResent extends RegisterState {}

class OtpVerified extends RegisterState {}

class OtpVerificationFailed extends RegisterState {
  final String errorMessage;

  OtpVerificationFailed(this.errorMessage);
}
