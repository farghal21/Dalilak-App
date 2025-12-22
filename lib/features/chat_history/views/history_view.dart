import 'package:dalilak_app/core/helper/get_it.dart';
import 'package:dalilak_app/features/chat_history/data/repos/chat_history_repo.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_cubit.dart';
import 'package:dalilak_app/features/chat_history/views/widgets/history_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_scaffold.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({super.key});

  static const String routeName = 'historyView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          HistoryCubit(getIt<ChatHistoryRepo>())..fetchChatHistory(),
      child: CustomScaffold(
        drawerSelectedIndex: 1,
        isHomeScreen: true,
        body: HistoryViewBody(),
      ),
    );
  }
}
