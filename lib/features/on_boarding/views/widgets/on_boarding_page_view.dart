import 'package:flutter/material.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../manager/on_boarding_cubit/on_boarding_cubit.dart';

class OnBoardingPageView extends StatelessWidget {
  const OnBoardingPageView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = OnboardingCubit.get(context);
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 40),
      child: PageView(
        controller: cubit.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: cubit.pages,
      ),
    );
  }
}
