import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class InspectionItemTile extends StatelessWidget {
  const InspectionItemTile({
    super.key,
    required this.title,
    required this.hint,
    required this.isChecked,
    required this.onChanged,
  });

  final String title;
  final String hint;
  final bool isChecked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: MyResponsive.paddingSymmetric(vertical: 8),
      padding: MyResponsive.paddingAll(value: 16),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 15)),
        border: Border.all(
          color: isChecked
              ? AppColors.primary.withOpacity(0.5)
              : AppColors.gray.withOpacity(0.2),
          width: isChecked ? 2 : 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الأيقونة
          Container(
            width: MyResponsive.width(value: 40),
            height: MyResponsive.height(value: 40),
            decoration: BoxDecoration(
              gradient: isChecked ? AppColors.horizontalGradient : null,
              color: isChecked ? null : AppColors.black.withOpacity(0.3),
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 10)),
            ),
            child: Icon(
              isChecked ? Icons.check_circle : Icons.circle_outlined,
              color: isChecked ? AppColors.white : AppColors.gray,
              size: MyResponsive.fontSize(value: 24),
            ),
          ),
          SizedBox(width: MyResponsive.width(value: 16)),

          // العنوان والنصيحة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: isChecked ? AppColors.white : AppColors.gray,
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 6)),
                Text(
                  hint,
                  style: AppTextStyles.regular14.copyWith(
                    color: Colors.white60,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: MyResponsive.width(value: 12)),

          // Switch with haptic feedback
          Transform.scale(
            scale: 0.85,
            child: Switch(
              value: isChecked,
              onChanged: (value) {
                HapticFeedback.lightImpact();
                onChanged(value);
              },
              activeColor: AppColors.primary,
              activeTrackColor: AppColors.primary.withOpacity(0.3),
              inactiveThumbColor: AppColors.gray,
              inactiveTrackColor: AppColors.gray.withOpacity(0.2),
            ),
          ),
        ],
      ),
    );
  }
}
