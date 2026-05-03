import 'package:flutter/material.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_strings.dart';

class CostResultCard extends StatelessWidget {
  const CostResultCard({
    super.key,
    required this.totalCost,
    required this.litersNeeded,
    required this.fuelPrice,
  });

  final double totalCost;
  final double litersNeeded;
  final String fuelPrice;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingAll(value: 25),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 25)),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: AppColors.primary.withOpacity(0.5)),
      ),
      child: Column(
        children: [
          Text(
            AppStrings.expectedCost,
            style: AppTextStyles.regular14.copyWith(color: Colors.white70),
          ),
          SizedBox(height: MyResponsive.height(value: 15)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: totalCost),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: AppTextStyles.bold20.copyWith(
                      color: Colors.white,
                      fontSize: MyResponsive.fontSize(value: 48),
                      fontWeight: FontWeight.w800,
                    ),
                  );
                },
              ),
              SizedBox(width: MyResponsive.width(value: 8)),
              Text(
                AppStrings.currency,
                style: AppTextStyles.semiBold20
                    .copyWith(color: AppColors.lightGreen),
              ),
            ],
          ),
          Divider(
              color: Colors.white12, height: MyResponsive.height(value: 40)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildResultItem(AppStrings.litersNeeded,
                  "${litersNeeded.toStringAsFixed(1)} لتر"),
              _buildResultItem(AppStrings.fuelPriceApplied, "$fuelPrice ج.م"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildResultItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyles.regular11.copyWith(color: Colors.white60)),
        SizedBox(height: MyResponsive.height(value: 6)),
        Text(value,
            style: AppTextStyles.bold16.copyWith(color: AppColors.white)),
      ],
    );
  }
}
