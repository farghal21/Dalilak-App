import 'package:dalilak_app/features/settings/views/widgets/delete_account_setting_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/delete_account_setting_cubit/delete_account_setting_cubit.dart';
import '../manager/delete_account_setting_cubit/delete_account_setting_state.dart';
import 'delete_account_done_view.dart';

class DeleteAccountSettingView extends StatelessWidget {
  const DeleteAccountSettingView({super.key});

  static const String routeName = 'DeleteAccountView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DeleteAccountSettingCubit(),
      child: CustomScaffold(
        isHomeScreen: true,
        showDrawer: false,
        drawerSelectedIndex: 4,
        body:
        BlocConsumer<DeleteAccountSettingCubit, DeleteAccountSettingState>(
          listener: (context, state) {
            if (state is DeleteAccountSettingSuccess) {
              Navigator.pushNamedAndRemoveUntil(
                  context, DeleteAccountDoneView.routeName, (route) => false);
            }
          },
          builder: (context, state) {
            return CustomProgressHud(
              isLoading: state is DeleteAccountSettingLoading,
              child: DeleteAccountSettingViewBody(),
            );
          },
        ),
      ),
    );
  }
}
