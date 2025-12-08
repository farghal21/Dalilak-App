import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SettingItemRow extends StatelessWidget {
  const SettingItemRow({
    super.key,
    required this.title,
    required this.routeName,
    this.isRed = false,
  });

  final String title;
  final String routeName;
  final bool isRed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Padding(
        padding: MyResponsive.paddingSymmetric(vertical: 10),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.semiBold17.copyWith(
                  color: isRed ? AppColors.red : null,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
