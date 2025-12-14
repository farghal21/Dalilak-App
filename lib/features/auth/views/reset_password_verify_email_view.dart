import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/core/helper/my_snackbar.dart';
import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart';
import 'package:dalilak_app/features/auth/views/reset_password_otp_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../core/utils/app_strings.dart';
import '../manager/reset_password_verify_email_cubit/reset_password_verify_email_cubit.dart';
import '../manager/reset_password_verify_email_cubit/reset_password_verify_email_state.dart';
import 'widgets/reset_password_widget.dart';

class ResetPasswordVerifyEmailView extends StatelessWidget {
  const ResetPasswordVerifyEmailView({super.key});

  static const String routeName = "reset_password";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordVerifyEmailCubit(
        getIt<AuthRepo>(),
      ),
      child: CustomScaffold(
        body: BlocConsumer<ResetPasswordVerifyEmailCubit,
            ResetPasswordVerifyEmailState>(
          listener: (context, state) {
            if (state is ResetPasswordVerifyEmailSuccess) {
              MySnackbar.success(context, state.message);
              Navigator.pushNamed(
                context,
                ResetPasswordOtpView.routeName,
                arguments: state.email,
              );
            }
            if (state is ResetPasswordVerifyEmailFailure) {
              MySnackbar.error(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            final cubit = ResetPasswordVerifyEmailCubit.get(context);
            return CustomProgressHud(
              isLoading: state is ResetPasswordVerifyEmailLoading,
              child: ResetPasswordWidget(
                controller: cubit.emailController,
                subtitle: AppStrings.resetPasswordSubtitle,
                textFieldType: TextFieldType.email,
                onPressed: cubit.submitEmail,
                formKey: cubit.emailFormKey,
              ),
            );
          },
        ),
      ),
    );
  }
}
