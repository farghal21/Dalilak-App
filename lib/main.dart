import 'package:dalilak_app/core/user/data/repo/user_repo.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/auth/views/login_view.dart';
import 'package:dalilak_app/features/car_details/car_details_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'core/cache/cache_helper.dart';
import 'core/helper/custom_bloc_observer.dart';
import 'core/helper/get_it.dart';

import 'core/helper/one_generate_routes.dart';
import 'core/utils/app_constants.dart';
import 'core/utils/app_theme.dart';
import 'features/home/views/home_view.dart';
import 'features/splash/views/splash_view.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();
  await CacheHelper.init();
  setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<UserCubit>(
              create: (context) => UserCubit(getIt<UserRepo>()),
            ),
          ],
          child: GetMaterialApp(
            navigatorKey: AppConstants.navigatorKey,
            // localization
            localizationsDelegates: [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: const Locale("ar"),

            debugShowCheckedModeBanner: false,
            title: 'دليلك',
            theme: AppTheme.lightTheme,
            onGenerateRoute: onGenerateRoutes,
            initialRoute: SplashView.routeName,
          ),
        );
      },
    );
  }
}
