import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:flutter/material.dart';

class UsedCarsAccessCard extends StatelessWidget {
  const UsedCarsAccessCard({
    super.key,
    required this.onTap,
  });

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // Gradient Border Effect
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          gradient: AppColors.horizontalGradient,
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 20)),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.25),
              blurRadius: 20,
              spreadRadius: 2,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Container(
          // Inner Container with Dark Background
          padding: EdgeInsets.symmetric(
            horizontal: MyResponsive.width(value: 16),
            vertical: MyResponsive.height(value: 16),
          ),
          decoration: BoxDecoration(
            color: AppColors.appFill,
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 18)),
          ),
          child: Row(
            children: [
              // Leading: Circular Icon Container
              Container(
                width: MyResponsive.width(value: 50),
                height: MyResponsive.height(value: 50),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.directions_car_filled_outlined,
                  color: AppColors.white,
                  size: MyResponsive.width(value: 28),
                ),
              ),
              SizedBox(width: MyResponsive.width(value: 16)),

              // Middle: Text Column
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Title
                    Text(
                      "سوق المستعمل 🚗",
                      style: AppTextStyles.bold16.copyWith(
                        color: AppColors.white,
                      ),
                    ),
                    SizedBox(height: MyResponsive.height(value: 4)),
                    // Subtitle
                    Text(
                      "وفر فلوسك واشتري عربية لقطة",
                      style: AppTextStyles.regular12.copyWith(
                        color: AppColors.gray,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: MyResponsive.width(value: 12)),

              // Trailing: Arrow Icon
              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.gray,
                size: MyResponsive.width(value: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
