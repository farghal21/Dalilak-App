import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/features/auth/data/repo/auth_repo.dart';
import 'package:dalilak_app/features/auth/views/login_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/my_snackbar.dart';
import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/register_cubit/register_cubit.dart';
import '../manager/register_cubit/register_state.dart';
import 'widgets/register_view_body.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  static const String routeName = "register";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(
        getIt<AuthRepo>(),
      ),
      child: PopScope(
        canPop: false,
        child: CustomScaffold(
          body: Builder(builder: (context) {
            return BlocConsumer<RegisterCubit, RegisterState>(
              listener: (context, state) {
                if (state is RegisterFailure) {
                  MySnackbar.error(context, state.errorMessage);
                }
                if (state is RegisterSuccess) {
                  MySnackbar.success(context,
                      'Registration successfully, Login to Verify Your Account');
                  Navigator.pushReplacementNamed(context, LoginView.routeName);
                }
              },
              builder: (context, state) {
                return CustomProgressHud(
                  isLoading: state is RegisterLoading,
                  child: RegisterViewBody(),
                );
              },
            );
          }),
        ),
      ),
    );
  }
}
