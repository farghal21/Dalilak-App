import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';

class CustomOtpField extends StatelessWidget {
  const CustomOtpField({super.key, required this.onChanged});

  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      appContext: context,
      length: 4,
      autoFocus: true,
      cursorColor: AppColors.primary,
      keyboardType: TextInputType.number,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        borderWidth: 1,
        fieldHeight: MyResponsive.height(value: 65),
        fieldWidth: MyResponsive.width(value: 65),
        activeColor: AppColors.primary,
        activeFillColor: AppColors.fillColor,
        inactiveColor: AppColors.white,
        inactiveFillColor: AppColors.fillColor,
        selectedColor: AppColors.primary,
        selectedFillColor: AppColors.fillColor,
      ),
      animationDuration: Duration(milliseconds: 300),
      enableActiveFill: true,
      onCompleted: (otpCode) {
        // print("Completed");
      },
      onChanged: onChanged,
    );
  }
}
