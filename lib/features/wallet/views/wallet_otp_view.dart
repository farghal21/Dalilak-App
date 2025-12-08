import 'package:dalilak_app/features/wallet/views/wallet_charge_done_view.dart';
import 'package:dalilak_app/features/wallet/views/wallet_view.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../auth/views/widgets/otp_widget.dart';

class WalletOtpView extends StatelessWidget {
  const WalletOtpView({super.key});

  static const String routeName = 'walletOtpView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      showDrawer: false,
      body: OtpWidget(
        onOtpChanged: (onChanged) {},
        onResendOtp: () {},
        onVerifyOtp: () {
          Navigator.pushNamedAndRemoveUntil(
            context,
            WalletChargeDone.routeName,
            (route) => route.settings.name == WalletView.routeName,
          );
        },
        isOtpComplete: true,
        isHaveImage: false,
      ),
    );
  }
}
