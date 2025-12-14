

import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';



class FirstSectionDetails extends StatelessWidget {
  const FirstSectionDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Pyramids of Giza',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppTextStyles.bold20,
                ),
              ),
              SizedBox(width: MyResponsive.width(value: 6)),
              // RatingBarWrapper(
              //   rating: 5,
              //   starSize: 15,
              //   spaceBetweenStars: 1,
              // ),
              SizedBox(width: MyResponsive.width(value: 6)),
              Text(
                "(4)",
                style: AppTextStyles.semiBold14.copyWith(
                  color: Colors.deepOrange,
                ),
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 8)),
          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: AppColors.black.withValues(alpha: .5),
                size: MyResponsive.fontSize(value: 20),
              ),
              SizedBox(width: MyResponsive.width(value: 4)),
              Text(
                'Giza, Egypt, Elharam St.',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyles.semiBold14
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 15)),
          Text(
            'The Pyramids of Giza, located on the outskirts of Cairo, Egypt, are one of the most iconic and enduring symbols of ancient civilization.',
              style: AppTextStyles.semiBold14
          ),
        ],
      ),
    );
  }
}
