import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this.repo) : super(RegisterInitial());

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

  AuthRepo repo;

  void register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }
    emit(RegisterLoading());
    var result = await repo.register(
      email: emailController.text,
      password: passwordController.text,
      fullName: fullName.text,
    );

    result.fold(
      (error) {
        if (!isClosed) emit(RegisterFailure(error));
      },
      (message) {
        if (!isClosed) emit(RegisterSuccess(message, emailController.text));
      },
    );
  }

  void changeObsecurePassword() {
    obsecure = !obsecure;
    emit(VisibilityToggled());
  }

  void changeConfirmObsecurePassword() {
    confirmObsecure = !confirmObsecure;
    emit(VisibilityToggled());
  }
}
