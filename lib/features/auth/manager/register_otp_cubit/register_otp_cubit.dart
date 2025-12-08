import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_otp_state.dart';

class RegisterOtpCubit extends Cubit<RegisterOtpState> {
  RegisterOtpCubit() : super(RegisterOtpInitial());

  static RegisterOtpCubit get(context) => BlocProvider.of(context);

  String otpCode = '';
  bool isOtpComplete = false;

  void onOtpChanged(String otp) {
    otpCode = otp;
    isOtpComplete = otp.length == 4; // Assuming OTP length is 4
    emit(RegisterOtpChanged());
  }

  void resendOtp() {
    emit(RegisterOtpLoading());
    // Logic to resend OTP
    Future.delayed(Duration(seconds: 2), () {
      emit(RegisterOtpResent());
    });
  }

  void verifyOtp() {
    if (isOtpComplete) {
      emit(RegisterOtpLoading());
      // Logic to verify OTP
      Future.delayed(Duration(seconds: 2), () {
        emit(RegisterOtpVerified());
      });
    } else {
      emit(RegisterOtpFailure('Please enter a valid OTP'));
    }
  }
}
