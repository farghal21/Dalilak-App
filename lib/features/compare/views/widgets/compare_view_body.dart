import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/custom_button.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/compare/manager/compare_cubit.dart';
import 'package:dalilak_app/features/compare/manager/compare_state.dart';
import 'package:dalilak_app/features/compare/views/widgets/spec_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'compare_header_card.dart';
import 'spec_section.dart';

class CompareViewBody extends StatelessWidget {
  const CompareViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit.get(context);

    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: BlocBuilder<CompareCubit, CompareState>(
        builder: (context, state) {
          final cubit = context.read<CompareCubit>();
          final cars = cubit.comparedCars;

          if (cars.isEmpty) {
            return _EmptyState(
              text: 'اختار عربيتين عشان تبدأ المقارنة',
            );
          }

          if (cars.length == 1) {
            return _EmptyState(
              text: 'اختار عربية تانية للمقارنة',
            );
          }

          final leftCar = cars[0];
          final rightCar = cars[1];

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MyResponsive.height(value: 140)),

                Text(
                  AppStrings.compareCarsTitle,
                  style: AppTextStyles.bold20,
                ),

                SizedBox(height: MyResponsive.height(value: 16)),

                /// HEADER
                CompareHeaderCard(
                  leftCar: leftCar,
                  rightCar: rightCar,
                  onRemoveLeft: () => cubit.removeCar(leftCar, userCubit),
                  onRemoveRight: () => cubit.removeCar(rightCar, userCubit),
                ),

                SizedBox(height: MyResponsive.height(value: 16)),

                /// SPECS
                SpecsSection(
                  sectionTitle: 'المحرك والقوة',
                  specs: [
                    SpecRow(
                      title: 'قوة المحرك',
                      leftValue: leftCar.specs.horsepower ?? 'غير معروف',
                      rightValue: rightCar.specs.horsepower ?? 'غير معروف',
                    ),
                    SpecRow(
                      title: 'نوع الوقود',
                      leftValue: leftCar.specs.fuelType ?? 'غير معروف',
                      rightValue: rightCar.specs.fuelType ?? 'غير معروف',
                    ),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 16)),

                SpecsSection(
                  sectionTitle: 'الأداء',
                  specs: [
                    SpecRow(
                      title: 'السرعة القصوى',
                      leftValue: leftCar.specs.maxSpeed ?? 'غير معروف',
                      rightValue: rightCar.specs.maxSpeed ?? 'غير معروف',
                    ),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 30)),

                /// CLEAR BUTTON
                CustomButton(
                    title: 'مسح المقارنة',
                    onPressed: () => cubit.clear(userCubit)),

                SizedBox(height: MyResponsive.height(value: 100)),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String text;

  const _EmptyState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        text,
        style: AppTextStyles.semiBold16,
        textAlign: TextAlign.center,
      ),
    );
  }
}
