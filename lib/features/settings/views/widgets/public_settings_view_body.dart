import 'package:dalilak_app/features/settings/views/widgets/setting_dropdown_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../chat_history/views/widgets/history_app_bar.dart';
import '../../manager/public_settings_cubit/public_settings_cubit.dart';

class PublicSettingsViewBody extends StatelessWidget {
  const PublicSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = PublicSettingsCubit.get(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: MyResponsive.height(value: 120)),

        // AppBar
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 20),
          child: HistoryAppBar(title: AppStrings.publicSettings),
        ),

        SizedBox(height: MyResponsive.height(value: 40)),

        // Scrollable Settings
        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: MyResponsive.paddingSymmetric(horizontal: 20),
            child: Column(
              children: [
                _buildAnimatedSetting(
                  delay: 0,
                  child: SettingDropdownWidget(
                    title: AppStrings.appearance,
                    selectedValue: cubit.selectedAppearance,
                    items: cubit.appearanceItems,
                    onChanged: null,
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 20)),
                _buildAnimatedSetting(
                  delay: 100,
                  child: SettingDropdownWidget(
                    title: AppStrings.language,
                    selectedValue: cubit.selectedLanguage,
                    items: cubit.languageItems,
                    onChanged: null,
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 20)),
                _buildAnimatedSetting(
                  delay: 200,
                  child: SettingDropdownWidget(
                    title: AppStrings.country,
                    selectedValue: cubit.selectedCountry,
                    items: cubit.countryItems,
                    onChanged: null,
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 40)),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnimatedSetting({
    required int delay,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
    );
  }
}
