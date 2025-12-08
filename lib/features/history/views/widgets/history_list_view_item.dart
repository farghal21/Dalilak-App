import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class HistoryListViewItem extends StatelessWidget {
  const HistoryListViewItem({super.key, required this.isSelected});

  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: MyResponsive.paddingSymmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        border: isSelected
            ? Border.all(
                color: AppColors.white.withValues(alpha: .5),
                width: 1,
              )
            : null,
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              AppStrings.chatTitle,
              style: AppTextStyles.bold20,
            ),
            subtitle: Text(
              AppStrings.chatTime,
              style: AppTextStyles.regular11.copyWith(color: AppColors.gray),
            ),
          ),
          SizedBox(
            height: MyResponsive.height(value: 4),
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
