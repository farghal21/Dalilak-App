import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_strings.dart';
import '../../manager/trip_cost_cubit.dart';
import '../../manager/trip_cost_state.dart';
import 'cost_result_card.dart';
import 'fuel_type_selector.dart';
import 'trip_cost_input_field.dart';

class TripCostViewBody extends StatelessWidget {
  const TripCostViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCostCubit, TripCostState>(
      builder: (context, state) {
        final cubit = context.read<TripCostCubit>();

        // القيم الافتراضية
        String distance = '';
        String consumption = '8.5';
        String fuelPrice = '13.75';
        int selectedFuelType = 92;
        double totalCost = 0.0;
        double litersNeeded = 0.0;

        // تحديث القيم من الحالة
        if (state is TripCostUpdated) {
          distance = state.distance;
          consumption = state.consumption;
          fuelPrice = state.fuelPrice;
          selectedFuelType = state.selectedFuelType;
          totalCost = state.totalCost;
          litersNeeded = state.litersNeeded;
        }

        return SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // 1. Result Card at Top
                CostResultCard(
                  totalCost: totalCost,
                  litersNeeded: litersNeeded,
                  fuelPrice: fuelPrice,
                ),

                const SizedBox(height: 24),

                // 2. Distance Input Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A0F2E),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF2D1B4E),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.directions_car,
                            color: AppColors.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "مسافة الرحلة",
                            style: AppTextStyles.semiBold16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TripCostInputField(
                        label: '',
                        hint: 'أدخل المسافة بالكيلومتر',
                        icon: Icons.route,
                        initialValue: distance,
                        onChanged: cubit.updateDistance,
                        isNumber: true,
                      ),
                      const SizedBox(height: 12),
                      // Slider
                      SliderTheme(
                        data: SliderTheme.of(context).copyWith(
                          activeTrackColor: AppColors.primary,
                          inactiveTrackColor:
                              AppColors.primary.withOpacity(0.2),
                          thumbColor: AppColors.primary,
                          overlayColor: AppColors.primary.withOpacity(0.1),
                          trackHeight: 4.0,
                          thumbShape: const RoundSliderThumbShape(
                              enabledThumbRadius: 10.0),
                        ),
                        child: Slider(
                          value: (double.tryParse(distance) ?? 0.0)
                              .clamp(0.0, 1000.0),
                          min: 0.0,
                          max: 1000.0,
                          divisions: 100,
                          label: (double.tryParse(distance) ?? 0.0)
                              .toStringAsFixed(0),
                          onChanged: (value) {
                            cubit.updateDistance(value.toStringAsFixed(0));
                          },
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "0 كم",
                            style: AppTextStyles.regular11.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            "1000 كم",
                            style: AppTextStyles.regular11.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // 3. Fuel Configuration Section
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A0F2E),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFF2D1B4E),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.settings,
                            color: AppColors.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "إعدادات السيارة والوقود",
                            style: AppTextStyles.semiBold16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      TripCostInputField(
                        label: AppStrings.consumptionLabel,
                        hint: AppStrings.consumptionHint,
                        icon: Icons.local_gas_station,
                        initialValue: consumption,
                        onChanged: cubit.updateConsumption,
                        isNumber: true,
                      ),
                      const SizedBox(height: 16),
                      TripCostInputField(
                        label: AppStrings.fuelPriceLabel,
                        hint: AppStrings.fuelPriceHint,
                        icon: Icons.payments,
                        initialValue: fuelPrice,
                        onChanged: cubit.updateFuelPrice,
                        isNumber: true,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "نوع البنزين",
                        style: AppTextStyles.regular14.copyWith(
                          color: Colors.grey[400],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: FuelTypeSelector(
                              type: 92,
                              price: "13.75",
                              isSelected: selectedFuelType == 92,
                              onTap: () => cubit.selectFuelType(92, "13.75"),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: FuelTypeSelector(
                              type: 95,
                              price: "15.00",
                              isSelected: selectedFuelType == 95,
                              onTap: () => cubit.selectFuelType(95, "15.00"),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        );
      },
    );
  }
}
