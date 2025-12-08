import 'package:dalilak_app/features/auth/views/reset_password_new_pass_view.dart';
import 'package:dalilak_app/features/auth/views/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/reset_password_otp_cubit/reset_password_otp_cubit.dart';
import '../manager/reset_password_otp_cubit/reset_password_otp_state.dart';

class ResetPasswordOtpView extends StatelessWidget {
  const ResetPasswordOtpView({super.key});

  static const String routeName = 'reset-password-otp';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResetPasswordOtpCubit(),
      child: CustomScaffold(
        body: BlocConsumer<ResetPasswordOtpCubit, ResetPasswordOtpState>(
          listener: (context, state) {
            if (state is ResetPasswordOtpVerified) {
              Navigator.pushReplacementNamed(
                context,
                ResetPasswordNewPassView.routeName,
              );
            }
          },
          builder: (context, state) {
            final cubit = ResetPasswordOtpCubit.get(context);
            return CustomProgressHud(
              isLoading: state is ResetPasswordOtpLoading,
              child: OtpWidget(
                onOtpChanged: cubit.onOtpChanged,
                onResendOtp: cubit.resendOtp,
                onVerifyOtp: cubit.verifyOtp,
                isOtpComplete: cubit.isOtpComplete,
              ),
            );
          },
        ),
      ),
    );
  }
}
