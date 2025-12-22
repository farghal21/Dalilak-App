import 'dart:async';
import 'package:dalilak_app/core/cache/cache_data.dart';
import 'package:dalilak_app/core/cache/cache_helper.dart';
import 'package:dalilak_app/core/cache/cache_key.dart';
import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/home/views/home_view.dart';
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
    CacheData.accessToken = CacheHelper.getData(key: CacheKeys.accessToken);
    if (CacheData.accessToken != null) {
      UserCubit.get(context).getUserData().then((bool result) {
        if (result) {
          MyNavigator.goTo(screen: HomeView(), isReplace: true);
        } else {
          MyNavigator.goTo(screen: LoginView(), isReplace: true);
        }
      });
    }
    else {
      // goto login
      MyNavigator.goTo(screen: LoginView(), isReplace: true);
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
