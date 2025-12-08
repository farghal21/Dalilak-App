import 'package:dalilak_app/features/settings/views/widgets/profile_setting_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/profile_cubit/profile_cubit.dart';
import '../manager/profile_cubit/profile_state.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});

  static const String routeName = 'ProfileSettingView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(),
      child: CustomScaffold(
        isHomeScreen: true,
        showDrawer: false,
        drawerSelectedIndex: 4,
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileSuccess) {
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return CustomProgressHud(
              isLoading: state is ProfileLoading,
              child: ProfileSettingViewBody(),
            );
          },
        ),
      ),
    );
  }
}
