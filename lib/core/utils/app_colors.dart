import 'package:flutter/material.dart';

abstract class AppColors {
  // Primary Color: (يفضل تهدئته قليلاً أيضاً لو أمكن، لكن سأتركه كما هو للوجو)
  static Color primary = const Color(0xFFFF00C8);
  static const Color onPrimary = Color(0xFFF901C9);

  static Color secondary = const Color(0xff0051FF);

  // الألوان الأساسية
  static const Color gray = Color(0xff8A8A8A);
  static const Color fillColor = Color(0x0FFFFFFF); // شفاف جداً للخلفيات
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF0000);
  static const Color orange = Color(0xffEE5353);
  static const Color green = Color(0xFF1A671A);
  static const Color lightGreen = Color(0xFF09FDDC);
  static Color black = const Color(0xFF100F1F); // الخلفية الأساسية (Dark Navy)
  static const Color appFill = Color(0xFF220F49);

  // ✅ التعديل هنا: Gradient هادي وفخم (Premium Matte)
  // ✅ التعديل الجديد: ألوان غنية وواضحة (Rich & Vibrant)
  static const Gradient horizontalGradient = LinearGradient(
    colors: [
      Color(0xFFD039B6), // فوشيا غامق (واضح بس مش فسفوري)
      Color.fromARGB(255, 56, 21, 81), // بنفسجي قوي (بيدي عمق للزرار)
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradient الكروت (تم تحسينه ليكون أقل حدة)
  static const Gradient cardGradient = LinearGradient(
    colors: [
      Color(0xFF1E1630), // أغمق قليلاً لراحة العين
      Color(0xFF3D1F58), // بنفسجي غامق
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
