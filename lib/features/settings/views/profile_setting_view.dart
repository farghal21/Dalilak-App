import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_state.dart';
import 'package:dalilak_app/features/settings/views/widgets/profile_setting_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});

  static const String routeName = 'ProfileSettingView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      showDrawer: false,
      drawerSelectedIndex: 4,
      body: BlocConsumer<UserCubit, UserState>(
        listener: (context, state) {
          if (state is UserUpdateSuccess) {
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return CustomProgressHud(
            isLoading: state is UserUpdateLoading,
            child: ProfileSettingViewBody(),
          );
        },
      ),
    );
  }
}
