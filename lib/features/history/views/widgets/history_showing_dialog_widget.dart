import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class HistoryShowingDialogWidget extends StatelessWidget {
  const HistoryShowingDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: MyResponsive.paddingSymmetric(horizontal: 20),
      backgroundColor: const Color(0xFF220F49),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
      ),
      child: Padding(
        padding: MyResponsive.paddingSymmetric(horizontal: 29, vertical: 64),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.info_outline,
              size: MyResponsive.fontSize(value: 100),
            ),
            SizedBox(
              height: MyResponsive.height(value: 41),
            ),
            Text(
              AppStrings.faz3aDialogHint,
              style: AppTextStyles.semiBold24,
            ),
            SizedBox(
              height: MyResponsive.height(value: 19),
            ),
            Text(
              AppStrings.faz3aDialogSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold17.copyWith(
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: MyResponsive.height(value: 41)),
            Padding(
              padding: MyResponsive.paddingSymmetric(horizontal: 53 - 29),
              child: CustomButton(
                title: AppStrings.ok,
                backgroundColor: AppColors.secondary,
                height: MyResponsive.height(value: 56),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
