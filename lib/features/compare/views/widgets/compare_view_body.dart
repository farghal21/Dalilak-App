import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/custom_button.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/compare/manager/compare_cubit.dart';
import 'package:dalilak_app/features/compare/manager/compare_state.dart';
import 'package:dalilak_app/features/compare/views/widgets/spec_row.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
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
                  sectionTitle: 'المحرك والأداء',
                  specs: [
                    _buildRow('قوة المحرك', leftCar, rightCar,
                        (specs) => specs.horsepower),
                    _buildRow(
                        'العزم', leftCar, rightCar, (specs) => specs.torque),
                    _buildRow('السعة اللترية', leftCar, rightCar,
                        (specs) => specs.engineCapacity),
                    _buildRow('السلندرات', leftCar, rightCar,
                        (specs) => specs.cylinders),
                    _buildRow(
                        'تيربو', leftCar, rightCar, (specs) => specs.turbo),
                    _buildRow('التسارع', leftCar, rightCar,
                        (specs) => specs.acceleration),
                    _buildRow('السرعة القصوى', leftCar, rightCar,
                        (specs) => specs.maxSpeed),
                    _buildRow('نوع الوقود', leftCar, rightCar,
                        (specs) => specs.fuelType),
                    _buildRow('درجة الوقود', leftCar, rightCar,
                        (specs) => specs.fuelTypeGrade),
                    _buildRow('استهلاك الوقود', leftCar, rightCar,
                        (specs) => specs.fuelConsumption),
                    _buildRow('سعة الخزان', leftCar, rightCar,
                        (specs) => specs.fuelTankCapacity),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 16)),

                SpecsSection(
                  sectionTitle: 'ناقل الحركة',
                  specs: [
                    _buildRow('نوع الناقل', leftCar, rightCar,
                        (specs) => specs.transmission),
                    _buildRow('عدد النقلات', leftCar, rightCar,
                        (specs) => specs.gears),
                    _buildRow('نظام الدفع', leftCar, rightCar,
                        (specs) => specs.driveType),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 16)),

                SpecsSection(
                  sectionTitle: 'الأبعاد والمساحات',
                  specs: [
                    _buildRow('نمط الهيكل', leftCar, rightCar,
                        (specs) => specs.bodyType),
                    _buildRow('عدد المقاعد', leftCar, rightCar,
                        (specs) => specs.seats),
                    _buildRow(
                        'الطول', leftCar, rightCar, (specs) => specs.length),
                    _buildRow(
                        'العرض', leftCar, rightCar, (specs) => specs.width),
                    _buildRow(
                        'الارتفاع', leftCar, rightCar, (specs) => specs.height),
                    _buildRow('قاعدة العجلات', leftCar, rightCar,
                        (specs) => specs.wheelbase),
                    _buildRow('الخلوص الأرضي', leftCar, rightCar,
                        (specs) => specs.groundClearance),
                    _buildRow('سعة الشنطة', leftCar, rightCar,
                        (specs) => specs.trunkCapacity),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 16)),

                SpecsSection(
                  sectionTitle: 'المنشأ والضمان',
                  specs: [
                    _buildRow('بلد المنشأ', leftCar, rightCar,
                        (specs) => specs.originCountry),
                    _buildRow('بلد التجميع', leftCar, rightCar,
                        (specs) => specs.assemblyCountry),
                    _buildRow('سنوات الضمان', leftCar, rightCar,
                        (specs) => specs.warrantyYears),
                    _buildRow('كيلومترات الضمان', leftCar, rightCar,
                        (specs) => specs.warrantyKm),
                  ],
                ),

                if (leftCar.specs.batteryCapacity != null ||
                    rightCar.specs.batteryCapacity != null ||
                    leftCar.specs.batteryRange != null ||
                    rightCar.specs.batteryRange != null) ...[
                  SizedBox(height: MyResponsive.height(value: 16)),
                  SpecsSection(
                    sectionTitle: 'المنظومة الكهربائية',
                    specs: [
                      _buildRow('سعة البطارية', leftCar, rightCar,
                          (specs) => specs.batteryCapacity),
                      _buildRow('المدى الكهربائي', leftCar, rightCar,
                          (specs) => specs.batteryRange),
                    ],
                  ),
                ],

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

  SpecRow _buildRow(String title, CarModel left, CarModel right,
      String? Function(CarSpecs) selector) {
    return SpecRow(
      title: title,
      leftValue: selector(left.specs) ?? 'غير معروف',
      rightValue: selector(right.specs) ?? 'غير معروف',
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
