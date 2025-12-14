import 'package:dalilak_app/features/auth/views/register_otp_view.dart';
import 'package:dalilak_app/features/auth/views/widgets/login_view_body.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/get_it.dart';
import '../../../core/helper/my_snackbar.dart';
import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../home/views/home_view.dart';
import '../data/repo/auth_repo.dart';
import '../manager/login_cubit/login_cubit.dart';
import '../manager/login_cubit/login_state.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = "login";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(
        getIt<AuthRepo>(),
      ),
      child: CustomScaffold(
        body: Builder(builder: (context) {
          return BlocConsumer<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state is LoginFailure) {
                MySnackbar.error(context, state.errorMessage);
              }
              if (state is LoginSuccess) {
                if (state.user.isEmailVerified!) {
                  MySnackbar.success(context, 'Login successfully');
                  Navigator.pushNamedAndRemoveUntil(
                      context, HomeView.routeName, (route) => false);
                } else {
                  MySnackbar.error(
                      context, 'Please verify your email to continue');
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    RegisterOtpView.routeName,
                    (route) => false,
                    arguments: state.user.email!,
                  );
                }
              }
            },
            builder: (context, state) {
              return CustomProgressHud(
                isLoading: state is LoginLoading ? true : false,
                child: LoginViewBody(),
              );
            },
          );
        }),
      ),
    );
  }
}
