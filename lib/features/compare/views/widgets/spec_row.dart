import 'package:flutter/material.dart';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';

/// Widget لصف واحد من المواصفات
class SpecRow extends StatelessWidget {
  final String title;
  final String leftValue;
  final String rightValue;

  const SpecRow({
    super.key,
    required this.title,
    required this.leftValue,
    required this.rightValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Text(
                title,
                style: AppTextStyles.bold16,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: MyResponsive.height(value: 8)),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      leftValue,
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      rightValue,
                      textAlign: TextAlign.end,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        Divider(height: MyResponsive.height(value: 1), thickness: 0),
      ],
    );
  }
}