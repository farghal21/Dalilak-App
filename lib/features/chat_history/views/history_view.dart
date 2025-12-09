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
      create: (context) => HistoryCubit(),
      child: CustomScaffold(
        drawerSelectedIndex: 2,
        isHomeScreen: true,
        body: HistoryViewBody(),
      ),
    );
  }
}
