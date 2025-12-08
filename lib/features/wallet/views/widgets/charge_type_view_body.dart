import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../adding_card_view.dart';
import 'charge_type_container.dart';

class ChargeTypeViewBody extends StatelessWidget {
  const ChargeTypeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MyResponsive.height(value: 90),
          ),
          Text(
            AppStrings.selectChargeType,
            style: AppTextStyles.semiBold16,
          ),
          SizedBox(
            height: MyResponsive.height(value: 72),
          ),
          ChargeTypeContainer(
            title: AppStrings.bankCard,
          ),
          SizedBox(
            height: MyResponsive.height(value: 12),
          ),
          ChargeTypeContainer(
            title: AppStrings.faz3aPay,
            isClosed: true,
            isShowedImages: false,
          ),
          Expanded(child: SizedBox()),
          CustomButton(
            title: AppStrings.choose,
            onPressed: () {
              Navigator.pushNamed(context, AddingCardView.routeName);
            },
          ),
          SizedBox(
            height: MyResponsive.height(value: 60),
          ),
        ],
      ),
    );
  }
}
