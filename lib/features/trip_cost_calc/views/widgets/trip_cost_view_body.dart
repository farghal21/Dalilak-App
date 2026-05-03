import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_strings.dart';
import '../../manager/trip_cost_cubit.dart';
import '../../manager/trip_cost_state.dart';
import 'cost_result_card.dart';
import 'trip_cost_input_field.dart';

class TripCostViewBody extends StatelessWidget {
  const TripCostViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripCostCubit, TripCostState>(
      builder: (context, state) {
        final cubit = context.read<TripCostCubit>();

        // القيم الافتراضية
        String distance = '0';
        String consumption = '8.5';
        String fuelPrice = '13.75';
        int selectedFuelType = 92;
        double totalCost = 0.0;
        double litersNeeded = 0.0;

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
            padding: MyResponsive.paddingAll(value: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // 1. كارت النتيجة
                CostResultCard(
                  totalCost: totalCost,
                  litersNeeded: litersNeeded,
                  fuelPrice: fuelPrice,
                ),

                const SizedBox(height: 24),

                // 2. قسم المسافة (بالألوان القديمة)
                _buildSectionTitle("مسافة الرحلة", Icons.map),
                const SizedBox(height: 12),

                Container(
                  padding: MyResponsive.paddingAll(value: 20),
                  decoration:
                      _buildOldThemeDecoration(), // 👈 هنا الألوان القديمة
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("0 كم",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 11)),
                          Text(
                            "$distance كم",
                            style: AppTextStyles.bold20
                                .copyWith(color: AppColors.primary),
                          ),
                          Text("1000 كم",
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 11)),
                        ],
                      ),
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
                          onChanged: (value) {
                            cubit.updateDistance(value.toStringAsFixed(0));
                          },
                        ),
                      ),
                      const SizedBox(height: 10),
                      // خانة كتابة المسافة
                      TripCostInputField(
                        label: "",
                        hint: "أدخل المسافة يدوياً",
                        icon: Icons.edit_road,
                        initialValue: distance,
                        onChanged: cubit.updateDistance,
                        isNumber: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // 3. قسم إعدادات الوقود (بالألوان القديمة)
                _buildSectionTitle("إعدادات السيارة والوقود", Icons.settings),
                const SizedBox(height: 12),

                Container(
                  padding: MyResponsive.paddingAll(value: 20),
                  decoration:
                      _buildOldThemeDecoration(), // 👈 هنا الألوان القديمة
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- استهلاك البنزين ---
                      TripCostInputField(
                        label: AppStrings.consumptionLabel,
                        hint: "مثال: 8.5",
                        icon: Icons.local_gas_station,
                        initialValue: consumption,
                        onChanged: cubit.updateConsumption,
                        isNumber: true,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, right: 5),
                        child: Text(
                          "ℹ️ متوسط الاستهلاك: 7.5 - 9.5 لتر/100كم",
                          style:
                              TextStyle(color: Colors.grey[500], fontSize: 11),
                        ),
                      ),

                      const Divider(color: Colors.white10, height: 30),

                      // --- سعر البنزين ---
                      Text(
                        "سعر اللتر",
                        style: AppTextStyles.regular14
                            .copyWith(color: Colors.white70),
                      ),
                      const SizedBox(height: 10),

                      // أزرار الاختيار السريع (Chips)
                      Row(
                        children: [
                          _buildFuelChip(
                            label: "بنزين 92",
                            isSelected: selectedFuelType == 92,
                            onTap: () => cubit.selectFuelType(92, "13.75"),
                          ),
                          const SizedBox(width: 10),
                          _buildFuelChip(
                            label: "بنزين 95",
                            isSelected: selectedFuelType == 95,
                            onTap: () => cubit.selectFuelType(95, "15.00"),
                          ),
                        ],
                      ),

                      const SizedBox(height: 15),

                      // خانة السعر
                      TripCostInputField(
                        label: "",
                        hint: "سعر اللتر",
                        icon: Icons.attach_money,
                        initialValue: fuelPrice,
                        onChanged: cubit.updateFuelPrice,
                        isNumber: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 50),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- دوال التصميم ---

  // 1. الديكور القديم (اللون الغامق والحدود)
  BoxDecoration _buildOldThemeDecoration() {
    return BoxDecoration(
      color: const Color(0xFF1A0F2E), // الخلفية القديمة
      borderRadius: BorderRadius.circular(20),
      border: Border.all(
        color: const Color(0xFF2D1B4E), // الحدود القديمة
        width: 1,
      ),
    );
  }

  // 2. عنوان القسم
  Widget _buildSectionTitle(String title, IconData icon) {
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 20),
        const SizedBox(width: 8),
        Text(
          title,
          style: AppTextStyles.semiBold16.copyWith(color: Colors.white),
        ),
      ],
    );
  }

  // 3. تصميم الـ Chips
  Widget _buildFuelChip({
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          // لو مختار يبقى اللون الأساسي، لو لأ يبقى شفاف
          color: isSelected ? AppColors.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            // لو مختار يبقى الأساسي، لو لأ يبقى رمادي
            color:
                isSelected ? AppColors.primary : Colors.grey.withOpacity(0.5),
          ),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? Colors.white : Colors.grey,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
            ),
            if (isSelected) ...[
              const SizedBox(width: 5),
              const Icon(Icons.check, size: 14, color: Colors.white),
            ]
          ],
        ),
      ),
    );
  }
}
