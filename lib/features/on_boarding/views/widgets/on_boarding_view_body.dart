import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../auth/views/widgets/main_image_widget.dart';
import '../../manager/on_boarding_cubit/on_boarding_cubit.dart';
import 'custom_indicator.dart';
import 'on_boarding_page_view.dart';

class OnBoardingViewBody extends StatelessWidget {
  const OnBoardingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OnboardingCubit.get(context);
    return Column(
      children: [
        const MainImageWidget(),
        SizedBox(
          height: MyResponsive.height(value: 50),
        ),
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 40),
          child: CustomIndicator(currentIndex: cubit.currentPage),
        ),
        SizedBox(
          height: MyResponsive.height(value: 74),
        ),
        Expanded(
          child: OnBoardingPageView(),
        ),
        // Spacer(),
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 40),
          child: Row(
            children: [
              Visibility(
                visible: cubit.currentPage != 0,
                maintainSize: true,
                maintainAnimation: true,
                maintainState: true,
                child: CustomButton(
                  title: AppStrings.back,
                  onPressed: cubit.previousPage,
                  width: MyResponsive.width(value: 105),
                  height: MyResponsive.height(value: 31),
                  backgroundColor: AppColors.fillColor,
                ),
              ),
              Spacer(),
              CustomButton(
                title: cubit.isLastPage() ? AppStrings.finish : AppStrings.next,
                onPressed: cubit.nextTurnOn
                    ? (cubit.isLastPage() ? cubit.finish : cubit.nextPage)
                    : null,
                width: MyResponsive.width(value: 105),
                height: MyResponsive.height(value: 31),
                backgroundColor:
                    cubit.nextTurnOn ? AppColors.primary : AppColors.fillColor,
              ),
            ],
          ),
        ),
        SizedBox(
          height: MyResponsive.height(value: 95),
        ),
      ],
    );
  }
}
