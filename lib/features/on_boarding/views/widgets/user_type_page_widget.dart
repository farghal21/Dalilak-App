import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/on_boarding_cubit/on_boarding_cubit.dart';
import '../../manager/on_boarding_cubit/on_boarding_state.dart';

class UserTypePageWidget extends StatelessWidget {
  const UserTypePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OnboardingCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              AppStrings.hello,
              style: AppTextStyles.semiBold20,
            ),
            Text(
              "محمد",
              style: AppTextStyles.bold20.copyWith(color: AppColors.primary),
            ),
            Text(
              "!!",
              style: AppTextStyles.bold20.copyWith(color: AppColors.primary),
            ),
          ],
        ),
        Text(
          AppStrings.priorityQuestion,
          style: AppTextStyles.semiBold20,
        ),
        SizedBox(
          height: MyResponsive.height(value: 28),
        ),
        SizedBox(
          height: MyResponsive.height(value: 28),
        ),
        BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) {
            return Expanded(
              child: GridView.builder(
                itemCount: cubit.userTypes.length,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  mainAxisSpacing: MyResponsive.height(value: 18),
                  crossAxisSpacing: MyResponsive.width(value: 18),
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      cubit.selectUserType(index);
                    },
                    child: GridViewWidget(
                      userType: cubit.userTypes[index],
                      isSelected: index == cubit.userTypeSelected,
                    ),
                  );
                },
              ),
            );
          },
        )
      ],
    );
  }
}

class GridViewWidget extends StatelessWidget {
  const GridViewWidget({
    super.key,
    required this.userType,
    required this.isSelected,
  });

  final String userType;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
      decoration: BoxDecoration(
        color: isSelected ? AppColors.primary : Colors.transparent,
        border: Border.all(color: AppColors.white, width: 1),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 40)),
      ),
      child: Center(
        child: Text(
          userType,
          style: AppTextStyles.regular16,
        ),
      ),
    );
  }
}
