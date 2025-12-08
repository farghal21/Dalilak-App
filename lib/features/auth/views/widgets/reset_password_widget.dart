import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'main_image_widget.dart';

class ResetPasswordWidget extends StatelessWidget {
  const ResetPasswordWidget({
    super.key,
    required this.controller,
    required this.subtitle,
    required this.textFieldType,
    required this.onPressed,
    required this.formKey,
    this.confirmPasswordController,
    this.obscureTextPass = false,
    this.obscureTextConfirmPass = false,
    this.onSuffixTapPass,
    this.onSuffixTapConfirmPass,
  });

  final TextEditingController controller;
  final TextEditingController? confirmPasswordController;
  final String subtitle;
  final TextFieldType textFieldType;
  final VoidCallback onPressed;
  final GlobalKey<FormState> formKey;
  final bool? obscureTextPass;
  final bool? obscureTextConfirmPass;
  final VoidCallback? onSuffixTapPass;
  final VoidCallback? onSuffixTapConfirmPass;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MainImageWidget(),
          SizedBox(
            height: MyResponsive.height(value: 56),
          ),
          Text(
            AppStrings.resetPassword,
            style: AppTextStyles.regular25,
          ),
          SizedBox(
            height: MyResponsive.height(value: 10),
          ),
          Text(
            subtitle,
            style: AppTextStyles.light16.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MyResponsive.height(value: 30),
          ),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  CustomTextFormField(
                    type: textFieldType,
                    controller: controller,
                    obsecure: obscureTextPass!,
                    onSuffixTapped: onSuffixTapPass,
                  ),
                  SizedBox(
                    height: MyResponsive.height(value: 16),
                  ),
                  textFieldType == TextFieldType.password
                      ? CustomTextFormField(
                          type: TextFieldType.password,
                          controller: confirmPasswordController!,
                          passController: controller,
                          obsecure: obscureTextConfirmPass!,
                          onSuffixTapped: onSuffixTapConfirmPass,
                        )
                      : SizedBox(
                          height: MyResponsive.height(value: 0),
                        ),
                  SizedBox(
                    height: MyResponsive.height(value: 60),
                  ),
                  CustomButton(
                    title: AppStrings.next,
                    onPressed: onPressed,
                    backgroundColor: AppColors.secondary,
                  ),
                  SizedBox(
                    height: MyResponsive.height(value: 50),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
