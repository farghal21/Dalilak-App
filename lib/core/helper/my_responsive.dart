import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

abstract class MyResponsive {
  /// Responsive width
  static double width({required double value}) => value.w;

  /// Responsive height
  static double height({required double value}) => value.h;

  /// Responsive font size
  static double fontSize({required double value}) => value.sp;

  /// Responsive radius (BorderRadius / Border / any square dimension)
  static double radius({required double value}) => value.r;

  /// Responsive symmetric padding (horizontal & vertical)
  static EdgeInsets paddingSymmetric({
    double? horizontal,
    double? vertical,
  }) {
    return EdgeInsets.symmetric(
      horizontal: (horizontal ?? 0).w,
      vertical: (vertical ?? 0).h,
    );
  }

  /// Responsive padding for each side (left, right, top, bottom)
  static EdgeInsets paddingOnly({
    double? left,
    double? right,
    double? top,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: (left ?? 0).w,
      right: (right ?? 0).w,
      top: (top ?? 0).h,
      bottom: (bottom ?? 0).h,
    );
  }

  /// Responsive padding applied equally on all sides
  static EdgeInsets paddingAll({required double value}) {
    return EdgeInsets.all(value.w);
  }
}

// abstract class MyResponsive {
//   static double height(BuildContext context, {required double value}) =>
//       value.h; // ScreenUtil auto handles height
//
//   static double width(BuildContext context, {required double value}) =>
//       value.w; // ScreenUtil auto handles width
//
//   static double fontSize(BuildContext context, {required double value}) =>
//       value.sp; // sp for scalable fonts
//
//   static EdgeInsets paddingSymmetric(
//       BuildContext context, {
//         double? horizontal,
//         double? vertical,
//       }) {
//     return EdgeInsets.symmetric(
//       horizontal: (horizontal ?? 0).w,
//       vertical: (vertical ?? 0).h,
//     );
//   }
//
//   static EdgeInsets paddingOnly(
//       BuildContext context, {
//         double? left,
//         double? right,
//         double? top,
//         double? bottom,
//       }) {
//     return EdgeInsets.only(
//       left: (left ?? 0).w,
//       right: (right ?? 0).w,
//       top: (top ?? 0).h,
//       bottom: (bottom ?? 0).h,
//     );
//   }
//
// }
