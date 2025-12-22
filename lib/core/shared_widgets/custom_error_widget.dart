import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  const CustomErrorWidget({super.key, required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: AppTextStyles.bold16,
        textAlign: TextAlign.center,
      ),
    );
  }
}
