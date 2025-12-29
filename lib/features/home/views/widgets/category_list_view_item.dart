import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class CategoryListViewItem extends StatelessWidget {
  const CategoryListViewItem({
    super.key,
    required this.title,
    required this.subtitle,
    // required this.iconPath,
  });

  final String title;
  final String subtitle;

  // final String iconPath;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MyResponsive.width(value: 340),
      // height: MyResponsive.height(value: 175),
      padding: MyResponsive.paddingSymmetric(horizontal: 11.5, vertical: 19.5),
      decoration: BoxDecoration(
        gradient: AppColors.cardGradient,
        borderRadius: BorderRadius.circular(
          MyResponsive.radius(value: 15),
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              // Container(
              //   // width: MyResponsive.width(value: 50),
              //   // height: MyResponsive.height(value: 50),
              //   padding: MyResponsive.paddingAll(value: 10),
              //   decoration: BoxDecoration(
              //     color: AppColors.fillColor,
              //     borderRadius: BorderRadius.circular(
              //       MyResponsive.radius(value: 10),
              //     ),
              //   ),
              //   child: Center(
              //     child: SvgWrapper(
              //       path: iconPath,
              //       width: MyResponsive.width(value: 25.56),
              //     ),
              //   ),
              // ),
              SizedBox(
                width: MyResponsive.width(value: 12),
              ),
              Expanded(
                child: Text(
                  title,
                  style: AppTextStyles.bold20,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SvgWrapper(
                path: AppAssets.newChat,
                width: MyResponsive.fontSize(value: 30),
              )
            ],
          ),
          SizedBox(
            height: MyResponsive.height(value: 35),
          ),
          Text(
            subtitle,
            style: AppTextStyles.light17,
          ),
        ],
      ),
    );
  }
}
