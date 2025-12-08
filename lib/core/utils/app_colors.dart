import 'package:flutter/material.dart';

abstract class AppColors {
  static Color primary = Color(0xFFFF00C8);
  static const Color onPrimary = Color(0xFFF901C9);

  static Color secondary = Color(0xff0051FF);
  static const Color gray = Color(0xff8A8A8A);
  static const Color fillColor = Color(0x0FFFFFFF);
  static const Color white = Color(0xFFFFFFFF);
  static const Color red = Color(0xFFFF0000);
  static const Color orange = Color(0xffEE5353);
  static const Color green = Color(0xFF1A671A);
  static const Color lightGreen = Color(0xFF09FDDC);
  static Color black = Color(0xFF100F1F);
  static const Color appFill = Color(0xFF220F49);

  static Gradient horizontalGradient = LinearGradient(
    colors: [
      primary,
      secondary,
    ],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const Gradient cardGradient = LinearGradient(
    colors: [
      Color(0xFF1B0034),
      Color(0xFF4B006E),
    ],
    begin: Alignment.topRight,
    end: Alignment.bottomLeft,
  );
}
