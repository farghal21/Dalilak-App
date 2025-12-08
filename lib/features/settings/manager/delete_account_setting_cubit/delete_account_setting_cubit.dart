import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'delete_account_setting_state.dart';

class DeleteAccountSettingCubit extends Cubit<DeleteAccountSettingState> {
  DeleteAccountSettingCubit() : super(DeleteAccountSettingInitial());

  static DeleteAccountSettingCubit get(context) =>
      BlocProvider.of<DeleteAccountSettingCubit>(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  void deleteAccount() {
    // if (!formKey.currentState!.validate()) {
    //   return;
    // }

    // Simulate a delay for deleting account
    emit(DeleteAccountSettingLoading());

    Future.delayed(const Duration(seconds: 3), () {
      emit(DeleteAccountSettingSuccess());
    });
  }

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(DeleteAccountSettingVisibilityToggled());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(DeleteAccountSettingVisibilityToggled());
  }
}
