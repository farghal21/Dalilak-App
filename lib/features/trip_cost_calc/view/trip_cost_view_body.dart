import 'package:dalilak_app/features/chat_history/views/widgets/history_app_bar.dart';
import 'package:flutter/material.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../../core/utils/app_strings.dart';

class TripCostViewBody extends StatefulWidget {
  final double? initialConsumption;

  const TripCostViewBody({super.key, this.initialConsumption});

  @override
  State<TripCostViewBody> createState() => _TripCostViewBodyState();
}

class _TripCostViewBodyState extends State<TripCostViewBody> {
  late TextEditingController distanceController;
  late TextEditingController consumptionController;
  late TextEditingController priceController;

  int selectedFuelType = 92;
  double totalCost = 0.0;
  double litersNeeded = 0.0;

  @override
  void initState() {
    super.initState();
    distanceController = TextEditingController();
    consumptionController = TextEditingController(
        text: widget.initialConsumption?.toString() ?? '8.5');
    priceController = TextEditingController(text: '13.75');
    _calculate();
  }

  @override
  void dispose() {
    distanceController.dispose();
    consumptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _calculate() {
    if (!mounted) return;

    setState(() {
      double distance = double.tryParse(distanceController.text) ?? 0.0;
      double consumption = double.tryParse(consumptionController.text) ?? 0.0;
      double price = double.tryParse(priceController.text) ?? 0.0;

      litersNeeded = (distance / 100) * consumption;
      totalCost = litersNeeded * price;
    });
  }

  @override
  Widget build(BuildContext context) {
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
                      borderRadius:
                          BorderRadius.circular(MyResponsive.radius(value: 20)),
                      border:
                          Border.all(color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildCustomTextField(
                          label: AppStrings.distanceLabel,
                          hint: AppStrings.distanceHint,
                          icon: Icons.add_road,
                          controller: distanceController,
                        ),
                        SizedBox(height: MyResponsive.height(value: 20)),
                        _buildCustomTextField(
                          label: AppStrings.consumptionLabel,
                          hint: AppStrings.consumptionHint,
                          icon: Icons.local_gas_station_outlined,
                          controller: consumptionController,
                        ),
                        SizedBox(height: MyResponsive.height(value: 20)),
                        _buildCustomTextField(
                          label: AppStrings.fuelPriceLabel,
                          hint: AppStrings.fuelPriceHint,
                          icon: Icons.payments_outlined,
                          controller: priceController,
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
                            _buildFuelOption(92, "13.75"),
                            SizedBox(width: MyResponsive.width(value: 15)),
                            _buildFuelOption(95, "15.00"),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 30)),
                  Container(
                    padding: MyResponsive.paddingAll(value: 25),
                    decoration: BoxDecoration(
                      gradient: AppColors.cardGradient,
                      borderRadius:
                          BorderRadius.circular(MyResponsive.radius(value: 25)),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border:
                          Border.all(color: AppColors.primary.withOpacity(0.5)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          AppStrings.expectedCost,
                          style: AppTextStyles.regular14
                              .copyWith(color: Colors.white70),
                        ),
                        SizedBox(height: MyResponsive.height(value: 15)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.baseline,
                          textBaseline: TextBaseline.alphabetic,
                          children: [
                            Text(
                              totalCost.toStringAsFixed(0),
                              style: AppTextStyles.bold20.copyWith(
                                color: Colors.white,
                                fontSize: MyResponsive.fontSize(value: 48),
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: MyResponsive.width(value: 8)),
                            Text(
                              AppStrings.currency,
                              style: AppTextStyles.semiBold20
                                  .copyWith(color: AppColors.lightGreen),
                            ),
                          ],
                        ),
                        Divider(
                            color: Colors.white12,
                            height: MyResponsive.height(value: 40)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildResultItem(AppStrings.litersNeeded,
                                "${litersNeeded.toStringAsFixed(1)} لتر"),
                            _buildResultItem(AppStrings.fuelPriceApplied,
                                "${priceController.text} ج.م"),
                          ],
                        ),
                      ],
                    ),
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
  }

  Widget _buildCustomTextField({
    required String label,
    required String hint,
    required IconData icon,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: AppTextStyles.regular14.copyWith(color: Colors.white70)),
        SizedBox(height: MyResponsive.height(value: 8)),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onChanged: (val) => _calculate(),
          style: AppTextStyles.semiBold16.copyWith(color: AppColors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: AppTextStyles.regular14.copyWith(color: Colors.white30),
            suffixIcon: Icon(icon, color: AppColors.secondary, size: 22),
            filled: true,
            fillColor: AppColors.black.withOpacity(0.3),
            contentPadding:
                MyResponsive.paddingSymmetric(vertical: 16, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 12)),
              borderSide: BorderSide(color: AppColors.gray.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 12)),
              borderSide: BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildFuelOption(int type, String price) {
    bool isSelected = selectedFuelType == type;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            selectedFuelType = type;
            priceController.text = price;
          });
          _calculate();
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: MyResponsive.paddingSymmetric(vertical: 12),
          decoration: BoxDecoration(
            gradient: isSelected ? AppColors.horizontalGradient : null,
            color: isSelected ? null : AppColors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(MyResponsive.radius(value: 12)),
            border: isSelected
                ? null
                : Border.all(color: AppColors.gray.withOpacity(0.3)),
          ),
          child: Center(
            child: Text(
              "بنزين $type",
              style: AppTextStyles.semiBold16.copyWith(
                color: isSelected ? AppColors.white : AppColors.gray,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResultItem(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyles.regular11.copyWith(color: Colors.white60)),
        SizedBox(height: MyResponsive.height(value: 6)),
        Text(value,
            style: AppTextStyles.bold16.copyWith(color: AppColors.white)),
      ],
    );
  }
}
