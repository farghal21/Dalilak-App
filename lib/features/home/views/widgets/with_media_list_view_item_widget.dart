import 'package:dalilak_app/features/car_details/car_details_view.dart';
import 'package:dalilak_app/features/home/data/models/fetch_chat_messages_response_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/cached_network_image_wrapper.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class WithMediaListViewItemWidget extends StatelessWidget {
  const WithMediaListViewItemWidget({super.key, required this.car});

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 20)),
          child: car.images.isNotEmpty
              ? CachedNetworkImageWrapper(
                  imagePath: car.images.first,
                  width: MyResponsive.width(value: 186),
                  height: MyResponsive.height(value: 150),
                  fit: BoxFit.fill,
                )
              : Image.asset(
                  AppAssets.testImage,
                  width: MyResponsive.width(value: 186),
                  height: MyResponsive.height(value: 150),
                  fit: BoxFit.fill,
                ),
        ),
        SizedBox(height: MyResponsive.height(value: 12)),
        // SizedBox(height: MyResponsive.height(value: 52)),
        Text(
          car.name,
          style: AppTextStyles.semiBold15,
        ),
        SizedBox(height: MyResponsive.height(value: 8)),
        Container(
          decoration: BoxDecoration(
            color: Color(0xff232138).withValues(alpha: .7),
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
            border: Border.all(
              color: AppColors.white.withValues(alpha: .2),
              width: MyResponsive.width(value: 1),
            ),
          ),
          child: CustomButton(
            title: AppStrings.details,
            onPressed: () {
              Navigator.pushNamed(context, CarDetailsView.routeName);
            },
            height: MyResponsive.height(value: 50),
            backgroundColor: Colors.transparent,
          ),
        )
      ],
    );
  }
}
