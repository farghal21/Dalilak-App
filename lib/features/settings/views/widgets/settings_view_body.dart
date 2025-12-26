import 'package:dalilak_app/features/settings/views/widgets/setting_item_row.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../delete_account_setting_view.dart';
import '../privacy_policy_setting_view.dart';
import '../profile_setting_view.dart';
import '../public_settings_view.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MyResponsive.height(value: 140),
          ),
          Text(
            AppStrings.settings,
            style: AppTextStyles.semiBold24,
          ),
          SizedBox(
            height: MyResponsive.height(value: 88),
          ),
          SettingItemRow(
            title: AppStrings.publicSettings,
            routeName: PublicSettingsView.routeName,
          ),
          SizedBox(
            height: MyResponsive.height(value: 50),
          ),
          SettingItemRow(
            title: AppStrings.profile,
            routeName: ProfileSettingView.routeName,
          ),
          SizedBox(
            height: MyResponsive.height(value: 50),
          ),
          // SettingItemRow(
          //   title: AppStrings.notifications,
          //   routeName: NotificationSettingView.routeName,
          // ),
          // SizedBox(
          //   height: MyResponsive.height(value: 50),
          // ),
          SettingItemRow(
            title: AppStrings.privacyPolicy,
            routeName: PrivacyPolicySettingView.routeName,
          ),
          SizedBox(
            height: MyResponsive.height(value: 50),
          ),
          SettingItemRow(
            title: AppStrings.deleteAccount,
            routeName: DeleteAccountSettingView.routeName,
            isRed: true,
          ),
        ],
      ),
    );
  }
}
