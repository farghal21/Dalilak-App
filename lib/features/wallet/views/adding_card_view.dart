import 'package:dalilak_app/features/wallet/views/widgets/adding_card_view_body.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class AddingCardView extends StatelessWidget {
  const AddingCardView({super.key});

  static const String routeName = 'addingCardView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      drawerSelectedIndex: 1,
      showDrawer: false,
      body: AddingCardViewBody(),
    );
  }
}
