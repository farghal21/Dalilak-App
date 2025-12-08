import 'package:dalilak_app/features/splash/views/widgets/splash_view_body.dart';
import 'package:flutter/material.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  static const String routeName = "splash";

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SplashViewBody(),
    );
  }
}
