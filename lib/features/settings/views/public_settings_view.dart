import 'package:dalilak_app/features/settings/views/widgets/public_settings_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/public_settings_cubit/public_settings_cubit.dart';
import '../manager/public_settings_cubit/public_settings_state.dart';

class PublicSettingsView extends StatelessWidget {
  const PublicSettingsView({super.key});

  static const String routeName = 'PublicSettingsView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PublicSettingsCubit(),
      child: Builder(builder: (context) {
        return CustomScaffold(
          isHomeScreen: true,
          showDrawer: false,
          drawerSelectedIndex: 4,
          body: BlocBuilder<PublicSettingsCubit, PublicSettingsState>(
            builder: (context, state) {
              return PublicSettingsViewBody();
            },
          ),
        );
      }),
    );
  }
}
