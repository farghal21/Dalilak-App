import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/car_details/car_details_view.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
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
    return Container(
      decoration: BoxDecoration(
        color: Color(0xff290f4c), // Dark purple background
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 20)),
      ),
      padding: MyResponsive.paddingAll(value: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Row: Images and Details
          Row(
            children: [
              // Left: Stacked Images
              SizedBox(
                width: MyResponsive.width(value: 140),
                height: MyResponsive.height(value: 150),
                child: Stack(
                  children: [
                    // Bottom card (back)
                    if (car.images.length >= 3)
                      Positioned(
                        left: MyResponsive.width(value: 14),
                        top: MyResponsive.height(value: 13),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MyResponsive.radius(value: 10)),
                          child: CachedNetworkImageWrapper(
                            imagePath: car.images[2],
                            width: MyResponsive.width(value: 112),
                            height: MyResponsive.height(value: 124),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // Middle card
                    if (car.images.length >= 2)
                      Positioned(
                        left: MyResponsive.width(value: 7),
                        top: MyResponsive.height(value: 7),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(
                              MyResponsive.radius(value: 10)),
                          child: CachedNetworkImageWrapper(
                            imagePath: car.images[1],
                            width: MyResponsive.width(value: 119),
                            height: MyResponsive.height(value: 131),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    // Top card (front)
                    Positioned(
                      left: 0,
                      top: 0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                            MyResponsive.radius(value: 10)),
                        child: car.images.isNotEmpty
                            ? CachedNetworkImageWrapper(
                                imagePath: car.images.first,
                                width: MyResponsive.width(value: 126),
                                height: MyResponsive.height(value: 138),
                                fit: BoxFit.cover,
                              )
                            : Image.asset(
                                AppAssets.testImage,
                                width: MyResponsive.width(value: 126),
                                height: MyResponsive.height(value: 138),
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: MyResponsive.width(value: 12)),
              // Right: Car Details
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      car.name,
                      style:
                          AppTextStyles.bold16.copyWith(color: AppColors.white),
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    // Feature 1: Transmission
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColors.white,
                          size: MyResponsive.width(value: 6),
                        ),
                        SizedBox(width: MyResponsive.width(value: 8)),
                        Expanded(
                          child: Text(
                            'ناقل الحركة: ${car.specs.transmission ?? 'غير محدد'}',
                            style: AppTextStyles.regular12
                                .copyWith(color: AppColors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    // Feature 2: Horsepower
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColors.white,
                          size: MyResponsive.width(value: 6),
                        ),
                        SizedBox(width: MyResponsive.width(value: 8)),
                        Expanded(
                          child: Text(
                            'القوة: ${car.specs.horsepower ?? 'غير محدد'} حصان',
                            style: AppTextStyles.regular12
                                .copyWith(color: AppColors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    // Feature 3: Engine
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.circle,
                          color: AppColors.white,
                          size: MyResponsive.width(value: 6),
                        ),
                        SizedBox(width: MyResponsive.width(value: 8)),
                        Expanded(
                          child: Text(
                            'المحرك: ${car.specs.engineCapacity ?? car.specs.turbo ?? car.specs.fuelType ?? 'غير محدد'}',
                            style: AppTextStyles.regular12
                                .copyWith(color: AppColors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: MyResponsive.height(value: 8)),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //
                        SizedBox(width: MyResponsive.width(value: 8)),
                        Text(
                          'السعر: ${car.price}',
                          style: AppTextStyles.semiBold14
                              .copyWith(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 16)),
          // Bottom: Custom Button
          Container(
            decoration: BoxDecoration(
              color: Color(0xff232138).withValues(alpha: .7),
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 10)),
              border: Border.all(
                color: AppColors.white.withValues(alpha: .2),
                width: MyResponsive.width(value: 1),
              ),
            ),
            child: CustomButton(
              title: AppStrings.details,
              onPressed: () {
                UserCubit.get(context).selectedCar = car;
                MyNavigator.goTo(screen: () => const CarDetailsView());
              },
              height: MyResponsive.height(value: 50),
              backgroundColor: Colors.transparent,
            ),
          ),
        ],
      ),
    );
  }
}
