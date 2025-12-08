import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class BuyingAndBookingHistoryListViewItem extends StatelessWidget {
  const BuyingAndBookingHistoryListViewItem({
    super.key,
    required this.itemType,
    this.title,
    required this.price,
  });

  final BuyingAndBookingHistoryItemType itemType;
  final String? title;
  final double price;

  @override
  Widget build(BuildContext context) {
    switch (itemType) {
      case BuyingAndBookingHistoryItemType.hotelBooking:
        return _item(
          imagePath: AppAssets.homeIcon,
          title: title!,
          category: AppStrings.hotelBooking,
          price: price,
        );
      case BuyingAndBookingHistoryItemType.chargeOperation:
        return _item(
          imagePath: AppAssets.creditCardIcon,
          title: AppStrings.addCharge,
          category: AppStrings.chargeOperation,
          price: price,
          isChargeOperation: true,
        );
      case BuyingAndBookingHistoryItemType.product:
        return _item(
          imagePath: AppAssets.productsIcon,
          title: title!,
          category: AppStrings.product,
          price: price,
        );
    }
  }

  Widget _item({
    required String imagePath,
    required String title,
    required String category,
    required double price,
    bool isChargeOperation = false,
  }) {
    return Row(
      children: [
        Container(
          width: MyResponsive.width(value: 65),
          height: MyResponsive.height(value: 65),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primary,
                AppColors.secondary,
              ],
            ),
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          ),
          child: Center(
            child: SvgWrapper(
              path: imagePath,
              width: MyResponsive.width(value: 36),
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(
          width: MyResponsive.width(value: 39),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppTextStyles.semiBold16,
              ),
              SizedBox(
                height: MyResponsive.height(value: 8),
              ),
              Text(
                category,
                style: AppTextStyles.semiBold12.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
        Text(
          "$price ${AppStrings.rs}",
          style: AppTextStyles.semiBold16.copyWith(
              color: isChargeOperation ? Color(0xff09FDDC) : AppColors.red),
        ),
      ],
    );
  }
}

enum BuyingAndBookingHistoryItemType { hotelBooking, chargeOperation, product }
