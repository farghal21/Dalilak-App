import 'package:dalilak_app/features/compare/views/widgets/compare_view_body.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class CompareView extends StatelessWidget {
  const CompareView({super.key});

  static const String routeName = 'CompareView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      drawerSelectedIndex: 2,
      body: CompareViewBody(),
    );
  }
}
