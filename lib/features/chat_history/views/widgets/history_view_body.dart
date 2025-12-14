import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_cubit.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_strings.dart';
import 'history_app_bar.dart';
import 'history_list_view.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = HistoryCubit.get(context);
        return Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: MyResponsive.height(value: 140),
              ),
              HistoryAppBar(title: AppStrings.searchYourChat,),
              SizedBox(
                height: MyResponsive.height(value: 30),
              ),
              CustomTextFormField(
                type: TextFieldType.search,
                searchOnChange: (value) {
                  cubit.historySearch(value);
                },
              ),
              SizedBox(
                height: MyResponsive.height(value: 30),
              ),
              Expanded(
                child: HistoryListView(),
              ),
              SizedBox(
                height: MyResponsive.height(value: 20),
              ),
            ],
          ),
        );
      },
    );
  }
}
