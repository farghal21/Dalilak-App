import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/svg_wrapper.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const CustomPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    // ❌ تم حذف Scaffold لأنه لا يصح وضعه داخل PageView
    return Column(
      mainAxisAlignment: MainAxisAlignment.center, // توسيط المحتوى
      children: [
        Image.asset(
          imagePath,
          // width: MyResponsive.width(value: 400),
          // height: MyResponsive.height(value: 400),
          fit: BoxFit.cover,
        ),
        SizedBox(
          height: MyResponsive.height(value: 34),
        ),
        Text(
          title,
          style: AppTextStyles.bold20,
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: MyResponsive.height(value: 10),
        ),
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 20),
          child: Text(
            description,
            textAlign: TextAlign.center,
            style: AppTextStyles.regular11
                .copyWith(height: 1.5), // تحسين المسافات بين السطور
          ),
        ),
      ],
    );
  }
}
