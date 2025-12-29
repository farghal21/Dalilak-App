import 'package:flutter/material.dart';
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
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: const Color(0xFF1A0F2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFF2D1B4E),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Title
          Text(
            AppStrings.inspectionResult,
            style: AppTextStyles.regular11.copyWith(color: Colors.white70),
          ),

          const SizedBox(height: 8),

          // النسبة المئوية - Compact
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
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                    ),
                  );
                },
              ),
              const SizedBox(width: 4),
              Text(
                '%',
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.lightGreen,
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // شريط التقدم - Compact
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: percentage / 100,
              minHeight: 6,
              backgroundColor: AppColors.gray.withOpacity(0.2),
              valueColor: AlwaysStoppedAnimation<Color>(
                _getColorByPercentage(percentage),
              ),
            ),
          ),

          const SizedBox(height: 10),

          const Divider(
            color: Color(0xFF2D1B4E),
            height: 1,
          ),

          const SizedBox(height: 8),

          // التفاصيل - Compact
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
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: AppTextStyles.regular11.copyWith(color: Colors.white60),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: AppTextStyles.semiBold14.copyWith(color: AppColors.white),
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
