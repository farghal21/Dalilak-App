import 'package:dalilak_app/core/helper/my_snackbar.dart';
import 'package:dalilak_app/core/shared_widgets/custom_error_widget.dart';
import 'package:dalilak_app/core/shared_widgets/custom_loading_indicator.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_cubit.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_state.dart';
import 'package:dalilak_app/features/chat_history/views/widgets/history_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {
        if (state is HistoryAction) {
          MySnackbar.success(context, state.message);
        } else if (state is HistoryError) {
          MySnackbar.error(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is HistoryError) {
          return CustomErrorWidget(errorMessage: state.error);
        } else if (state is HistoryLoadSuccess) {
          return ListView.separated(
            padding: EdgeInsets.zero,
            itemCount: state.history.length,
            itemBuilder: (context, index) {
              final item = state.history[index];
              return HistoryListViewItem(
                item: item,
              );
            },
            separatorBuilder: (context, state) =>
                SizedBox(height: MyResponsive.height(value: 16)),
          );
        } else {
          return CustomLoadingIndicator();
        }
      },
    );
  }
}
