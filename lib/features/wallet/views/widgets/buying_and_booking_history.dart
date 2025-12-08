import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import 'buying_and_booking_history_list_view_item.dart';

class BuyingAndBookingHistory extends StatelessWidget {
  BuyingAndBookingHistory({super.key});

  final List<Widget> item = [
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.hotelBooking,
      title: "فندق الزهور",
      price: 760,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "مجموعة مقاعد",
      price: 1450,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.hotelBooking,
      title: "فندق قصر الطيور",
      price: 300,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.chargeOperation,
      price: 16349,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.hotelBooking,
      title: "فندق الريم",
      price: 300,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
    BuyingAndBookingHistoryListViewItem(
      itemType: BuyingAndBookingHistoryItemType.product,
      title: "طقم ادوات مطبخ",
      price: 650,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return Container(
      width: double.infinity,
      height: MyResponsive.height(value: 540),
      padding: MyResponsive.paddingSymmetric(horizontal: 33, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.appFill,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        border: Border.all(
          color: AppColors.white.withValues(alpha: .1),
          width: MyResponsive.width(value: 1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.buyingAndBooking,
            style: AppTextStyles.semiBold22,
          ),
          SizedBox(
            height: MyResponsive.height(value: 25),
          ),
          Expanded(
            child: RawScrollbar(
              controller: scrollController,
              thumbVisibility: true,
              trackVisibility: true,
              thickness: MyResponsive.width(value: 4),
              radius: Radius.circular(MyResponsive.radius(value: 8)),
              crossAxisMargin: -MyResponsive.width(value: 22),
              scrollbarOrientation: ScrollbarOrientation.right,
              child: ListView.separated(
                controller: scrollController,
                padding: EdgeInsets.zero,
                itemCount: item.length,
                separatorBuilder: (context, index) => SizedBox(
                  height: MyResponsive.height(value: 18),
                ),
                itemBuilder: (context, index) => item[index],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
