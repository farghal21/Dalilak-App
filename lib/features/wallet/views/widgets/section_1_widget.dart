import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../charge_type_view.dart';
import 'circular_percent_widget.dart';

class Section1Widget extends StatelessWidget {
  const Section1Widget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: MyResponsive.paddingSymmetric(horizontal: 20, vertical: 22),
      decoration: BoxDecoration(
        color: AppColors.appFill,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        border: Border.all(
          color: AppColors.white.withValues(alpha: .1),
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircularPercentWidget(
                percentage: .26,
                radius: MyResponsive.radius(value: 50),
                lineWidth: MyResponsive.width(value: 10),
              ),
              SizedBox(
                width: MyResponsive.width(value: 12),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.myCharge,
                    style: AppTextStyles.semiBold17,
                  ),
                  SizedBox(
                    height: MyResponsive.height(value: 4),
                  ),
                  Text(
                    '357,369.00 ر.س',
                    style: AppTextStyles.semiBold28,
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: MyResponsive.height(value: 20),
          ),
          CustomButton(
            title: AppStrings.addCharge,
            onPressed: () {
              Navigator.pushNamed(context, ChargeTypeView.routeName);
            },
            height: MyResponsive.height(value: 38),
            width: MyResponsive.width(value: 175),
            backgroundColor: AppColors.secondary,
          ),
        ],
      ),
    );
  }
}
