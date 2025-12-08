import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/login_cubit/login_cubit.dart';
import '../register_view.dart';
import '../reset_password_verify_email_view.dart';
import 'do_not_have_account.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    LoginCubit cubit = LoginCubit.get(context);
    return Form(
      key: cubit.formKey,
      child: Column(
        children: [
          CustomTextFormField(
            type: TextFieldType.email,
            controller: cubit.emailController,
          ),
          SizedBox(
            height: MyResponsive.height(value: 14),
          ),
          CustomTextFormField(
            type: TextFieldType.password,
            controller: cubit.passwordController,
            obsecure: cubit.obsecure,
            onSuffixTapped: cubit.changeObsecure,
          ),
          SizedBox(
            height: MyResponsive.height(value: 16),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                  context, ResetPasswordVerifyEmailView.routeName);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.forgotPassword,
                  style: AppTextStyles.medium16,
                ),
              ],
            ),
          ),
          SizedBox(
            height: MyResponsive.height(value: 45),
          ),
          CustomButton(
            title: AppStrings.login,
            onPressed: cubit.login,
            backgroundColor: AppColors.secondary,
          ),
          SizedBox(
            height: MyResponsive.height(value: 20),
          ),
          DoNotHaveAccount(
            question: AppStrings.doNotHaveAccount,
            actionText: AppStrings.register,
            onPressed: () {
              Navigator.pushNamed(context, RegisterView.routeName);
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
                    text: AppStrings.acceptTermsLogin,
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
