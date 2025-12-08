import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class OnboardingListViewWidget extends StatelessWidget {
  const OnboardingListViewWidget({
    super.key,
    required this.title,
    required this.isSelected,
  });

  final bool isSelected;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: MyResponsive.height(value: 70),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        border: Border.all(
          color: isSelected ? AppColors.primary : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Radio(
          //   value: isSelected,
          //   groupValue: true,
          //   onChanged: (value) {},
          //   activeColor: AppColors.primary,
          //   fillColor: WidgetStateProperty.all(AppColors.primary),
          // ),
          Expanded(
            child: Padding(
              padding: MyResponsive.paddingOnly(right: 10),
              child: Text(
                title,
                style: AppTextStyles.light16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
