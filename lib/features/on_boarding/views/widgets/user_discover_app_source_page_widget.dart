import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/on_boarding_cubit/on_boarding_cubit.dart';
import '../../manager/on_boarding_cubit/on_boarding_state.dart';
import 'on_boarding_list_view_widget.dart';

class UserDiscoverAppSourcePageWidget extends StatelessWidget {
  const UserDiscoverAppSourcePageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = OnboardingCubit.get(context);
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   AppStrings.howDidYouHearAboutUs,
          //   style: AppTextStyles.semiBold20,
          // ),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: AppStrings.how,
                  style: AppTextStyles.semiBold20,
                ),
                TextSpan(
                  text: AppStrings.appName,
                  style: AppTextStyles.semiBold20
                      .copyWith(color: AppColors.primary),
                ),
                TextSpan(
                  text: AppStrings.where,
                  style: AppTextStyles.semiBold20,
                ),
              ],
            ),
          ),



          // ListView
          BlocBuilder<OnboardingCubit, OnboardingState>(
            builder: (context, state) {
              return ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      cubit.selectUserDiscover(index);
                    },
                    child: OnboardingListViewWidget(
                      title: cubit.discoverOptions[index],
                      isSelected: index == cubit.userDiscoverSelected,
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
