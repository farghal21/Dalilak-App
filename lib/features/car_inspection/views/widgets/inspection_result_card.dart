import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_strings.dart';

class InspectionResultCard extends StatelessWidget {
  const InspectionResultCard({
    super.key,
    required this.percentage,
    required this.checkedCount,
    required this.totalCount,
  });

  final double percentage;
  final int checkedCount;
  final int totalCount;

  @override
  Widget build(BuildContext context) {
    final bool isExcellent = percentage >= 80;

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
          // Success celebration animation for excellent scores
          if (isExcellent)
            TweenAnimationBuilder<double>(
              tween: Tween(begin: 0.0, end: 1.0),
              duration: const Duration(milliseconds: 600),
              curve: Curves.elasticOut,
              builder: (context, value, child) {
                return Transform.scale(
                  scale: value,
                  child: child,
                );
              },
              child: Lottie.network(
                'https://lottie.host/embed/d7f3e3e0-5e0a-4e3a-8e3a-5e0a4e3a8e3d/success-stars.json',
                width: MyResponsive.width(value: 80),
                height: MyResponsive.height(value: 80),
                fit: BoxFit.contain,
                repeat: false,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(
                    Icons.stars,
                    size: MyResponsive.fontSize(value: 60),
                    color: AppColors.lightGreen,
                  );
                },
              ),
            ),
          if (isExcellent) SizedBox(height: MyResponsive.height(value: 10)),

          Text(
            AppStrings.inspectionResult,
            style: AppTextStyles.regular14.copyWith(color: Colors.white70),
          ),
          SizedBox(height: MyResponsive.height(value: 15)),

          // النسبة المئوية مع Animated Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: percentage),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeOutCubic,
                builder: (context, value, child) {
                  return Text(
                    value.toStringAsFixed(0),
                    style: AppTextStyles.bold20.copyWith(
                      color: _getColorByPercentage(value),
                      fontSize: MyResponsive.fontSize(value: 48),
                      fontWeight: FontWeight.w800,
                    ),
                  );
                },
              ),
              SizedBox(width: MyResponsive.width(value: 8)),
              Text(
                '%',
                style: AppTextStyles.semiBold20.copyWith(
                  color: AppColors.lightGreen,
                ),
              ),
            ],
          ),

          SizedBox(height: MyResponsive.height(value: 10)),

          // شريط التقدم
          ClipRRect(
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: MyResponsive.height(value: 8),
              backgroundColor: AppColors.gray.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColorByPercentage(percentage),
              ),
            ),
          ),

          Divider(
            color: Colors.white12,
            height: MyResponsive.height(value: 40),
          ),

          // التفاصيل
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildResultItem(
                AppStrings.itemsInspected,
                '$checkedCount من $totalCount',
              ),
              _buildResultItem(
                AppStrings.generalCondition,
                _getStatusText(percentage),
              ),
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
        Text(
          title,
          style: AppTextStyles.regular11.copyWith(color: Colors.white60),
        ),
        SizedBox(height: MyResponsive.height(value: 6)),
        Text(
          value,
          style: AppTextStyles.bold16.copyWith(color: AppColors.white),
        ),
      ],
    );
  }

  Color _getColorByPercentage(double percentage) {
    if (percentage >= 80) {
      return AppColors.lightGreen;
    } else if (percentage >= 50) {
      return AppColors.orange;
    } else {
      return AppColors.red;
    }
  }

  String _getStatusText(double percentage) {
    if (percentage >= 80) {
      return AppStrings.statusExcellent;
    } else if (percentage >= 50) {
      return AppStrings.statusGood;
    } else if (percentage > 0) {
      return AppStrings.statusAverage;
    } else {
      return AppStrings.statusNotInspected;
    }
  }
}
