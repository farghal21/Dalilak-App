import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/on_boarding_cubit/on_boarding_cubit.dart';
import '../../manager/on_boarding_cubit/on_boarding_state.dart';
import 'on_boarding_list_view_widget.dart';

class UserGoalPageWidget extends StatelessWidget {
  const UserGoalPageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OnboardingCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.goalQuestion,
                  style: AppTextStyles.semiBold20,
                ),
                TextSpan(
                  text: AppStrings.appName,
                  style: AppTextStyles.semiBold20
                      .copyWith(color: AppColors.primary),
                ),
                TextSpan(
                  text: AppStrings.useFor,
                  style: AppTextStyles.semiBold20,
                ),
              ],
            ),
          ),


          // list view
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cubit.userGoals.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      cubit.selectUserGoal(index);
                    },
                    child: OnboardingListViewWidget(
                      title: cubit.userGoals[index],
                      isSelected: index == cubit.userGoalSelected,
                    ),
                  );
                },
                separatorBuilder: (context, index) => SizedBox(
                  height: MyResponsive.height(value: 30),
                ),
              );
            },
          )
        ],
      ),
    );
  }
}
