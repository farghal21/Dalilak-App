import 'dart:async';
import 'package:dalilak_app/core/cache/cache_data.dart';
import 'package:dalilak_app/core/cache/cache_helper.dart';
import 'package:dalilak_app/core/cache/cache_key.dart';
import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/home/views/home_view.dart';
import 'package:dalilak_app/features/onboarding/view/on_boarding_screen.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/animated_app_loading.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';

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
    CacheData.accessToken = CacheHelper.getData(key: CacheKeys.accessToken);
    if (CacheData.accessToken != null) {
      UserCubit.get(context).getUserData().then((bool result) {
        if (result) {
          MyNavigator.goTo(screen: () => const HomeView(), isReplace: true);
        } else {
          MyNavigator.goTo(
              screen: () => const OnBoardingView(), isReplace: true);
        }
      });
    } else {
      // goto login
      MyNavigator.goTo(screen: () => const OnBoardingView(), isReplace: true);
    }
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
          // Animated logo entrance
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeOutBack,
            builder: (context, value, child) {
              // Clamp value to prevent opacity assertion errors
              final clampedValue = value.clamp(0.0, 1.0);
              return Transform.scale(
                scale: clampedValue,
                child: Opacity(
                  opacity: clampedValue,
                  child: child,
                ),
              );
            },
            child: SvgWrapper(path: AppAssets.appLogo),
          ),
          SizedBox(height: MyResponsive.height(value: 45)),
          // Delayed loading indicator
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.easeIn,
            builder: (context, value, child) {
              // Clamp value for safety
              final clampedValue = value.clamp(0.0, 1.0);
              return Opacity(
                opacity: clampedValue,
                child: child,
              );
            },
            child: SizedBox(
              height: MyResponsive.height(value: 82),
              child: const AppLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
