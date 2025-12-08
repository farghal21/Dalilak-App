import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/animated_app_loading.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../auth/views/login_view.dart';

class SplashViewBody extends StatefulWidget {
  const SplashViewBody({super.key});

  @override
  State<SplashViewBody> createState() => _SplashViewBodyState();
}

class _SplashViewBodyState extends State<SplashViewBody> {
  Timer? _timer;
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer(const Duration(seconds: 3), _goNext);
  }

  void _goNext() {
    if (!mounted || _navigated) return;

    _navigated = true;
    Navigator.of(context).pushNamedAndRemoveUntil(
      LoginView.routeName,
      (route) => false,
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgWrapper(path: AppAssets.appLogo),
          SizedBox(height: MyResponsive.height(value: 45)),
          SizedBox(
            height: MyResponsive.height(value: 82),
            child: const AppLoading(),
          ),
        ],
      ),
    );
  }
}
