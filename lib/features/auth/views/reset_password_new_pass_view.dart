import 'package:dalilak_app/features/auth/views/reset_password_done_view.dart';
import 'package:dalilak_app/features/auth/views/widgets/reset_password_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/my_snackbar.dart';
import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../core/utils/app_strings.dart';
import '../manager/reset_password_new_password_cubit/reset_password_new_password_cubit.dart';
import '../manager/reset_password_new_password_cubit/reset_password_new_password_state.dart';

class ResetPasswordNewPassView extends StatelessWidget {
  const ResetPasswordNewPassView({super.key});

  static const String routeName = "reset_password_new_pass";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordNewPasswordCubit(),
      child: CustomScaffold(
        body: BlocConsumer<ResetPasswordNewPasswordCubit,
            ResetPasswordNewPasswordState>(
          listener: (context, state) {
            if (state is ResetPasswordNewPasswordSuccess) {
              Navigator.pushReplacementNamed(
                context,
                ResetPasswordDoneView.routeName,
              );
            } else if (state is ResetPasswordNewPasswordFailure) {
              // Show error message
              MySnackbar.error(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            final cubit = ResetPasswordNewPasswordCubit.get(context);
            return CustomProgressHud(
              isLoading: state is ResetPasswordNewPasswordLoading,
              child: ResetPasswordWidget(
                controller: cubit.passwordController,
                subtitle: AppStrings.addNewPassword,
                textFieldType: TextFieldType.password,
                confirmPasswordController: cubit.confirmPasswordController,
                obscureTextPass: cubit.obsecure,
                obscureTextConfirmPass: cubit.confirmObsecure,
                onSuffixTapPass: cubit.changeObsecurePassword,
                onSuffixTapConfirmPass: cubit.changeConfirmObsecurePassword,
                onPressed: cubit.submitNewPassword,
                formKey: cubit.passwordFormKey,
              ),
            );
          },
        ),
      ),
    );
  }
}
