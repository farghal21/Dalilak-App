import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class MainDrawerItem extends StatelessWidget {
  const MainDrawerItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String imagePath;
  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: MyResponsive.paddingSymmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          gradient: isSelected ? AppColors.horizontalGradient : null,
        ),
        child: Row(
          children: [
            SvgWrapper(
              path: imagePath,
              color: isSelected ? AppColors.white : AppColors.gray,
            ),
            SizedBox(width: MyResponsive.width(value: 22)),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.semiBold17
                    .copyWith(color: isSelected ? null : AppColors.gray),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
