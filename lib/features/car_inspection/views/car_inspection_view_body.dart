import 'package:dalilak_app/features/car_inspection/data/models/inspection_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/utils/app_strings.dart';
import '../manager/car_inspection_cubit.dart';
import '../manager/car_inspection_state.dart';
import 'widgets/inspection_item_tile.dart';
import 'widgets/inspection_result_card.dart';

class CarInspectionViewBody extends StatelessWidget {
  const CarInspectionViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarInspectionCubit, CarInspectionState>(
      builder: (context, state) {
        final cubit = context.read<CarInspectionCubit>();

        // القيم الافتراضية
        double percentage = 0.0;
        int checkedCount = 0;
        int totalCount = 0;

        // قائمة البنود (فارغة افتراضياً)
        final inspectionItems = state is CarInspectionUpdated
            ? state.inspectionItems
            : <InspectionItem>[];

        // تحديث القيم إذا كانت الحالة محدثة
        if (state is CarInspectionUpdated) {
          percentage = state.percentage;
          checkedCount = state.checkedCount;
          totalCount = state.totalCount;
        }

        return SafeArea(
          child: Column(
            children: [
              // 1. Fixed Dashboard - Result Card Only (30% height)
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.3,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                  child: InspectionResultCard(
                    percentage: percentage,
                    checkedCount: checkedCount,
                    totalCount: totalCount,
                  ),
                ),
              ),

              // 2. Scrollable Checklist (Remaining Space)
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.all(16),
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
                      // Header - Fixed
                      Row(
                        children: [
                          Icon(
                            Icons.checklist_rtl,
                            color: AppColors.primary,
                            size: 22,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            "قائمة بنود الفحص",
                            style: AppTextStyles.bold16.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      const Divider(
                        color: Color(0xFF2D1B4E),
                        height: 1,
                      ),

                      const SizedBox(height: 12),

                      // Scrollable Items ONLY
                      Expanded(
                        child: ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          itemCount: inspectionItems.length,
                          itemBuilder: (context, index) {
                            final item = inspectionItems[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: InspectionItemTile(
                                title: item.title,
                                hint: item.hint,
                                isChecked: item.isChecked,
                                onChanged: (value) {
                                  cubit.toggleItem(index);
                                },
                              ),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Disclaimer - Fixed at bottom
                      Center(
                        child: Text(
                          AppStrings.inspectionDisclaimer,
                          style: AppTextStyles.regular11.copyWith(
                            color: Colors.white60,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }
}
