import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'custom_otp_field.dart';
import 'main_image_widget.dart';

class OtpWidget extends StatelessWidget {
  const OtpWidget({
    super.key,
    required this.onOtpChanged,
    required this.onResendOtp,
    required this.onVerifyOtp,
    required this.isOtpComplete,
    this.isHaveImage = true,
  });

  final Function(String) onOtpChanged;
  final VoidCallback onResendOtp;
  final VoidCallback onVerifyOtp;
  final bool isOtpComplete;
  final bool? isHaveImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          isHaveImage!
              ? MainImageWidget()
              : SizedBox(
                  height: MyResponsive.height(value: 200),
                ),
          SizedBox(height: MyResponsive.height(value: 46)),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppStrings.otpTitle,
                  style: AppTextStyles.regular16,
                ),
                SizedBox(height: MyResponsive.height(value: 27)),
                CustomOtpField(
                  onChanged: onOtpChanged,
                ),
                SizedBox(height: MyResponsive.height(value: 27)),
                Text(
                  AppStrings.doNotReceiveCode,
                  style: AppTextStyles.regular16,
                ),
                SizedBox(height: MyResponsive.height(value: 16)),
                TextButton(
                  onPressed: onResendOtp,
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size.zero,
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    AppStrings.resendCode,
                    style: AppTextStyles.medium16
                        .copyWith(color: AppColors.secondary),
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 70)),
                CustomButton(
                  title: AppStrings.verify,
                  onPressed: isOtpComplete ? onVerifyOtp : null,
                  backgroundColor: isOtpComplete
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: .2),
                ),
                SizedBox(
                  height: MyResponsive.height(value: 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
