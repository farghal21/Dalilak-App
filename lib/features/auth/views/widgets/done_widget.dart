import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'main_image_widget.dart';

class DoneWidget extends StatelessWidget {
  const DoneWidget({
    super.key,
    required this.title,
    required this.imagePath,
    this.isResetPass = true,
    required this.onPressed,
    this.isHaveImage = true,
  });

  final String title;
  final String imagePath;
  final bool? isResetPass;
  final VoidCallback onPressed;
  final bool? isHaveImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          isHaveImage!
              ? MainImageWidget()
              : SizedBox(
                  height: MyResponsive.height(value: 250),
                ),
          SizedBox(
            height: MyResponsive.height(value: 46),
          ),
          Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: Column(
              children: [
                Text(
                  title,
                  style: AppTextStyles.regular16,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MyResponsive.height(value: 34),
                ),
                // Lottie success animation with fallback
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 800),
                  curve: Curves.elasticOut,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: Lottie.network(
                    'https://lottie.host/embed/b7f3e3e0-5e0a-4e3a-8e3a-5e0a4e3a8e3b/success-checkmark.json',
                    width: MyResponsive.width(value: 228),
                    height: MyResponsive.height(value: 228),
                    fit: BoxFit.contain,
                    repeat: false,
                    errorBuilder: (context, error, stackTrace) {
                      // Fallback to original image
                      return Image.asset(
                        imagePath,
                        height: MyResponsive.height(value: 228),
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: MyResponsive.height(value: 250),
                ),
                CustomButton(
                  title: AppStrings.next,
                  backgroundColor:
                      isResetPass! ? AppColors.secondary : AppColors.primary,
                  onPressed: onPressed,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
