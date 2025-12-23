import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class SecondSectionFeatures extends StatelessWidget {
  const SecondSectionFeatures({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    var car = cubit.selectedCar!;
    final List<Map<String, dynamic>> features = [
      {
        'title': 'ناقل الحركه',
        'subtitle': car.specs.transmission ?? 'غير معروف',
      },
      {
        'title': 'نوع الوقود',
        'subtitle': car.specs.fuelType ?? 'غير معروف',
      },
      {
        'title': 'قوة المحرك(حصان)',
        'subtitle': car.specs.horsepower ?? 'غير معروف',
      },
      {
        'title': 'السرعة القصوى ',
        'subtitle': car.specs.maxSpeed ?? 'غير معروف',
      },
    ];

    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.details,
            style: AppTextStyles.bold20,
          ),
          SizedBox(height: MyResponsive.height(value: 10)),
          Row(
            children: [
              // Icon(
              //   Icons.calendar_month_outlined,
              //   color: AppColors.black.withValues(alpha: .4),
              //   size: MyResponsive.fontSize(value: 18),
              // ),
              // SizedBox(width: MyResponsive.width(value: 4)),
              // Text(
              //   'created at: 20/10/2023',
              //   style: AppTextStyles.bold20,
              // ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 12)),
          SizedBox(
            height: MyResponsive.height(value: 200),
            child: GridView.builder(
              padding: EdgeInsets.zero,
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 200 / 100,
                mainAxisSpacing: MyResponsive.height(value: 12),
                crossAxisSpacing: MyResponsive.width(value: 12),
              ),
              itemBuilder: (context, index) {
                return FeatureGridItem(
                  // icon: features[index]['icon'],
                  title: features[index]['title'],
                  subtitle: features[index]['subtitle'],
                );
              },
              itemCount: 4,
            ),
          )
        ],
      ),
    );
  }
}

class FeatureGridItem extends StatelessWidget {
  const FeatureGridItem({
    super.key,
    // required this.icon,
    required this.title,
    required this.subtitle,
  });

  // final dynamic icon;
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 16)),
        border: Border.all(
          color: AppColors.black.withValues(alpha: .2),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon(
              //   icon,
              //   color: AppColors.primary,
              //   size: MyResponsive.fontSize(value: 20),
              // ),
              SizedBox(width: MyResponsive.width(value: 4)),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyles.semiBold16.copyWith(
                  color: AppColors.primary.withValues(alpha: 1),
                ),
              ),
            ],
          ),
          SizedBox(
            height: MyResponsive.height(value: 8),
          ),
          Text(
            subtitle,
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: AppTextStyles.bold20,
          ),
        ],
      ),
    );
  }
}
