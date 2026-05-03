import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repo/auth_repo.dart';
import 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this.authRepo) : super(LoginInitial());
  AuthRepo authRepo;

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool obsecure = true;

  void login() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(LoginLoading());
    var result = await authRepo.login(
      email: emailController.text,
      password: passwordController.text,
    );

    result.fold(
      (error) {
        // التأكد إن الـ Cubit لم يغلق قبل تحديث الحالة
        if (!isClosed) emit(LoginFailure(error));
      },
      (user) {
        if (!isClosed) emit(LoginSuccess(user));
      },
    );
  }

  void changeObsecure() {
    obsecure = !obsecure;
    emit(VisibilityToggled());
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
