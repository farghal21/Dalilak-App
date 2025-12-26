import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';
import '../../../core/user/manager/user_cubit/user_cubit.dart';
import '../../../core/user/manager/user_cubit/user_state.dart';
import 'widgets/settings_view_body.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  static const String routeName = 'SettingsView';

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) => CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 4,
        body: SettingsViewBody(),
      ),
    );
  }
}
