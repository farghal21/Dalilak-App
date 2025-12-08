import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/history_cubit/history_cubit.dart';
import 'history_app_bar.dart';
import 'history_list_view_item.dart';

class HistoryViewBody extends StatelessWidget {
  const HistoryViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = HistoryCubit.get(context);
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),

      /// ابقى شيل ال single child scroll
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(
            //   height: MyResponsive.height(value: 110),
            // ),
            // // Text(
            // //   AppStrings.faz3a,
            // //   style: AppTextStyles.semiBold24,
            // // ),
            // HistoryAppBar(),
            // SizedBox(
            //   height: MyResponsive.height(value: 28),
            // ),
            // // StatesFilterDropdownWidget(
            // //     selectedValue: cubit.selectedFilter,
            // //     items: cubit.filters,
            // //     onChanged: (value) {
            // //       cubit.changeFilter(value!);
            // //     }),
            // SizedBox(
            //   height: MyResponsive.height(value: 22),
            // ),
            // Container(
            //   height: MyResponsive.height(value: 574),
            //   width: double.infinity,
            //   decoration: BoxDecoration(
            //     color: AppColors.appFill,
            //     borderRadius:
            //         BorderRadius.circular(MyResponsive.radius(value: 10)),
            //     border: Border.all(
            //       color: AppColors.white.withValues(alpha: .1),
            //       width: 1,
            //     ),
            //   ),
            //   child: ListView.separated(
            //     padding: MyResponsive.paddingAll(value: 16),
            //     itemBuilder: (context, index) {
            //       final item = cubit.filteredItems[index];
            //       final isSelected = cubit.selectedItems.contains(index);
            //
            //       return GestureDetector(
            //         onTap: () {
            //           cubit.toggleSelectedItem(index);
            //         },
            //         child: HistoryListViewItem(
            //           isSelected: isSelected,
            //         ),
            //       );
            //     },
            //     separatorBuilder: (context, index) => SizedBox(
            //       height: MyResponsive.height(value: 12),
            //     ),
            //     itemCount: cubit.filteredItems.length,
            //   ),
            // ),
            // SizedBox(
            //   height: MyResponsive.height(value: 10),
            // ),
            // Visibility(
            //   visible: cubit.selectedItems.isNotEmpty,
            //   maintainSize: true,
            //   maintainAnimation: true,
            //   maintainState: true,
            //   child: CustomButton(
            //     title: AppStrings.askFaz3a,
            //     onPressed: cubit.askFaz3a,
            //     height: MyResponsive.height(value: 56),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
