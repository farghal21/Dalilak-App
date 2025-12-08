import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'login_form_widget.dart';
import 'main_image_widget.dart';

class LoginViewBody extends StatelessWidget {
  const LoginViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MainImageWidget(),
          SizedBox(
            height: MyResponsive.height(value: 50),
          ),
          Text(
            AppStrings.welcomeBack,
            style: AppTextStyles.regular25,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MyResponsive.height(value: 10),
          ),
          Text(
            AppStrings.orMakeNewAccount,
            style: AppTextStyles.light16.copyWith(color: Colors.grey),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: MyResponsive.height(value: 45),
          ),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
