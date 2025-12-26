import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/custom_scaffold.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class PrivacyPolicySettingView extends StatelessWidget {
  const PrivacyPolicySettingView({super.key});

  static const String routeName = 'PrivacyPolicySettingView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      showDrawer: false,
      drawerSelectedIndex: 4,
      body: Padding(
        // استخدام المقاسات المستجيبة للـ Padding
        padding: MyResponsive.paddingSymmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // مسافة علوية مستجيبة
            SizedBox(
              height: MyResponsive.height(value: 140),
            ),
            Text(
              AppStrings.privacyPolicy,
              style: AppTextStyles.semiBold24,
            ),
            SizedBox(
              height: MyResponsive.height(value: 20),
            ),
            Expanded(
              child: SingleChildScrollView(
                // physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // مقدمة
                    Text(
                      AppStrings.introTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.introBody,
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: MyResponsive.height(value: 16)),

                    // المعلومات التي نقوم بجمعها
                    Text(
                      AppStrings.infoCollectionTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.infoCollectionBody,
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: MyResponsive.height(value: 16)),

                    // كيفية استخدام المعلومات
                    Text(
                      AppStrings.usageInfoTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.usageInfoBody,
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: MyResponsive.height(value: 16)),

                    // مشاركة البيانات
                    Text(
                      AppStrings.dataSharingTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.dataSharingBody,
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: MyResponsive.height(value: 16)),

                    // أمان البيانات
                    Text(
                      AppStrings.dataSecurityTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.dataSecurityBody,
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: MyResponsive.height(value: 16)),

                    // حقوق المستخدم
                    Text(
                      AppStrings.userRightsTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.userRightsBody,
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: MyResponsive.height(value: 16)),

                    // التغييرات على سياسة الخصوصية
                    Text(
                      AppStrings.policyChangesTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.policyChangesBody,
                      style: AppTextStyles.regular14,
                    ),
                    SizedBox(height: MyResponsive.height(value: 16)),

                    // معلومات التواصل
                    Text(
                      AppStrings.contactInfoTitle,
                      style: AppTextStyles.semiBold16,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Text(
                      AppStrings.contactInfoBody,
                      style: AppTextStyles.regular14,
                    ),
                    // مسافة أخيرة تحت خالص مستجيبة
                    SizedBox(height: MyResponsive.height(value: 30)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
