import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_cubit.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HistoryCubit, HistoryState>(
      builder: (context, state) {
        var cubit = HistoryCubit.get(context);
        final data =
            state is HistorySearchState ? state.results : cubit.historyData;
        return ListView.separated(
          padding: EdgeInsets.zero,
          // shrinkWrap: true,
          // physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            var historyItem = data[index];
            return BillDetailsWidget(
              name: historyItem["name"],
              time: historyItem["lastInteraction"],
            );
          },
          separatorBuilder: (context, index) => SizedBox(
            height: MyResponsive.height(value: 20),
          ),
          itemCount: data.length,
        );
      },
    );
  }
}

class BillDetailsWidget extends StatelessWidget {
  const BillDetailsWidget({
    super.key,
    required this.name,
    required this.time,
  });

  final String name;
  final int time;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: MyResponsive.paddingSymmetric(
        horizontal: 20,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: AppTextStyles.bold20,
          ),
          SizedBox(
            height: MyResponsive.height(value: 6),
          ),
          Text(
            "اخر تفاعل منذ  $time ايام  ",
            style: AppTextStyles.regular14.copyWith(color: AppColors.gray),
          ),
          SizedBox(
            height: MyResponsive.height(value: 14),
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF4A3771)),
                child: Text(
                  AppStrings.rename,
                  style:
                      AppTextStyles.regular11.copyWith(color: AppColors.white),
                ),
              ),
              SizedBox(
                width: MyResponsive.width(value: 10),
              ),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.red,
                ),
                child: Text(
                  AppStrings.remove,
                  style:
                      AppTextStyles.regular11.copyWith(color: AppColors.white),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
