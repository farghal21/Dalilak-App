import 'package:flutter/material.dart';

import '../../features/auth/views/login_view.dart';
import '../../features/auth/views/register_done_view.dart';
import '../../features/auth/views/register_otp_view.dart';
import '../../features/auth/views/register_view.dart';
import '../../features/auth/views/reset_password_done_view.dart';
import '../../features/auth/views/reset_password_new_pass_view.dart';
import '../../features/auth/views/reset_password_otp_view.dart';
import '../../features/auth/views/reset_password_verify_email_view.dart';
import '../../features/car_details/car_details_view.dart';
import '../../features/chat_history/views/history_view.dart';
import '../../features/compare/views/compare_view.dart';
import '../../features/favorite/view/favorite_view.dart';
import '../../features/home/views/home_view.dart';
import '../../features/on_boarding/views/on_boarding_view.dart';
import '../../features/settings/views/delete_account_done_view.dart';
import '../../features/settings/views/delete_account_setting_view.dart';
import '../../features/settings/views/notification_setting_view.dart';
import '../../features/settings/views/privacy_policy_setting_view.dart';
import '../../features/settings/views/profile_setting_view.dart';
import '../../features/settings/views/public_settings_view.dart';
import '../../features/settings/views/settings_view.dart';
import '../../features/splash/views/splash_view.dart';

Route<dynamic> onGenerateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(
        builder: (context) => SplashView(),
        settings: settings,
      );

    case LoginView.routeName:
      return MaterialPageRoute(
        builder: (context) => LoginView(),
        settings: settings,
      );

    case ResetPasswordVerifyEmailView.routeName:
      return MaterialPageRoute(
        builder: (context) => ResetPasswordVerifyEmailView(),
        settings: settings,
      );

    case ResetPasswordOtpView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordOtpView(),
        settings: settings,
      );

    case ResetPasswordNewPassView.routeName:
      return MaterialPageRoute(
        builder: (context) => ResetPasswordNewPassView(),
        settings: settings,
      );

    case ResetPasswordDoneView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ResetPasswordDoneView(),
        settings: settings,
      );

    case RegisterView.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterView(),
        settings: settings,
      );

    case RegisterOtpView.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterOtpView(),
        settings: settings,
      );

    case RegisterDoneView.routeName:
      return MaterialPageRoute(
        builder: (context) => const RegisterDoneView(),
        settings: settings,
      );

    case OnBoardingView.routeName:
      return MaterialPageRoute(
        builder: (context) => const OnBoardingView(),
        settings: settings,
      );

    case HomeView.routeName:
      return MaterialPageRoute(
        builder: (context) => HomeView(),
        settings: settings,
      );

      case CarDetailsView.routeName:
      return MaterialPageRoute(
        builder: (context) => CarDetailsView(),
        settings: settings,
      );

    case CompareView.routeName:
      return MaterialPageRoute(
        builder: (context) => const CompareView(),
        settings: settings,
      );

    case HistoryView.routeName:
      return MaterialPageRoute(
        builder: (context) => const HistoryView(),
        settings: settings,
      );
    case FavoriteView.routeName:
      return MaterialPageRoute(
        builder: (context) => const FavoriteView(),
        settings: settings,
      );

    case SettingsView.routeName:
      return MaterialPageRoute(
        builder: (context) => const SettingsView(),
        settings: settings,
      );

    case PublicSettingsView.routeName:
      return MaterialPageRoute(
        builder: (context) => const PublicSettingsView(),
        settings: settings,
      );

    case ProfileSettingView.routeName:
      return MaterialPageRoute(
        builder: (context) => const ProfileSettingView(),
        settings: settings,
      );

    case NotificationSettingView.routeName:
      return MaterialPageRoute(
        builder: (context) => const NotificationSettingView(),
        settings: settings,
      );

    case PrivacyPolicySettingView.routeName:
      return MaterialPageRoute(
        builder: (context) => const PrivacyPolicySettingView(),
        settings: settings,
      );

    case DeleteAccountSettingView.routeName:
      return MaterialPageRoute(
        builder: (context) => const DeleteAccountSettingView(),
        settings: settings,
      );

    case DeleteAccountDoneView.routeName:
      return MaterialPageRoute(
        builder: (context) => const DeleteAccountDoneView(),
        settings: settings,
      );

    default:
      return MaterialPageRoute(
        builder: (context) => SplashView(),
        settings: settings,
      );
  }
}
