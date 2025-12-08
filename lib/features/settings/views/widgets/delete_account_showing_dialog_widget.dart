import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class DeleteAccountShowingDialogWidget extends StatelessWidget {
  final VoidCallback onDelete;
  final VoidCallback onCancel;

  const DeleteAccountShowingDialogWidget({
    super.key,
    required this.onDelete,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF220F49),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
      ),
      child: Padding(
        padding:
        MyResponsive.paddingSymmetric(horizontal: 19.5, vertical: 19.5),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              AppStrings.warning,
              style: AppTextStyles.semiBold19,
            ),
            SizedBox(
              height: MyResponsive.height(value: 36),
            ),
            Text(
              AppStrings.warningSubtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.semiBold12.copyWith(
                color: AppColors.gray,
              ),
            ),
            SizedBox(height: MyResponsive.height(value: 36)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: CustomButton(
                    title: AppStrings.delete,
                    backgroundColor: AppColors.orange,
                    onPressed: onDelete,
                  ),
                ),
                SizedBox(width: MyResponsive.width(value: 26)),
                Expanded(
                  child: CustomButton(
                    title: AppStrings.cancel,
                    backgroundColor: AppColors.gray,
                    onPressed: onCancel,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
