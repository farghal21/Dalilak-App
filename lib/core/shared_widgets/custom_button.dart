import 'package:flutter/material.dart';

import '../helper/my_responsive.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.title,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
  });

  final String title;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.primary,
        foregroundColor: foregroundColor,
        minimumSize: Size(
          width ?? double.infinity,
          height ?? MyResponsive.height(value: 36),
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        ),
      ),
      child: Text(
        title,
        style: AppTextStyles.regular18.copyWith(
          color: foregroundColor ?? AppColors.white,
        ),
      ),
    );
  }
}
