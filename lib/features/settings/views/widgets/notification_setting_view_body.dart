import 'package:dalilak_app/features/settings/views/widgets/setting_dropdown_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../chat_history/views/widgets/history_app_bar.dart';
import '../../manager/notification_settings_cubit/notification_settings_cubit.dart';

class NotificationSettingViewBody extends StatelessWidget {
  const NotificationSettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = NotificationSettingsCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MyResponsive.height(value: 120)),

        // AppBar
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 20),
          child: HistoryAppBar(title: AppStrings.notifications),
        ),

        SizedBox(height: MyResponsive.height(value: 40)),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: MyResponsive.paddingSymmetric(horizontal: 20),
            child: Column(
              children: [
                _buildAnimatedItem(
                  delay: 0,
                  child: SettingDropdownWidget(
                    title: AppStrings.internalNotifications,
                    selectedValue: cubit.selectedInternalNotification,
                    items: cubit.notificationItems,
                    onChanged: (String? newValue) {
                      cubit.changeInternalNotification(newValue!);
                    },
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 20)),

                _buildAnimatedItem(
                  delay: 100,
                  child: SettingDropdownWidget(
                    title: AppStrings.externalNotifications,
                    selectedValue: cubit.selectedExternalNotification,
                    items: cubit.notificationItems,
                    onChanged: (String? newValue) {
                      cubit.changeExternalNotification(newValue!);
                    },
                  ),
                ),
                // مساحة إضافية في الأسفل
                SizedBox(height: MyResponsive.height(value: 40)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedItem({required int delay, required Widget child}) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutQuart,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
    );
  }
}
