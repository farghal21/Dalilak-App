import 'package:dalilak_app/features/auth/manager/reset_password_otp_cubit/reset_password_otp_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordOtpCubit extends Cubit<ResetPasswordOtpState> {
  ResetPasswordOtpCubit() : super(ResetPasswordOtpInitial());

  static ResetPasswordOtpCubit get(context) => BlocProvider.of(context);

  String otpCode = '';
  bool isOtpComplete = false;

  void onOtpChanged(String otp) {
    otpCode = otp;
    isOtpComplete = otp.length == 4; // Assuming OTP length is 4
    emit(ResetPasswordOtpChanged());
  }

  void resendOtp() {
    emit(ResetPasswordOtpLoading());
    // Logic to resend OTP
    Future.delayed(Duration(seconds: 2), () {
      emit(ResetPasswordOtpResent());
    });
  }

  void verifyOtp() {
    if (isOtpComplete) {
      emit(ResetPasswordOtpLoading());
      // Logic to verify OTP
      Future.delayed(Duration(seconds: 2), () {
        emit(ResetPasswordOtpVerified());
      });
    } else {
      emit(ResetPasswordOtpFailure('Please enter a valid OTP'));
    }
  }
}
