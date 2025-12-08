import 'package:dalilak_app/features/auth/views/widgets/done_widget.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import 'login_view.dart';

class ResetPasswordDoneView extends StatelessWidget {
  const ResetPasswordDoneView({super.key});

  static const String routeName = "/reset-password-done";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: DoneWidget(
        title: AppStrings.changePasswordDone,
        imagePath: AppAssets.doneSecondary,
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, LoginView.routeName, (route) => false);
        },
      ),
    );
  }
}
