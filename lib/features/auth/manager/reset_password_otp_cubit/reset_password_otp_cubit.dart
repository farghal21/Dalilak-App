import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reset_password_otp_state.dart';

class ResetPasswordOtpCubit extends Cubit<ResetPasswordOtpState> {
  ResetPasswordOtpCubit(this.repo) : super(ResetPasswordOtpInitial());

  static ResetPasswordOtpCubit get(context) => BlocProvider.of(context);

  String otpCode = '';
  bool isOtpComplete = false;
  AuthRepo repo;

  void onOtpChanged(String otp) {
    otpCode = otp;
    isOtpComplete = otp.length == 4; // Assuming OTP length is 4
    emit(ResetPasswordOtpChanged());
  }

  void resendOtp({required String email}) async {
    emit(ResetPasswordOtpLoading());

    var result = await repo.resendOtp(email: email);

    result.fold(
          (error) => emit(ResetPasswordOtpFailure(error)),
          (message) => emit(ResetPasswordOtpResend(message)),
    );
  }

  void verifyOtp({required String email}) async {
    if (isOtpComplete) {
      emit(ResetPasswordOtpLoading());

      var result = await repo.verifyOtp(email: email, otp: otpCode);

      result.fold(
            (error) => emit(ResetPasswordOtpFailure(error)),
            (message) => emit(ResetPasswordOtpVerified(message)),
      );
    } else {
      emit(ResetPasswordOtpFailure('Please enter a valid OTP'));
    }
  }
}
