import 'package:dalilak_app/features/settings/views/widgets/setting_dropdown_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/notification_settings_cubit/notification_settings_cubit.dart';

class NotificationSettingViewBody extends StatelessWidget {
  const NotificationSettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NotificationSettingsCubit.get(context);
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MyResponsive.height(value: 140),
          ),
          Text(
            AppStrings.notifications,
            style: AppTextStyles.semiBold24,
          ),
          SizedBox(
            height: MyResponsive.height(value: 50),
          ),
          SettingDropdownWidget(
            title: AppStrings.internalNotifications,
            selectedValue: cubit.selectedInternalNotification,
            items: cubit.notificationItems,
            onChanged: (String? newValue) {
              cubit.changeInternalNotification(newValue!);
            },
          ),
          SizedBox(
            height: MyResponsive.height(value: 35),
          ),
          SettingDropdownWidget(
            title: AppStrings.externalNotifications,
            selectedValue: cubit.selectedExternalNotification,
            items: cubit.notificationItems,
            onChanged: (String? newValue) {
              cubit.changeExternalNotification(newValue!);
            },
          ),
          SizedBox(
            height: MyResponsive.height(value: 35),
          ),
        ],
      ),
    );
  }
}
