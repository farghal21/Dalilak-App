import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/custom_button.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
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

class CompareViewBody extends StatefulWidget {
  const CompareViewBody({super.key});

  @override
  State<CompareViewBody> createState() => _CompareViewBodyState();
}

class _CompareViewBodyState extends State<CompareViewBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  final Map<int, bool> _expandedSections = {};

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit.get(context);

    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A0F2E),
            Color(0xFF120A20),
          ],
        ),
      ),
      child: SafeArea(
        child: BlocBuilder<CompareCubit, CompareState>(
          builder: (context, state) {
            final cubit = context.read<CompareCubit>();
            final cars = cubit.comparedCars;

            if (cars.isEmpty) {
              return const _EmptyState(
                  text: 'اختار عربيتين عشان تبدأ المقارنة');
            }

            if (cars.length == 1) {
              return const _EmptyState(text: 'اختار عربية تانية للمقارنة');
            }

            final leftCar = cars[0];
            final rightCar = cars[1];

            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: MyResponsive.paddingSymmetric(horizontal: 20),
                      child: Column(
                        children: [
                          SizedBox(height: MyResponsive.height(value: 20)),
                          _buildAnimatedSection(
                            index: 0,
                            child: Container(
                              decoration:
                                  _buildPremiumDecoration(isHeader: true),
                              padding: const EdgeInsets.all(8),
                              child: CompareHeaderCard(
                                leftCar: leftCar,
                                rightCar: rightCar,
                                onRemoveLeft: () =>
                                    cubit.removeCar(leftCar, userCubit),
                                onRemoveRight: () =>
                                    cubit.removeCar(rightCar, userCubit),
                              ),
                            ),
                          ),
                          SizedBox(height: MyResponsive.height(value: 24)),
                          _buildSectionWrapper(
                            index: 1,
                            title: 'المحرك والأداء',
                            icon: Icons.speed_rounded,
                            specs: [
                              _buildRow('قوة المحرك', leftCar, rightCar,
                                  (s) => s.horsepower),
                              _buildRow(
                                  'العزم', leftCar, rightCar, (s) => s.torque),
                              _buildRow('السعة اللترية', leftCar, rightCar,
                                  (s) => s.engineCapacity),
                              _buildRow('السلندرات', leftCar, rightCar,
                                  (s) => s.cylinders),
                              _buildRow(
                                  'تيربو', leftCar, rightCar, (s) => s.turbo),
                              _buildRow('التسارع', leftCar, rightCar,
                                  (s) => s.acceleration),
                              _buildRow('السرعة القصوى', leftCar, rightCar,
                                  (s) => s.maxSpeed),
                              _buildRow('نوع الوقود', leftCar, rightCar,
                                  (s) => s.fuelType),
                              _buildRow('استهلاك الوقود', leftCar, rightCar,
                                  (s) => s.fuelConsumption),
                              _buildRow('سعة الخزان', leftCar, rightCar,
                                  (s) => s.fuelTankCapacity),
                            ],
                          ),
                          _buildSectionWrapper(
                            index: 2,
                            title: 'ناقل الحركة',
                            icon: Icons.settings_applications_rounded,
                            specs: [
                              _buildRow('نوع الناقل', leftCar, rightCar,
                                  (s) => s.transmission),
                              _buildRow('عدد النقلات', leftCar, rightCar,
                                  (s) => s.gears),
                              _buildRow('نظام الدفع', leftCar, rightCar,
                                  (s) => s.driveType),
                            ],
                          ),
                          _buildSectionWrapper(
                            index: 3,
                            title: 'الأبعاد والمساحات',
                            icon: Icons.aspect_ratio_rounded,
                            specs: [
                              _buildRow('نمط الهيكل', leftCar, rightCar,
                                  (s) => s.bodyType),
                              _buildRow('عدد المقاعد', leftCar, rightCar,
                                  (s) => s.seats),
                              _buildRow(
                                  'الطول', leftCar, rightCar, (s) => s.length),
                              _buildRow(
                                  'العرض', leftCar, rightCar, (s) => s.width),
                              _buildRow('الارتفاع', leftCar, rightCar,
                                  (s) => s.height),
                              _buildRow('قاعدة العجلات', leftCar, rightCar,
                                  (s) => s.wheelbase),
                              _buildRow('الخلوص الأرضي', leftCar, rightCar,
                                  (s) => s.groundClearance),
                              _buildRow('سعة الشنطة', leftCar, rightCar,
                                  (s) => s.trunkCapacity),
                            ],
                          ),
                          _buildSectionWrapper(
                            index: 4,
                            title: 'المنشأ والضمان',
                            icon: Icons.public_rounded,
                            specs: [
                              _buildRow('بلد المنشأ', leftCar, rightCar,
                                  (s) => s.originCountry),
                              _buildRow('بلد التجميع', leftCar, rightCar,
                                  (s) => s.assemblyCountry),
                              _buildRow('سنوات الضمان', leftCar, rightCar,
                                  (s) => s.warrantyYears),
                              _buildRow('كيلومترات الضمان', leftCar, rightCar,
                                  (s) => s.warrantyKm),
                            ],
                          ),
                          if (leftCar.specs.batteryCapacity != null ||
                              rightCar.specs.batteryCapacity != null)
                            _buildSectionWrapper(
                              index: 5,
                              title: 'المنظومة الكهربائية',
                              icon: Icons.battery_charging_full_rounded,
                              specs: [
                                _buildRow('سعة البطارية', leftCar, rightCar,
                                    (s) => s.batteryCapacity),
                                _buildRow('المدى الكهربائي', leftCar, rightCar,
                                    (s) => s.batteryRange),
                              ],
                            ),
                          SizedBox(height: MyResponsive.height(value: 30)),
                          _buildAnimatedSection(
                            index: 6,
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.2),
                                    blurRadius: 20,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: CustomButton(
                                title: 'مسح المقارنة',
                                onPressed: () => cubit.clear(userCubit),
                                backgroundColor: const Color(0xFFCF2A2A),
                              ),
                            ),
                          ),
                          SizedBox(height: MyResponsive.height(value: 50)),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildSectionWrapper({
    required int index,
    required String title,
    required IconData icon,
    required List<SpecRow> specs,
  }) {
    final isExpanded = _expandedSections[index] ?? false;

    return Column(
      children: [
        _buildAnimatedSection(
          index: index,
          child: GestureDetector(
            onTap: () {
              setState(() {
                _expandedSections[index] = !isExpanded;
              });
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: _buildPremiumDecoration(),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.primary.withOpacity(0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(icon, color: AppColors.primary, size: 20),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.semiBold16.copyWith(
                              color: Colors.white,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ),
                        AnimatedRotation(
                          turns: isExpanded ? 0.5 : 0,
                          duration: const Duration(milliseconds: 300),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: isExpanded ? AppColors.primary : Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AnimatedCrossFade(
                    firstChild: const SizedBox.shrink(),
                    secondChild: Column(
                      children: [
                        Divider(
                          color: Colors.white.withOpacity(0.1),
                          thickness: 1,
                          height: 1,
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 16, left: 16, right: 16),
                          child: SpecsSection(
                            specs: specs,
                          ),
                        ),
                      ],
                    ),
                    crossFadeState: isExpanded
                        ? CrossFadeState.showSecond
                        : CrossFadeState.showFirst,
                    duration: const Duration(milliseconds: 300),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedSection({required int index, required Widget child}) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double start = (index * 0.1).clamp(0.0, 1.0);
        final double end = (start + 0.5).clamp(0.0, 1.0);
        final double animationValue = _animationController.value;
        final double progress =
            ((animationValue - start) / (end - start)).clamp(0.0, 1.0);

        return Opacity(
          opacity: progress.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - progress)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  BoxDecoration _buildPremiumDecoration({bool isHeader = false}) {
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          const Color(0xFF251640),
          const Color(0xFF1A0F2E),
        ],
      ),
      borderRadius: BorderRadius.circular(16),
      border: Border.all(
        color: AppColors.primary.withOpacity(0.3),
        width: 1,
      ),
      boxShadow: [
        BoxShadow(
          color: isHeader
              ? AppColors.primary.withOpacity(0.15)
              : Colors.black.withOpacity(0.2),
          blurRadius: isHeader ? 20 : 10,
          offset: const Offset(0, 4),
          spreadRadius: 0,
        ),
      ],
    );
  }

  SpecRow _buildRow(String title, CarModel left, CarModel right,
      String? Function(CarSpecs) selector) {
    return SpecRow(
      title: title,
      leftValue: selector(left.specs) ?? '-',
      rightValue: selector(right.specs) ?? '-',
    );
  }
}

class _EmptyState extends StatelessWidget {
  final String text;

  const _EmptyState({required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xFF1A0F2E), Color(0xFF120A20)],
        ),
      ),
      child: SafeArea(
        child: Center(
          child: Padding(
            padding: MyResponsive.paddingSymmetric(horizontal: 40),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2D1B4E), Color(0xFF1A0F2E)],
                    ),
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: AppColors.primary.withOpacity(0.3)),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.2),
                        blurRadius: 30,
                      )
                    ],
                  ),
                  child: Icon(
                    Icons.compare_arrows_rounded,
                    size: MyResponsive.fontSize(value: 80),
                    color: AppColors.primary,
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 30)),
                Text(
                  text,
                  style: AppTextStyles.bold20.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: MyResponsive.height(value: 12)),
                Text(
                  'اضغط على أيقونة المقارنة بجانب أي سيارة لإضافتها',
                  style: AppTextStyles.regular14.copyWith(
                    color: Colors.grey[400],
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
