import 'package:dalilak_app/features/wallet/views/wallet_view.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_strings.dart';
import '../../auth/views/widgets/done_widget.dart';

class WalletChargeDone extends StatelessWidget {
  const WalletChargeDone({super.key});

  static const String routeName = 'walletChargeDone';

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: CustomScaffold(
        isHomeScreen: true,
        showDrawer: false,
        body: DoneWidget(
          title: AppStrings.chargeSuscessful,
          imagePath: AppAssets.donePrimary,
          isHaveImage: false,
          isResetPass: false,
          onPressed: () {
            Navigator.popUntil(
                context, ModalRoute.withName(WalletView.routeName));
          },
        ),
      ),
    );
  }
}
