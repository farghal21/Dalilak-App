import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/compare/manager/compare_cubit.dart';
import 'package:dalilak_app/features/compare/manager/compare_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'clear_compare_button.dart';
import 'compare_empty_state.dart';
import 'compare_header_card.dart';
import 'compare_specs_list.dart';

class CompareViewBody extends StatefulWidget {
  const CompareViewBody({super.key});

  @override
  State<CompareViewBody> createState() => _CompareViewBodyState();
}

class _CompareViewBodyState extends State<CompareViewBody>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

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
              return const CompareEmptyState(
                  text: 'اختار عربيتين عشان تبدأ المقارنة');
            }

            if (cars.length == 1) {
              return const CompareEmptyState(
                  text: 'اختار عربية تانية للمقارنة');
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
                            child: CompareHeaderCard(
                              leftCar: leftCar,
                              rightCar: rightCar,
                              onRemoveLeft: () =>
                                  cubit.removeCar(leftCar, userCubit),
                              onRemoveRight: () =>
                                  cubit.removeCar(rightCar, userCubit),
                            ),
                          ),
                          SizedBox(height: MyResponsive.height(value: 24)),
                          CompareSpecsList(
                            leftCar: leftCar,
                            rightCar: rightCar,
                            animationController: _animationController,
                          ),
                          SizedBox(height: MyResponsive.height(value: 30)),
                          _buildAnimatedSection(
                            index: 6,
                            child: ClearCompareButton(
                              onPressed: () => cubit.clear(userCubit),
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
}
