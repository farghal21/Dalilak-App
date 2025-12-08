import 'package:dalilak_app/features/on_boarding/views/widgets/on_boarding_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/helper/my_snackbar.dart';
import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../home/views/home_view.dart';
import '../manager/on_boarding_cubit/on_boarding_cubit.dart';
import '../manager/on_boarding_cubit/on_boarding_state.dart';

class OnBoardingView extends StatelessWidget {
  const OnBoardingView({super.key});

  static const String routeName = 'on_boarding';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OnboardingCubit(),
      child: CustomScaffold(
        body: BlocConsumer<OnboardingCubit, OnboardingState>(
          listener: (context, state) {
            if (state is OnboardingFinished) {
              Navigator.pushNamedAndRemoveUntil(
                context,
                HomeView.routeName,
                (route) => false,
              );
            } else if (state is OnboardingError) {
              MySnackbar.error(context, state.errorMessage);
            }
          },
          builder: (context, state) {
            return CustomProgressHud(
              isLoading: state is OnboardingLoading,
              child: OnBoardingViewBody(),
            );
          },
        ),
      ),
    );
  }
}
