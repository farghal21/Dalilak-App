import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/register_cubit/register_cubit.dart';
import 'do_not_have_account.dart';

class RegisterFormWidget extends StatelessWidget {
  const RegisterFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    RegisterCubit cubit = RegisterCubit.get(context);
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            type: TextFieldType.name,
            controller: cubit.fullName,
          ),
          SizedBox(
            height: MyResponsive.height(value: 14),
          ),
          CustomTextFormField(
            type: TextFieldType.email,
            controller: cubit.emailController,
          ),
          SizedBox(
            height: MyResponsive.height(value: 14),
          ),
          // CustomTextFormField(
          //   type: TextFieldType.phone,
          //   controller: cubit.phoneController,
          // ),
          // SizedBox(
          //   height: MyResponsive.height(value: 14),
          // ),
          CustomTextFormField(
            type: TextFieldType.password,
            controller: cubit.passwordController,
            obsecure: cubit.obsecure,
            onSuffixTapped: cubit.changeObsecurePassword,
          ),
          SizedBox(
            height: MyResponsive.height(value: 14),
          ),
          CustomTextFormField(
            type: TextFieldType.password,
            controller: cubit.confirmPasswordController,
            passController: cubit.passwordController,
            obsecure: cubit.confirmObsecure,
            onSuffixTapped: cubit.changeConfirmObsecurePassword,
          ),
          SizedBox(
            height: MyResponsive.height(value: 14),
          ),
          CustomButton(
            title: AppStrings.register,
            onPressed: cubit.register,
          ),
          SizedBox(
            height: MyResponsive.height(value: 20),
          ),
          DoNotHaveAccount(
            question: AppStrings.alreadyHaveAccount,
            actionText: AppStrings.login,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          SizedBox(
            height: MyResponsive.height(value: 30),
          ),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 25),
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: AppStrings.acceptTermsRegister,
                    style:
                        AppTextStyles.light13.copyWith(color: AppColors.gray),
                  ),
                  TextSpan(
                    text: AppStrings.privacyPolicy,
                    style: AppTextStyles.light13,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                  TextSpan(
                    text: AppStrings.and,
                    style:
                        AppTextStyles.light13.copyWith(color: AppColors.gray),
                  ),
                  TextSpan(
                    text: AppStrings.termsOfUse,
                    style: AppTextStyles.light13,
                    recognizer: TapGestureRecognizer()..onTap = () {},
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MyResponsive.height(value: 40),
          ),
        ],
      ),
    );
  }
}
