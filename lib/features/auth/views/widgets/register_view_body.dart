import 'package:dalilak_app/features/auth/views/widgets/register_form_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'main_image_widget.dart';

class RegisterViewBody extends StatelessWidget {
  const RegisterViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const MainImageWidget(),
          SizedBox(
            height: MyResponsive.height(value: 40),
          ),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: Text(
              AppStrings.registerTitle,
              style: AppTextStyles.regular25,
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MyResponsive.height(value: 3),
          ),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: Text(
              AppStrings.registerSubtitle,
              style: AppTextStyles.light16.copyWith(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: MyResponsive.height(value: 22),
          ),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: RegisterFormWidget(),
          ),
        ],
      ),
    );
  }
}
