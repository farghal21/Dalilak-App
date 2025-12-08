import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import 'animated_app_loading.dart';

class CustomProgressHud extends StatelessWidget {
  const CustomProgressHud(
      {super.key, required this.isLoading, required this.child});

  final bool isLoading;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      dismissible: true,
      progressIndicator: AppLoading(),
      inAsyncCall: isLoading,
      child: child,
    );
  }
}
