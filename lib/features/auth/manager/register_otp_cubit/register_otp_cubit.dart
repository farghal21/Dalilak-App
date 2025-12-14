import 'package:dalilak_app/core/helper/custom_logger.dart';
import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_otp_state.dart';

class RegisterOtpCubit extends Cubit<RegisterOtpState> {
  RegisterOtpCubit(this.repo) : super(RegisterOtpInitial());

  static RegisterOtpCubit get(context) => BlocProvider.of(context);

  String otpCode = '';
  bool isOtpComplete = false;

  AuthRepo repo ;

  void onOtpChanged(String otp) {
    otpCode = otp;
    isOtpComplete = otp.length == 4; // Assuming OTP length is 4
    emit(RegisterOtpChanged());
  }

  void resendOtp({required String email}) async {
    emit(RegisterOtpLoading());

    var result = await repo.resendOtp(email: email);

    result.fold(
          (error) => emit(RegisterOtpFailure(error)),
          (message) => emit(RegisterOtpResend(message)),
    );
  }

  void verifyOtp({required String email}) async {
    if (isOtpComplete) {
      emit(RegisterOtpLoading());
      CustomLogger.white(otpCode) ;

      var result = await repo.verifyEmail(email: email, otp: otpCode);

      result.fold(
            (error) => emit(RegisterOtpFailure(error)),
            (message) => emit(RegisterOtpVerified(message)),
      );
    } else {
      emit(RegisterOtpFailure('Please enter a valid OTP'));
    }
  }
}
