import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import 'buying_and_booking_history.dart';
import 'custom_wallet_container.dart';
import 'section_1_widget.dart';
import 'wallet_chart_widget.dart';

class WalletViewBody extends StatelessWidget {
  const WalletViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            // SizedBox(
            //   height: MyResponsive.height(value: 100),
            // ),
            // Section1Widget(),
            // SizedBox(
            //   height: MyResponsive.height(value: 13),
            // ),
            // CustomWalletContainer(
            //   title: AppStrings.charge,
            //   amount: 6476.00,
            //   percentage: 0.26,
            // ),
            // SizedBox(
            //   height: MyResponsive.height(value: 13),
            // ),
            // CustomWalletContainer(
            //   title: AppStrings.payments,
            //   amount: 12476.00,
            //   percentage: 0.39,
            // ),
            // SizedBox(
            //   height: MyResponsive.height(value: 13),
            // ),
            // WalletChartWidget(
            //   data: [
            //     ChartDataPoint(date: '29/03', charge: 150, payment: 80),
            //     ChartDataPoint(date: '30/03', charge: 200, payment: 120),
            //     ChartDataPoint(date: '31/03', charge: 100, payment: 60),
            //     ChartDataPoint(date: '01/04', charge: 250, payment: 150),
            //     ChartDataPoint(date: '02/04', charge: 300, payment: 200),
            //     ChartDataPoint(date: '03/04', charge: 180, payment: 90),
            //     ChartDataPoint(date: '04/04', charge: 220, payment: 130),
            //     ChartDataPoint(date: '05/04', charge: 220, payment: 130),
            //   ],
            // ),
            // SizedBox(
            //   height: MyResponsive.height(value: 13),
            // ),
            // BuyingAndBookingHistory(),
            // SizedBox(
            //   height: MyResponsive.height(value: 70),
            // ),
          ],
        ),
      ),
    );
  }
}
