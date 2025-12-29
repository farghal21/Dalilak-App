import 'package:dalilak_app/features/chat_history/views/widgets/history_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/my_responsive.dart';
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

        return Column(
          children: [
            // العنوان الثابت
            Padding(
              padding: MyResponsive.paddingSymmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MyResponsive.height(value: 120)),
                  const HistoryAppBar(title: AppStrings.tripCostTitle),
                  SizedBox(height: MyResponsive.height(value: 30)),
                ],
              ),
            ),

            // المحتوى القابل للتمرير
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: MyResponsive.paddingSymmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: MyResponsive.paddingAll(value: 20),
                        decoration: BoxDecoration(
                          color: AppColors.appFill,
                          borderRadius: BorderRadius.circular(
                              MyResponsive.radius(value: 20)),
                          border: Border.all(
                              color: AppColors.primary.withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TripCostInputField(
                              label: AppStrings.distanceLabel,
                              hint: AppStrings.distanceHint,
                              icon: Icons.add_road,
                              initialValue: distance,
                              onChanged: cubit.updateDistance,
                            ),
                            SizedBox(height: MyResponsive.height(value: 20)),
                            TripCostInputField(
                              label: AppStrings.consumptionLabel,
                              hint: AppStrings.consumptionHint,
                              icon: Icons.local_gas_station_outlined,
                              initialValue: consumption,
                              onChanged: cubit.updateConsumption,
                            ),
                            SizedBox(height: MyResponsive.height(value: 20)),
                            TripCostInputField(
                              label: AppStrings.fuelPriceLabel,
                              hint: AppStrings.fuelPriceHint,
                              icon: Icons.payments_outlined,
                              initialValue: fuelPrice,
                              onChanged: cubit.updateFuelPrice,
                            ),
                            SizedBox(height: MyResponsive.height(value: 25)),
                            Text(
                              AppStrings.fuelPriceNote,
                              style: AppTextStyles.regular11
                                  .copyWith(color: AppColors.gray),
                            ),
                            SizedBox(height: MyResponsive.height(value: 10)),
                            Row(
                              children: [
                                FuelTypeSelector(
                                  type: 92,
                                  price: "13.75",
                                  isSelected: selectedFuelType == 92,
                                  onTap: () =>
                                      cubit.selectFuelType(92, "13.75"),
                                ),
                                SizedBox(width: MyResponsive.width(value: 15)),
                                FuelTypeSelector(
                                  type: 95,
                                  price: "15.00",
                                  isSelected: selectedFuelType == 95,
                                  onTap: () =>
                                      cubit.selectFuelType(95, "15.00"),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: MyResponsive.height(value: 30)),
                      CostResultCard(
                        totalCost: totalCost,
                        litersNeeded: litersNeeded,
                        fuelPrice: fuelPrice,
                      ),
                      SizedBox(height: MyResponsive.height(value: 20)),
                      Center(
                        child: Text(
                          AppStrings.calcNote,
                          style: AppTextStyles.regular11
                              .copyWith(color: AppColors.gray),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(height: MyResponsive.height(value: 40)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
