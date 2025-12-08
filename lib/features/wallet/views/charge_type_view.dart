import 'package:dalilak_app/features/wallet/views/widgets/charge_type_view_body.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class ChargeTypeView extends StatelessWidget {
  const ChargeTypeView({super.key});

  static const String routeName = 'chargeTypeView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      drawerSelectedIndex: 1,
      showDrawer: false,
      body: ChargeTypeViewBody(),
    );
  }
}
