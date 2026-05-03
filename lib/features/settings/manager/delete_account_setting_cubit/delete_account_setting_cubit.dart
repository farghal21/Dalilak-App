import 'package:dalilak_app/core/cache/cache_helper.dart';
import 'package:dalilak_app/core/cache/cache_key.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/data/repo/auth_repo.dart';

import 'delete_account_setting_state.dart';

class DeleteAccountSettingCubit extends Cubit<DeleteAccountSettingState> {
  final AuthRepo authRepo;

  DeleteAccountSettingCubit(this.authRepo)
      : super(DeleteAccountSettingInitial());

  static DeleteAccountSettingCubit get(context) =>
      BlocProvider.of<DeleteAccountSettingCubit>(context);

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  Future<void> deleteAccount() async {
    // 1. تحقق أن الحقلين في الشاشة متطابقين قبل الإرسال
    if (passwordController.text != confirmPasswordController.text) {
      emit(DeleteAccountSettingError(
          errMessage: "كلمات المرور غير متطابقة في الشاشة"));
      return;
    }

    emit(DeleteAccountSettingLoading());

    // 2. إرسال الباسورد للـ Repo
    final result = await authRepo.deleteAccount(
      password: passwordController.text,
    );

    result.fold(
      (error) async {
        emit(DeleteAccountSettingError(errMessage: error));
      },
      (success) async {
        await CacheHelper.removeData(key: CacheKeys.accessToken);
        await CacheHelper.removeData(key: CacheKeys.refreshToken);
        emit(DeleteAccountSettingSuccess(message: success));
      },
    );
  }

  void changePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibilityState());
  }

  void changeConfirmPasswordVisibility() {
    isConfirmPasswordVisible = !isConfirmPasswordVisible;
    emit(ChangeConfirmPasswordVisibilityState());
  }

  @override
  Future<void> close() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
