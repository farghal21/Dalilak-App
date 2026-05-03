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
        'title': AppStrings.transmission,
        'subtitle': car.specs.transmission ?? AppStrings.unknown,
      },
      {
        'title': AppStrings.fuelType,
        'subtitle': car.specs.fuelType ?? AppStrings.unknown,
      },
      {
        'title': AppStrings.enginePowerHp,
        'subtitle': car.specs.horsepower ?? AppStrings.unknown,
      },
      {
        'title': AppStrings.maxSpeed,
        'subtitle': car.specs.maxSpeed ?? AppStrings.unknown,
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
          GridView.builder(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 200 / 100,
              mainAxisSpacing: MyResponsive.width(value: 16),
              crossAxisSpacing: MyResponsive.width(value: 16),
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
          SizedBox(height: MyResponsive.height(value: 20)),
          Divider(color: Colors.white24, thickness: 1),
          SizedBox(height: MyResponsive.height(value: 20)),
          Center(
            child: Text(
              AppStrings.specifications,
              style: AppTextStyles.bold20,
            ),
          ),
          SizedBox(height: MyResponsive.height(value: 20)),
          // Engine & Performance Section
          _buildSection(AppStrings.engineAndPerformance, [
            _buildSpecRow(AppStrings.enginePower, car.specs.horsepower),
            _buildSpecRow(AppStrings.torque, car.specs.torque),
            _buildSpecRow(AppStrings.engineCapacity, car.specs.engineCapacity),
            _buildSpecRow(AppStrings.cylinders, car.specs.cylinders),
            _buildSpecRow(AppStrings.turbo, car.specs.turbo),
            _buildSpecRow(AppStrings.acceleration, car.specs.acceleration),
            _buildSpecRow(AppStrings.maxSpeed, car.specs.maxSpeed),
            _buildSpecRow(AppStrings.fuelType, car.specs.fuelType),
            _buildSpecRow(AppStrings.fuelTypeGrade, car.specs.fuelTypeGrade),
            _buildSpecRow(
                AppStrings.fuelConsumption, car.specs.fuelConsumption),
            _buildSpecRow(
                AppStrings.fuelTankCapacity, car.specs.fuelTankCapacity),
          ]),
          SizedBox(height: MyResponsive.height(value: 30)),
          // Transmission Section
          _buildSection(AppStrings.transmissionSection, [
            _buildSpecRow(AppStrings.transmissionType, car.specs.transmission),
            _buildSpecRow(AppStrings.gears, car.specs.gears),
            _buildSpecRow(AppStrings.driveType, car.specs.driveType),
          ]),
          SizedBox(height: MyResponsive.height(value: 30)),
          // Dimensions Section
          _buildSection(AppStrings.dimensionsAndSpaces, [
            _buildSpecRow(AppStrings.bodyType, car.specs.bodyType),
            _buildSpecRow(AppStrings.seats, car.specs.seats),
            _buildSpecRow(AppStrings.length, car.specs.length),
            _buildSpecRow(AppStrings.width, car.specs.width),
            _buildSpecRow(AppStrings.height, car.specs.height),
            _buildSpecRow(AppStrings.wheelbase, car.specs.wheelbase),
            _buildSpecRow(
                AppStrings.groundClearance, car.specs.groundClearance),
            _buildSpecRow(AppStrings.trunkCapacity, car.specs.trunkCapacity),
          ]),
          SizedBox(height: MyResponsive.height(value: 30)),
          // Origin & Warranty Section
          _buildSection(AppStrings.originAndWarranty, [
            _buildSpecRow(AppStrings.originCountry, car.specs.originCountry),
            _buildSpecRow(
                AppStrings.assemblyCountry, car.specs.assemblyCountry),
            _buildSpecRow(AppStrings.warrantyYears, car.specs.warrantyYears),
            _buildSpecRow(AppStrings.warrantyKm, car.specs.warrantyKm),
          ]),
          if (car.specs.batteryCapacity != null ||
              car.specs.batteryRange != null) ...[
            SizedBox(height: MyResponsive.height(value: 30)),
            // Electric Section
            _buildSection(AppStrings.electricSystem, [
              _buildSpecRow(
                  AppStrings.batteryCapacity, car.specs.batteryCapacity),
              _buildSpecRow(AppStrings.batteryRange, car.specs.batteryRange),
            ]),
          ],
        ],
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> specs) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.bold18.copyWith(color: AppColors.white),
        ),
        SizedBox(height: MyResponsive.height(value: 12)),
        ...specs,
      ],
    );
  }

  Widget _buildSpecRow(String title, String? value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: MyResponsive.height(value: 12)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: MyResponsive.width(value: 8),
                color: AppColors.primary,
              ),
              SizedBox(width: MyResponsive.width(value: 8)),
              Text(
                title,
                style: AppTextStyles.regular14.copyWith(
                  color: AppColors.gray,
                ),
              ),
            ],
          ),
          Text(
            value ?? AppStrings.unknown,
            style: AppTextStyles.semiBold14.copyWith(
              color: AppColors.white,
            ),
          ),
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
      padding: EdgeInsets.all(MyResponsive.width(value: 8)),
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
            style: AppTextStyles.semiBold17,
          ),
        ],
      ),
    );
  }
}
