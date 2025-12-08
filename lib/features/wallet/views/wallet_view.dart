import 'package:dalilak_app/features/wallet/views/widgets/wallet_view_body.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class WalletView extends StatelessWidget {
  const WalletView({super.key});

  static const String routeName = 'walletView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      drawerSelectedIndex: 1,
      body: WalletViewBody(),
    );
  }
}
