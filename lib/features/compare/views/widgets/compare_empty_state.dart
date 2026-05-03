import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CompareEmptyState extends StatelessWidget {
  final String text;

  const CompareEmptyState({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: MyResponsive.paddingSymmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF2D1B4E), Color(0xFF1A0F2E)],
                ),
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.primary.withOpacity(0.3)),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 30,
                  )
                ],
              ),
              child: Icon(
                Icons.compare_arrows_rounded,
                size: MyResponsive.fontSize(value: 80),
                color: AppColors.primary,
              ),
            ),
            SizedBox(height: MyResponsive.height(value: 30)),
            Text(
              text,
              style: AppTextStyles.bold20.copyWith(color: Colors.white),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MyResponsive.height(value: 12)),
            Text(
              'اضغط على أيقونة المقارنة بجانب أي سيارة لإضافتها',
              style: AppTextStyles.regular14.copyWith(
                color: Colors.grey[400],
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
