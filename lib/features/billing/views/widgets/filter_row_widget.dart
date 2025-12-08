import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/billing_cubit/billing_cubit.dart';
import '../../manager/billing_cubit/billing_state.dart';

class FilterRowWidget extends StatelessWidget {
  const FilterRowWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BillingCubit, BillingState>(
      builder: (context, state) {
        final cubit = BillingCubit.get(context);
        return Column(
          children: [
            Row(
              children: [
                // FILTER BUTTON
                InkWell(
                  key: cubit.filterButtonKey,
                  onTap: () => _showFilterOverlay(context),
                  borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 8)),
                  child: Container(
                    padding: MyResponsive.paddingSymmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: cubit.isFilterExpanded
                          ? AppColors.primary
                          : AppColors.appFill,
                      borderRadius:
                      BorderRadius.circular(MyResponsive.radius(value: 8)),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: .1),
                        width: MyResponsive.width(value: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.filter_alt_outlined),
                        SizedBox(width: MyResponsive.width(value: 6)),
                        Text(AppStrings.filter,
                            style: AppTextStyles.semiBold19),
                        SizedBox(width: MyResponsive.width(value: 4)),
                        Visibility(
                          visible: cubit.selectedFilters.isNotEmpty,
                          maintainSize: true,
                          maintainAnimation: true,
                          maintainState: true,
                          child: Container(
                            padding: MyResponsive.paddingAll(value: 3),
                            decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: .3),
                              shape: BoxShape.circle,
                            ),
                            child: Text('${cubit.selectedFilters.length}',
                                style: AppTextStyles.semiBold17),
                          ),
                        ),
                        SizedBox(width: MyResponsive.width(value: 4)),
                        Icon(cubit.isFilterExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: MyResponsive.width(value: 16)),
                // SORT BUTTON
                InkWell(
                  key: cubit.sortButtonKey,
                  onTap: () => _showSortOverlay(context),
                  borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 8)),
                  child: Container(
                    padding: MyResponsive.paddingSymmetric(
                        horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: cubit.isSortExpanded
                          ? AppColors.primary
                          : AppColors.appFill,
                      borderRadius:
                      BorderRadius.circular(MyResponsive.radius(value: 8)),
                      border: Border.all(
                        color: AppColors.white.withValues(alpha: .1),
                        width: MyResponsive.width(value: 1),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(cubit.selectedSort,
                            style: AppTextStyles.semiBold19),
                        SizedBox(width: MyResponsive.width(value: 6)),
                        Icon(cubit.isSortExpanded
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (cubit.selectedFilters.isNotEmpty && !cubit.isFilterExpanded)
              Container(
                margin: MyResponsive.paddingOnly(top: 20),
                width: double.infinity,
                child: Wrap(
                  spacing: MyResponsive.width(value: 8),
                  runSpacing: MyResponsive.height(value: 8),
                  children: cubit.selectedFilters
                      .map((filter) => _buildSelectedChip(context, filter))
                      .toList(),
                ),
              ),
          ],
        );
      },
    );
  }

  void _showFilterOverlay(BuildContext context) {
    final cubit = BillingCubit.get(context);

    final renderBox =
    cubit.filterButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final overlayWidget = BlocBuilder<BillingCubit, BillingState>(
      bloc: cubit,
      builder: (context, state) {
        return GestureDetector(
          onTap: cubit.removeOverlay,
          behavior: HitTestBehavior.translucent,
          child: Stack(
            children: [
              Positioned.fill(child: Container(color: Colors.transparent)),
              Positioned(
                left: MyResponsive.width(value: 20),
                right: MyResponsive.width(value: 20),
                top: offset.dy + size.height + MyResponsive.height(value: 10),
                child: GestureDetector(
                  onTap: () {},
                  child: Material(
                    color: Colors.transparent,
                    child: Container(
                      padding: MyResponsive.paddingSymmetric(
                          horizontal: 7, vertical: 30),
                      decoration: BoxDecoration(
                        color: AppColors.appFill,
                        borderRadius: BorderRadius.circular(
                            MyResponsive.radius(value: 8)),
                        border: Border.all(
                          color: AppColors.white.withValues(alpha: .1),
                          width: MyResponsive.width(value: 1),
                        ),
                      ),
                      child: Wrap(
                        spacing: MyResponsive.width(value: 8),
                        runSpacing: MyResponsive.height(value: 8),
                        children: cubit.filterOptions.map((filter) {
                          final isSelected =
                          cubit.selectedFilters.contains(filter);
                          return _buildFilterOption(
                            cubit,
                            filter,
                            isSelected,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );

    cubit.showFilterOverlay(context, overlayWidget);
  }

  void _showSortOverlay(BuildContext context) {
    final cubit = BillingCubit.get(context);

    final renderBox =
    cubit.sortButtonKey.currentContext?.findRenderObject() as RenderBox?;
    if (renderBox == null) return;

    final offset = renderBox.localToGlobal(Offset.zero);
    final size = renderBox.size;

    final overlayWidget = GestureDetector(
      onTap: cubit.removeOverlay,
      behavior: HitTestBehavior.translucent,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: Colors.transparent)),
          Positioned(
            left: MyResponsive.width(value: 20),
            right: MyResponsive.width(value: 20),
            top: offset.dy + size.height + MyResponsive.height(value: 10),
            child: GestureDetector(
              onTap: () {},
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: MyResponsive.paddingSymmetric(
                      horizontal: 7, vertical: 30),
                  decoration: BoxDecoration(
                    color: AppColors.appFill,
                    borderRadius:
                    BorderRadius.circular(MyResponsive.radius(value: 8)),
                    border: Border.all(
                      color: AppColors.white.withValues(alpha: .1),
                      width: MyResponsive.width(value: 1),
                    ),
                  ),
                  child: Wrap(
                    spacing: MyResponsive.width(value: 8),
                    runSpacing: MyResponsive.height(value: 8),
                    children: cubit.sortOptions.map((option) {
                      final isSelected = cubit.selectedSort == option;
                      return _buildSortOption(cubit, option, isSelected);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    cubit.showSortOverlay(context, overlayWidget);
  }

  // Pass cubit to avoid BlocProvider lookup from overlay context
  Widget _buildFilterOption(BillingCubit cubit, String label, bool isSelected) {
    return InkWell(
      onTap: () => cubit.toggleFilter(label),
      borderRadius: BorderRadius.circular(MyResponsive.radius(value: 8)),
      child: Container(
        padding: MyResponsive.paddingSymmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.white.withValues(alpha: 0.7)
                : AppColors.white.withValues(alpha: 0.1),
          ),
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 8)),
        ),
        child: Text(label, style: AppTextStyles.semiBold17),
      ),
    );
  }

  Widget _buildSortOption(BillingCubit cubit, String label, bool isSelected) {
    return InkWell(
      onTap: () => cubit.toggleSort(label),
      borderRadius: BorderRadius.circular(MyResponsive.radius(value: 8)),
      child: Container(
        width: double.infinity,
        padding: MyResponsive.paddingSymmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppColors.white.withValues(alpha: 0.7)
                : AppColors.white.withValues(alpha: 0.1),
          ),
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 8)),
        ),
        child: Text(label, style: AppTextStyles.semiBold17),
      ),
    );
  }

  Widget _buildSelectedChip(BuildContext context, String label) {
    final cubit = BillingCubit.get(context);
    return Container(
      padding: MyResponsive.paddingSymmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.fillColor,
        border: Border.all(color: AppColors.white.withValues(alpha: .1)),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 8)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => cubit.removeFilter(label),
            child: const Icon(Icons.close, size: 16),
          ),
          SizedBox(width: MyResponsive.width(value: 8)),
          Text(label, style: AppTextStyles.semiBold17),
        ],
      ),
    );
  }
}
