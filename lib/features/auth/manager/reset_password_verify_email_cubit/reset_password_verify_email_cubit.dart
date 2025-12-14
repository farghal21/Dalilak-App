import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart';
import 'package:dalilak_app/features/auth/manager/reset_password_verify_email_cubit/reset_password_verify_email_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetPasswordVerifyEmailCubit
    extends Cubit<ResetPasswordVerifyEmailState> {
  ResetPasswordVerifyEmailCubit(this.repo)
      : super(ResetPasswordVerifyEmailInitial());

  static ResetPasswordVerifyEmailCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  GlobalKey<FormState> emailFormKey = GlobalKey<FormState>();
  AuthRepo repo;

  void submitEmail() async {
    if (!emailFormKey.currentState!.validate()) {
      return;
    }
    emit(ResetPasswordVerifyEmailLoading());
    var result = await repo.forgetPassword(email: emailController.text);

    result.fold(
      (error) => emit(ResetPasswordVerifyEmailFailure(error)),
      (message) => emit(ResetPasswordVerifyEmailSuccess(
          email: emailController.text, message: message)),
    );
  }

  @override
  Future<void> close() {
    emailController.dispose();
    return super.close();
  }
}
