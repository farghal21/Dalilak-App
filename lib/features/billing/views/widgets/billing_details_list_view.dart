import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../history/views/widgets/history_list_view_item.dart';
import '../../manager/billing_cubit/billing_cubit.dart';
import '../../manager/billing_cubit/billing_state.dart';

class BillingDetailsListView extends StatelessWidget {
  const BillingDetailsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingCubit, BillingState>(
      builder: (context, state) {
        var cubit = BillingCubit.get(context);
        return Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                var bill = cubit.displayedBills[index];
                return BillDetailsWidget(
                  billNumber: bill['billNumber'],
                  billName: bill['billName'],
                  billDate: bill['billDate'],
                  billAmount: '\$${bill['billAmount']}',
                  billStatus: bill['billStatus'],
                  billType: bill['billType'],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: MyResponsive.height(value: 20),
              ),
              itemCount: cubit.displayedBills.length,
            ),
          ],
        );
      },
    );
  }
}

class BillDetailsWidget extends StatelessWidget {
  const BillDetailsWidget({
    super.key,
    required this.billNumber,
    required this.billName,
    required this.billDate,
    required this.billAmount,
    required this.billStatus,
    required this.billType,
  });

  final String billNumber;
  final String billName;
  final String billDate;
  final String billAmount;
  final String billStatus;
  final String billType;

  @override
  Widget build(BuildContext context) {
    // return Container(
    //   padding: MyResponsive.paddingSymmetric(
    //     horizontal: 18,
    //     vertical: 25,
    //   ),
    //   decoration: BoxDecoration(
    //     color: AppColors.appFill,
    //     borderRadius: BorderRadius.circular(MyResponsive.radius(value: 5)),
    //     border: Border.all(
    //       color: AppColors.white.withValues(alpha: .1),
    //       width: 1,
    //     ),
    //   ),
    //   child:
    //   Column(
    //     children: [
    //
    //
    //       // Row(
    //       //   children: [
    //       //     Expanded(
    //       //       child: Text(
    //       //         AppStrings.billNumber,
    //       //         style: AppTextStyles.semiBold17,
    //       //       ),
    //       //     ),
    //       //     Text(
    //       //       billNumber,
    //       //       style: AppTextStyles.semiBold17.copyWith(color: AppColors.gray),
    //       //     ),
    //       //   ],
    //       // ),
    //       // SizedBox(
    //       //   height: MyResponsive.height(value: 10),
    //       // ),
    //       // Row(
    //       //   children: [
    //       //     Expanded(
    //       //       child: Text(
    //       //         AppStrings.operationName,
    //       //         style: AppTextStyles.semiBold17,
    //       //       ),
    //       //     ),
    //       //     Text(
    //       //       billName,
    //       //       style: AppTextStyles.semiBold17.copyWith(color: AppColors.gray),
    //       //     ),
    //       //   ],
    //       // ),
    //       // SizedBox(
    //       //   height: MyResponsive.height(value: 10),
    //       // ),
    //       // Row(
    //       //   children: [
    //       //     Expanded(
    //       //       child: Text(
    //       //         AppStrings.operationType,
    //       //         style: AppTextStyles.semiBold17,
    //       //       ),
    //       //     ),
    //       //     Text(
    //       //       billType,
    //       //       style: AppTextStyles.semiBold17.copyWith(color: AppColors.gray),
    //       //     ),
    //       //   ],
    //       // ),
    //       // SizedBox(
    //       //   height: MyResponsive.height(value: 10),
    //       // ),
    //       // Row(
    //       //   children: [
    //       //     Expanded(
    //       //       child: Text(
    //       //         AppStrings.operationCost,
    //       //         style: AppTextStyles.semiBold17,
    //       //       ),
    //       //     ),
    //       //     Text(
    //       //       billAmount,
    //       //       style: AppTextStyles.semiBold17.copyWith(color: AppColors.gray),
    //       //     ),
    //       //   ],
    //       // ),
    //       // SizedBox(
    //       //   height: MyResponsive.height(value: 10),
    //       // ),
    //       // Row(
    //       //   children: [
    //       //     Expanded(
    //       //       child: Text(
    //       //         AppStrings.operationStatus,
    //       //         style: AppTextStyles.semiBold17,
    //       //       ),
    //       //     ),
    //       //     Text(
    //       //       billStatus,
    //       //       style: AppTextStyles.semiBold17.copyWith(color: AppColors.gray),
    //       //     ),
    //       //   ],
    //       // ),
    //       // SizedBox(
    //       //   height: MyResponsive.height(value: 10),
    //       // ),
    //       // Row(
    //       //   children: [
    //       //     Expanded(
    //       //       child: Text(
    //       //         AppStrings.operationDate,
    //       //         style: AppTextStyles.semiBold17,
    //       //       ),
    //       //     ),
    //       //     Text(
    //       //       billDate,
    //       //       style: AppTextStyles.semiBold17.copyWith(color: AppColors.gray),
    //       //     ),
    //       //   ],
    //       // ),
    //     ],
    //   ),
    // );
    return HistoryListViewItem(isSelected: false);
  }
}
