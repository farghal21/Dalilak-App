import 'package:flutter/material.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class FuelTypeSelector extends StatelessWidget {
  const FuelTypeSelector({
    super.key,
    required this.type,
    required this.price,
    required this.isSelected,
    required this.onTap,
  });

  final int type;
  final String price;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: MyResponsive.paddingSymmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? AppColors.horizontalGradient : null,
            color: isSelected ? null : AppColors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 12)),
            border: isSelected
                ? null
                : Border.all(color: AppColors.gray.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(
              "بنزين $type",
              style: AppTextStyles.semiBold16.copyWith(
                color: isSelected ? AppColors.white : AppColors.gray,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
