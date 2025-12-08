import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class CustomBillPeriodCardWidget extends StatelessWidget {
  const CustomBillPeriodCardWidget(
      {super.key, required this.title, required this.amount});

  final String title;
  final double amount;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: MyResponsive.paddingSymmetric(horizontal: 33, vertical: 16),
      decoration: BoxDecoration(
          color: AppColors.appFill,
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 15)),
          border: Border.all(
            color: AppColors.white.withValues(alpha: .1),
            width: 1,
          )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.semiBold22,
          ),
          SizedBox(
            height: MyResponsive.height(value: 16),
          ),
          Text(
            '$amount  ${AppStrings.rs}',
            style: AppTextStyles.semiBold28,
          ),
        ],
      ),
    );
  }
}
