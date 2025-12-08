import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController fullName = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obsecure = true;
  bool confirmObsecure = true;
  String otpCode = '';
  bool isOtpComplete = false;

  void register() {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(RegisterLoading());
    // Perform login logic here
    // On success:
    Future.delayed(Duration(seconds: 2), () {
      emit(RegisterSuccess());
    }); // On failure:
    // emit(RegisterFailure("Error message"));
  }

  void changeObsecurePassword() {
    obsecure = !obsecure;
    emit(VisibilityToggled());
  }

  void changeConfirmObsecurePassword() {
    confirmObsecure = !confirmObsecure;
    emit(VisibilityToggled());
  }

  void onOtpChanged(String code) {
    otpCode = code;
    isOtpComplete = otpCode.length == 4;
    emit(OtpUpdated());
  }

  void verifyOtp() {
    if (otpCode.length == 4) {
      emit(OtpVerified());
    }
  }

  void resendOtp() {
    emit(OtpResent());
  }

  @override
  Future<void> close() {
    fullName.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
