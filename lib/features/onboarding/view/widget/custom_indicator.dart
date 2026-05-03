import 'package:flutter/material.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';

class CustomIndicator extends StatelessWidget {
  final bool isActive;

  const CustomIndicator({super.key, required this.isActive});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300), // وقت أنعم للحركة
      curve: Curves.easeIn,
      decoration: BoxDecoration(
        color: isActive
            ? const Color(0xff631284) // لون المؤشر النشط
            : AppColors.gray, // استخدمت ألوان عامة للتوضيح (عدلها لألوانك)
        borderRadius: BorderRadius.circular(100),
      ),
      width: isActive
          ? MyResponsive.width(value: 30) // العرض عند التنشيط
          : MyResponsive.width(value: 10), // العرض العادي
      height: MyResponsive.height(value: 10),
    );
  }
}
