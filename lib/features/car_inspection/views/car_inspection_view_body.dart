import 'package:dalilak_app/features/car_inspection/data/models/inspection_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/helper/my_responsive.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_text_styles.dart';
import '../../../core/utils/app_strings.dart';
import '../../chat_history/views/widgets/history_app_bar.dart';
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

        return Column(
          children: [
            // الجزء الثابت (العنوان + الوصف + عنوان القائمة)
            Padding(
              padding: MyResponsive.paddingSymmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MyResponsive.height(value: 120)),
                  const HistoryAppBar(title: AppStrings.carInspectionTitle),
                  SizedBox(height: MyResponsive.height(value: 30)),

                  // وصف الصفحة
                  Container(
                    padding: MyResponsive.paddingAll(value: 16),
                    decoration: BoxDecoration(
                      color: AppColors.appFill,
                      borderRadius:
                          BorderRadius.circular(MyResponsive.radius(value: 15)),
                      border:
                          Border.all(color: AppColors.primary.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          color: AppColors.lightGreen,
                          size: MyResponsive.fontSize(value: 24),
                        ),
                        SizedBox(width: MyResponsive.width(value: 12)),
                        Expanded(
                          child: Text(
                            AppStrings.carInspectionDescription,
                            style: AppTextStyles.regular14
                                .copyWith(color: Colors.white70),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 25)),

                  // عنوان القائمة
                  Text(
                    AppStrings.inspectionItemsTitle,
                    style: AppTextStyles.semiBold20,
                  ),
                  SizedBox(height: MyResponsive.height(value: 15)),
                ],
              ),
            ),

            // المحتوى القابل للتمرير (قائمة البنود + النتيجة)
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: MyResponsive.paddingSymmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // قائمة بنود الفحص
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
                          children: List.generate(
                            inspectionItems.length,
                            (index) {
                              final item = inspectionItems[index];
                              return InspectionItemTile(
                                title: item.title,
                                hint: item.hint,
                                isChecked: item.isChecked,
                                onChanged: (value) {
                                  cubit.toggleItem(index);
                                },
                              );
                            },
                          ),
                        ),
                      ),

                      SizedBox(height: MyResponsive.height(value: 30)),

                      // كارت النتيجة
                      InspectionResultCard(
                        percentage: percentage,
                        checkedCount: checkedCount,
                        totalCount: totalCount,
                      ),

                      SizedBox(height: MyResponsive.height(value: 20)),

                      // ملاحظة
                      Center(
                        child: Text(
                          AppStrings.inspectionDisclaimer,
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
