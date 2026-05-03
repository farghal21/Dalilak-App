import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/user/manager/user_cubit/user_cubit.dart';
import '../../../../core/user/manager/user_cubit/user_state.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../chat_history/views/widgets/history_app_bar.dart';
import '../delete_account_setting_view.dart';
import '../privacy_policy_setting_view.dart';
import '../profile_setting_view.dart';
import '../public_settings_view.dart';

class SettingsViewBody extends StatelessWidget {
  const SettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Spacing
          SizedBox(height: MyResponsive.height(value: 120)),

          // AppBar
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 20),
            child: HistoryAppBar(title: AppStrings.settings),
          ),

          SizedBox(height: MyResponsive.height(value: 40)),

          // Scrollable Settings List
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: MyResponsive.paddingSymmetric(horizontal: 20),
              child: Column(
                children: [
                  // Public Settings
                  _buildSettingItem(
                    context: context,
                    icon: Icons.settings,
                    title: AppStrings.publicSettings,
                    onTap: () => Navigator.pushNamed(
                      context,
                      PublicSettingsView.routeName,
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 16)),

                  // Profile
                  _buildSettingItem(
                    context: context,
                    icon: Icons.person,
                    title: AppStrings.profile,
                    onTap: () => Navigator.pushNamed(
                      context,
                      ProfileSettingView.routeName,
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 16)),

                  // Privacy Policy
                  _buildSettingItem(
                    context: context,
                    icon: Icons.lock,
                    title: AppStrings.privacyPolicy,
                    onTap: () => Navigator.pushNamed(
                      context,
                      PrivacyPolicySettingView.routeName,
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 16)),

                  // Delete Account
                  _buildSettingItem(
                    context: context,
                    icon: Icons.delete_forever,
                    title: AppStrings.deleteAccount,
                    onTap: () => Navigator.pushNamed(
                      context,
                      DeleteAccountSettingView.routeName,
                    ),
                    isDestructive: true,
                  ),
                  SizedBox(height: MyResponsive.height(value: 32)),

                  // Logout Button
                  _buildLogoutButton(context),

                  SizedBox(height: MyResponsive.height(value: 40)),

                  // Version Info
                  Center(
                    child: Text(
                      'Version 1.0.0',
                      style: AppTextStyles.regular14.copyWith(
                        color: Colors.white24,
                      ),
                    ),
                  ),

                  SizedBox(height: MyResponsive.height(value: 20)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Premium Dark Mode Setting Item
  Widget _buildSettingItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MyResponsive.width(value: 20),
          vertical: MyResponsive.height(value: 18),
        ),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            // Leading Icon
            Icon(
              icon,
              color: isDestructive ? AppColors.red : AppColors.white,
              size: MyResponsive.width(value: 24),
            ),
            SizedBox(width: MyResponsive.width(value: 16)),

            // Title
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.semiBold16.copyWith(
                  color: isDestructive ? AppColors.red : AppColors.white,
                ),
              ),
            ),

            // Trailing Arrow
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.gray,
              size: MyResponsive.width(value: 16),
            ),
          ],
        ),
      ),
    );
  }

  /// Logout Button
  Widget _buildLogoutButton(BuildContext context) {
    final userCubit = UserCubit.get(context);

    return GestureDetector(
      onTap: () => userCubit.logout(),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: MyResponsive.width(value: 20),
          vertical: MyResponsive.height(value: 18),
        ),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: AppColors.red.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            // Logout Icon
            Icon(
              Icons.logout,
              color: AppColors.red,
              size: MyResponsive.width(value: 24),
            ),
            SizedBox(width: MyResponsive.width(value: 16)),

            // Logout Text
            Expanded(
              child: Text(
                AppStrings.logout,
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.red,
                ),
              ),
            ),

            // Trailing Arrow
            Icon(
              Icons.arrow_forward_ios,
              color: AppColors.red.withOpacity(0.5),
              size: MyResponsive.width(value: 16),
            ),
          ],
        ),
      ),
    );
  }
}
