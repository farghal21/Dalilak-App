import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import 'widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const String routeName = 'SettingsView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      drawerSelectedIndex: 4,
      body: SettingsViewBody(),
    );
  }
}
