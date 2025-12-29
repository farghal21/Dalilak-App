import 'package:dalilak_app/core/helper/my_snackbar.dart';
import 'package:dalilak_app/core/shared_widgets/custom_error_widget.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_cubit.dart';
import 'package:dalilak_app/features/chat_history/manager/history_cubit/history_state.dart';
import 'package:dalilak_app/features/chat_history/views/widgets/history_list_view_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';

class HistoryListView extends StatelessWidget {
  const HistoryListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HistoryCubit, HistoryState>(
      listener: (context, state) {
        if (state is HistoryAction) {
          MySnackbar.success(context, state.message);
        } else if (state is HistoryError) {
          MySnackbar.error(context, state.error);
        }
      },
      builder: (context, state) {
        if (state is HistoryError) {
          return CustomErrorWidget(errorMessage: state.error);
        } else if (state is HistoryLoadSuccess) {
          // Empty state with Lottie animation
          if (state.history.isEmpty) {
            return _buildEmptyState(context);
          }

          // List with staggered animation
          return AnimationLimiter(
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: state.history.length,
              itemBuilder: (context, index) {
                final item = state.history[index];
                return AnimationConfiguration.staggeredList(
                  position: index,
                  duration: const Duration(milliseconds: 375),
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: HistoryListViewItem(
                        item: item,
                      ),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, state) =>
                  SizedBox(height: MyResponsive.height(value: 16)),
            ),
          );
        } else {
          // Shimmer loading effect
          return _buildShimmerLoading();
        }
      },
    );
  }

  Widget _buildShimmerLoading() {
    return ListView.separated(
      padding: EdgeInsets.zero,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Shimmer.fromColors(
          baseColor: AppColors.appFill,
          highlightColor: AppColors.primary.withOpacity(0.1),
          child: Container(
            height: MyResponsive.height(value: 100),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(
                MyResponsive.radius(value: 20),
              ),
            ),
          ),
        );
      },
      separatorBuilder: (context, index) =>
          SizedBox(height: MyResponsive.height(value: 16)),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: MyResponsive.paddingSymmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: MyResponsive.fontSize(value: 120),
              color: AppColors.gray.withOpacity(0.3),
            ),
            SizedBox(height: MyResponsive.height(value: 20)),
            Text(
              'لا توجد محادثات سابقة',
              style: TextStyle(
                fontSize: MyResponsive.fontSize(value: 20),
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: MyResponsive.height(value: 8)),
            Text(
              'ابدأ محادثة جديدة لتظهر هنا',
              style: TextStyle(
                fontSize: MyResponsive.fontSize(value: 14),
                color: AppColors.gray,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
