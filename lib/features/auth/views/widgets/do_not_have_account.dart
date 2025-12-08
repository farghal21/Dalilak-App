import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class DoNotHaveAccount extends StatelessWidget {
  final String question;
  final String actionText;
  final VoidCallback onPressed;

  const DoNotHaveAccount({
    super.key,
    required this.question,
    required this.actionText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: AppStrings.orYouCan,
            style: AppTextStyles.light16.copyWith(color: AppColors.gray),
          ),
          TextSpan(
            text: "$actionText ",
            style: AppTextStyles.light16.copyWith(
              color: actionText == AppStrings.register
                  ? AppColors.primary
                  : AppColors.secondary,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = onPressed,
          ),
          TextSpan(
            text: question,
            style: AppTextStyles.light16.copyWith(color: AppColors.gray),
          ),
        ],
      ),
      textAlign: TextAlign.center,
    );
  }
}
