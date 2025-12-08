import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

abstract class MySnackbar {
  static void error(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  static void success(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(color: AppColors.white)),
        backgroundColor: AppColors.green,
      ),
    );
  }
}
