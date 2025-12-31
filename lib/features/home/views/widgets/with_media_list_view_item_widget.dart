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
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF1B0034),
            Color(0xFF2D1B4E),
          ],
        ),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 24)),
        border: Border.all(
          color: AppColors.white.withValues(alpha: .08),
          width: MyResponsive.width(value: 1.5),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withValues(alpha: .4),
            blurRadius: 20,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car Image Section - More Prominent
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MyResponsive.radius(value: 24)),
              topRight: Radius.circular(MyResponsive.radius(value: 24)),
            ),
            child: Container(
              height: MyResponsive.height(value: 200),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.black.withValues(alpha: .3),
                    Colors.transparent,
                  ],
                ),
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  car.images.isNotEmpty
                      ? CachedNetworkImageWrapper(
                          imagePath: car.images.first,
                          fit: BoxFit.cover,
                        )
                      : Image.asset(
                          AppAssets.testImage,
                          fit: BoxFit.cover,
                        ),
                  // Gradient Overlay for better text visibility
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: MyResponsive.height(value: 80),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            AppColors.black.withValues(alpha: .85),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Section
          Padding(
            padding: MyResponsive.paddingSymmetric(
              horizontal: 16,
              vertical: 16,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Car Name - Primary Text
                Text(
                  car.name,
                  style: AppTextStyles.bold20.copyWith(
                    color: AppColors.white,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                SizedBox(height: MyResponsive.height(value: 16)),

                // Specs Grid - Cleaner Layout
                Row(
                  children: [
                    Expanded(
                      child: _buildSpecItem(
                        icon: Icons.settings_outlined,
                        label: car.specs.transmission ?? 'غير محدد',
                      ),
                    ),
                    SizedBox(width: MyResponsive.width(value: 12)),
                    Expanded(
                      child: _buildSpecItem(
                        icon: Icons.speed_outlined,
                        label: '${car.specs.horsepower ?? '---'} حصان',
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 12)),

                Row(
                  children: [
                    Expanded(
                      child: _buildSpecItem(
                        icon: Icons.local_gas_station_outlined,
                        label: car.specs.engineCapacity ??
                            car.specs.fuelType ??
                            'غير محدد',
                      ),
                    ),
                    SizedBox(width: MyResponsive.width(value: 12)),
                    // Price Badge - Elegant Integration
                    Expanded(
                      child: Container(
                        padding: MyResponsive.paddingSymmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppColors.primary.withValues(alpha: .15),
                              AppColors.secondary.withValues(alpha: .15),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(
                            MyResponsive.radius(value: 12),
                          ),
                          border: Border.all(
                            color: AppColors.primary.withValues(alpha: .3),
                            width: 1,
                          ),
                        ),
                        child: Text(
                          car.price,
                          style: AppTextStyles.semiBold15.copyWith(
                            color: AppColors.primary,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 20)),

                // Modern Glassmorphism Button
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        AppColors.white.withValues(alpha: .05),
                        AppColors.white.withValues(alpha: .02),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(
                      MyResponsive.radius(value: 14),
                    ),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: .15),
                      width: 1.5,
                    ),
                  ),
                  child: CustomButton(
                    title: AppStrings.details,
                    onPressed: () {
                      UserCubit.get(context).selectedCar = car;
                      MyNavigator.goTo(screen: () => const CarDetailsView());
                    },
                    height: MyResponsive.height(value: 48),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecItem({required IconData icon, required String label}) {
    return Container(
      padding: MyResponsive.paddingSymmetric(
        horizontal: 10,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.white.withValues(alpha: .05),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        border: Border.all(
          color: AppColors.white.withValues(alpha: .1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: AppColors.white.withValues(alpha: .7),
            size: MyResponsive.fontSize(value: 16),
          ),
          SizedBox(width: MyResponsive.width(value: 8)),
          Expanded(
            child: Text(
              label,
              style: AppTextStyles.regular12.copyWith(
                color: AppColors.white.withValues(alpha: .85),
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
