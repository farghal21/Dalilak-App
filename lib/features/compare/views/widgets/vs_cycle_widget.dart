import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';

class VsCircleWidget extends StatelessWidget {
  const VsCircleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingAll(value: 12),
      child: Container(
        width: MyResponsive.width(value: 40),
        height: MyResponsive.height(value: 40),
        decoration: const BoxDecoration(
          color: AppColors.appFill,
          shape: BoxShape.circle,
        ),
        alignment: Alignment.center,
        child: Text(
          AppStrings.vs,
          style: AppTextStyles.bold20,
        ),
      ),
    );
  }
}
