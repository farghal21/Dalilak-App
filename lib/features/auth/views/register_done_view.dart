import 'package:dalilak_app/features/auth/views/widgets/done_widget.dart';
import 'package:dalilak_app/features/home/views/home_view.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';

class RegisterDoneView extends StatelessWidget {
  const RegisterDoneView({super.key});

  static const String routeName = "/register-done";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
        body: DoneWidget(
      title: AppStrings.checkDone,
      imagePath: AppAssets.donePrimary,
      isResetPass: false,
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(
            context, HomeView.routeName, (route) => false);
      },
    ));
  }
}
