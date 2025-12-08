import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../manager/on_boarding_cubit/on_boarding_cubit.dart';

class CustomIndicator extends StatelessWidget {
  final int currentIndex;

  const CustomIndicator({
    required this.currentIndex,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = OnboardingCubit.get(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(cubit.pages.length, (index) {
        final isActive = index <= currentIndex;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: MyResponsive.paddingSymmetric(horizontal: 3.5),
          height: MyResponsive.height(value: 3),
          width: MyResponsive.width(value: 112),
          decoration: BoxDecoration(
            color: isActive ? AppColors.primary : AppColors.fillColor,
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          ),
        );
      }),
    );
  }
}
