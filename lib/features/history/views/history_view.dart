import 'package:dalilak_app/features/history/views/widgets/history_showing_dialog_widget.dart';
import 'package:dalilak_app/features/history/views/widgets/history_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';
import '../manager/history_cubit/hisroty_state.dart';
import '../manager/history_cubit/history_cubit.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  static const String routeName = 'HistoryView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HistoryCubit(),
      child: CustomScaffold(
        isHomeScreen: true,
        drawerSelectedIndex: 3,
        body: BlocConsumer<HistoryCubit, HistoryState>(
          listener: (context, state) {
            var cubit = HistoryCubit.get(context);
            if (state is HistorySuccess) {
              showDialog(
                context: context,
                builder: (context) => HistoryShowingDialogWidget(),
              );
              cubit.selectedItems.clear();
            }
          },
          builder: (context, state) {
            return CustomProgressHud(
              isLoading: state is HistoryLoading,
              child: HistoryViewBody(),
            );
          },
        ),
      ),
    );
  }
}
