import 'package:dalilak_app/features/settings/views/widgets/notification_setting_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/notification_settings_cubit/notification_settings_cubit.dart';
import '../manager/notification_settings_cubit/notification_settings_state.dart';

class NotificationSettingView extends StatelessWidget {
  const NotificationSettingView({super.key});

  static const String routeName = 'NotificationSettingView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => NotificationSettingsCubit(),
      child: Builder(builder: (context) {
        return CustomScaffold(
          isHomeScreen: true,
          showDrawer: false,
          drawerSelectedIndex: 4,
          body:
              BlocBuilder<NotificationSettingsCubit, NotificationSettingsState>(
            builder: (context, state) {
              return NotificationSettingViewBody();
            },
          ),
        );
      }),
    );
  }
}
