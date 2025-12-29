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
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F0820),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: isChecked ? const Color(0xFF4A2E6E) : const Color(0xFF2D1B4E),
          width: 1,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // الأيقونة
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isChecked
                  ? AppColors.primary.withOpacity(0.2)
                  : Colors.grey[850],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isChecked ? Icons.check_circle : Icons.circle_outlined,
              color: isChecked ? AppColors.primary : Colors.grey[600],
              size: 24,
            ),
          ),
          const SizedBox(width: 16),

          // العنوان والنصيحة
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: Colors.white, // White for titles
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  hint,
                  style: AppTextStyles.regular14.copyWith(
                    color: Colors.grey[400], // Light grey for hints
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
