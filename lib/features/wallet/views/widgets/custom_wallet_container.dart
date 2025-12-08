import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'circular_percent_widget.dart';

class CustomWalletContainer extends StatelessWidget {
  const CustomWalletContainer({
    super.key,
    required this.title,
    required this.amount,
    required this.percentage,
  });

  final String title;
  final double amount;
  final double percentage;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: MyResponsive.paddingSymmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.appFill,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        border: Border.all(
          color: AppColors.white.withValues(alpha: 0.1),
          width: MyResponsive.width(value: 1),
        ),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.semiBold22,
              ),
              SizedBox(
                height: MyResponsive.height(value: 100),
              ),
              Text(
                '$amount ${AppStrings.rs}',
                style: AppTextStyles.semiBold28,
              ),
            ],
          ),
          const Spacer(),
          CircularPercentWidget(
            percentage: percentage,
            radius: MyResponsive.radius(value: 90),
            lineWidth: MyResponsive.fontSize(value: 20),
          ),
        ],
      ),
    );
  }
}
