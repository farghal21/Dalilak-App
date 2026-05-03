import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:flutter/material.dart';

import '../helper/my_responsive.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class NotificationDrawer extends StatelessWidget {
  const NotificationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: AppColors.black,
        child: Padding(
            padding: MyResponsive.paddingAll(value: 20),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.natMessage,
                    style: AppTextStyles.bold20,
                  )
                ])));
  }
}
