import 'package:dalilak_app/features/auth/manager/reset_password_new_password_cubit/reset_password_new_password_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordNewPasswordCubit
    extends Cubit<ResetPasswordNewPasswordState> {
  ResetPasswordNewPasswordCubit() : super(ResetPasswordNewPasswordInitial());

  static ResetPasswordNewPasswordCubit get(context) => BlocProvider.of(context);

  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> passwordFormKey = GlobalKey<FormState>();
  bool obsecure = true;
  bool confirmObsecure = true;

  void submitNewPassword() {
    if (!passwordFormKey.currentState!.validate()) {
      return;
    }
    emit(ResetPasswordNewPasswordLoading());
    // Simulate a network call or any async operation
    Future.delayed(Duration(seconds: 2), () {
      emit(ResetPasswordNewPasswordSuccess());
    });
  }

  void changeObsecurePassword() {
    obsecure = !obsecure;
    emit(ResetPasswordNewPasswordToggled());
  }

  void changeConfirmObsecurePassword() {
    confirmObsecure = !confirmObsecure;
    emit(ResetPasswordNewPasswordToggled());
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
