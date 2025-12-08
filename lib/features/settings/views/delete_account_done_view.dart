import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import '../../auth/views/login_view.dart';
import '../../auth/views/widgets/done_widget.dart';

class DeleteAccountDoneView extends StatelessWidget {
  const DeleteAccountDoneView({super.key});

  static const String routeName = 'DeleteAccountDoneView';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CustomScaffold(
        body: DoneWidget(
          title: AppStrings.deleteAccountDone,
          imagePath: AppAssets.donePrimary,
          isResetPass: false,
          isHaveImage: false,
          onPressed: () {
            Navigator.pushNamedAndRemoveUntil(
                context, LoginView.routeName, (route) => false);
          },
        ),
      ),
    );
  }
}
