import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class ChargeTypeContainer extends StatelessWidget {
  final bool? isClosed;
  final bool? isShowedImages;
  final String title;

  const ChargeTypeContainer({
    super.key,
    this.isClosed = false,
    this.isShowedImages = true,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingSymmetric(horizontal: 12, vertical: 20),
      width: double.infinity,
      decoration: BoxDecoration(
          color: AppColors.appFill,
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          border: Border.all(
            color: AppColors.white.withValues(alpha: .1),
            width: MyResponsive.width(value: 1),
          )),
      child: Row(
        children: [
          Radio(
            value: isClosed! ? 0 : 1,
            groupValue: 1,
            onChanged: isClosed! ? null : (value) {},
            activeColor: isClosed!
                ? AppColors.white.withValues(alpha: .2)
                : AppColors.white,
          ),
          SizedBox(
            width: MyResponsive.width(value: 8),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.semiBold16.copyWith(
                    color: isClosed!
                        ? AppColors.white.withValues(alpha: .2)
                        : AppColors.white,
                  ),
                ),
                if (isClosed!) ...[
                  SizedBox(
                    height: MyResponsive.height(value: 4),
                  ),
                  Text(
                    AppStrings.serviceClose,
                    style: AppTextStyles.semiBold11.copyWith(
                      color: AppColors.white.withValues(alpha: .2),
                    ),
                  ),
                ]
              ],
            ),
          ),
          if (isShowedImages!) ...[
            Image.asset(
              AppAssets.visaLogo,
              width: MyResponsive.width(value: 43),
              fit: BoxFit.fill,
            ),
            SizedBox(width: MyResponsive.width(value: 8)),
            Image.asset(
              AppAssets.mastercardLogo,
              width: MyResponsive.width(value: 32),
              fit: BoxFit.fill,
            ),
          ]
        ],
      ),
    );
  }
}
