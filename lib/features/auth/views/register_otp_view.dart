import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart';
import 'package:dalilak_app/features/auth/views/register_done_view.dart';
import 'package:dalilak_app/features/auth/views/widgets/otp_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/my_snackbar.dart';
import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/register_otp_cubit/register_otp_cubit.dart';
import '../manager/register_otp_cubit/register_otp_state.dart';

class RegisterOtpView extends StatelessWidget {
  const RegisterOtpView({super.key, required this.email});
  final String email;

  static const String routeName = 'register-otp';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => RegisterOtpCubit(
        getIt<AuthRepo>(),
      ),
      child: Builder(builder: (context) {
        return CustomScaffold(
          body: BlocConsumer<RegisterOtpCubit, RegisterOtpState>(
            listener: (context, state) {
              if (state is RegisterOtpVerified) {
                Navigator.pushReplacementNamed(
                    context, RegisterDoneView.routeName);
              }
              if (state is RegisterOtpFailure) {
                MySnackbar.error(context, state.errorMessage);
              }
            },
            builder: (context, state) {
              var cubit = RegisterOtpCubit.get(context);
              return CustomProgressHud(
                isLoading: state is RegisterOtpLoading,
                child: OtpWidget(
                  onOtpChanged: cubit.onOtpChanged,
                  onResendOtp: () => cubit.resendOtp(email: email),
                  onVerifyOtp: () => cubit.verifyOtp(email: email),
                  isOtpComplete: cubit.isOtpComplete,
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
