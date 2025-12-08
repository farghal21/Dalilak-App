import 'package:dalilak_app/features/auth/manager/reset_password_verify_email_cubit/reset_password_verify_email_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordVerifyEmailCubit
    extends Cubit<ResetPasswordVerifyEmailState> {
  ResetPasswordVerifyEmailCubit() : super(ResetPasswordVerifyEmailInitial());

  static ResetPasswordVerifyEmailCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();

  void submitEmail() {
    if (!emailFormKey.currentState!.validate()) {
      return;
    }
    emit(ResetPasswordVerifyEmailLoading());
    // Simulate a network call or any async operation
    Future.delayed(Duration(seconds: 2), () {
      emit(ResetPasswordVerifyEmailSuccess());
    });
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
