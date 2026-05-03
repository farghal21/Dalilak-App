import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/chat_history/views/widgets/history_app_bar.dart';
import 'package:flutter/material.dart';

class PrivacyPolicySettingView extends StatelessWidget {
  const PrivacyPolicySettingView({super.key});

  static const String routeName = 'PrivacyPolicySettingView';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: Column(
        children: [
          SizedBox(height: MyResponsive.height(value: 60)), // Top padding

          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 20),
            child: HistoryAppBar(title: AppStrings.privacyPolicy),
          ),

          SizedBox(height: MyResponsive.height(value: 20)),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: MyResponsive.paddingSymmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildAnimatedSection(
                      0, AppStrings.introTitle, AppStrings.introBody),
                  _buildAnimatedSection(100, AppStrings.infoCollectionTitle,
                      AppStrings.infoCollectionBody),
                  _buildAnimatedSection(
                      200, AppStrings.usageInfoTitle, AppStrings.usageInfoBody),
                  _buildAnimatedSection(300, AppStrings.dataSharingTitle,
                      AppStrings.dataSharingBody),
                  _buildAnimatedSection(400, AppStrings.dataSecurityTitle,
                      AppStrings.dataSecurityBody),
                  _buildAnimatedSection(500, AppStrings.userRightsTitle,
                      AppStrings.userRightsBody),
                  _buildAnimatedSection(600, AppStrings.policyChangesTitle,
                      AppStrings.policyChangesBody),
                  _buildAnimatedSection(700, AppStrings.contactInfoTitle,
                      AppStrings.contactInfoBody),
                  SizedBox(height: MyResponsive.height(value: 40)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedSection(int delay, String title, String body) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 600 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppTextStyles.semiBold16.copyWith(
              color: AppColors.primary, // Highlight titles
            ),
          ),
          SizedBox(height: MyResponsive.height(value: 8)),
          Text(
            body,
            style: AppTextStyles.regular14.copyWith(
              height: 1.6, // Better readability
              color: AppColors.white.withOpacity(0.9),
            ),
          ),
          SizedBox(height: MyResponsive.height(value: 24)), // More spacing
        ],
      ),
    );
  }
}
