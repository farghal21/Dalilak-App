import 'package:dalilak_app/features/settings/views/widgets/setting_dropdown_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/public_settings_cubit/public_settings_cubit.dart';

class PublicSettingsViewBody extends StatelessWidget {
  const PublicSettingsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = PublicSettingsCubit.get(context);
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: MyResponsive.height(value: 110),
          ),
          Text(
            AppStrings.publicSettings,
            style: AppTextStyles.semiBold24,
          ),
          SizedBox(
            height: MyResponsive.height(value: 92),
          ),
          SettingDropdownWidget(
            title: AppStrings.appearance,
            selectedValue: cubit.selectedAppearance,
            items: cubit.appearanceItems,
            onChanged: (String? newValue) {
              cubit.changeAppearance(newValue!);
            },
          ),
          SizedBox(
            height: MyResponsive.height(value: 35),
          ),
          SettingDropdownWidget(
            title: AppStrings.language,
            selectedValue: cubit.selectedLanguage,
            items: cubit.languageItems,
            onChanged: (String? newValue) {
              cubit.changeLanguage(newValue!);
            },
          ),
          SizedBox(
            height: MyResponsive.height(value: 35),
          ),
          SettingDropdownWidget(
            title: AppStrings.country,
            selectedValue: cubit.selectedCountry,
            items: cubit.countryItems,
            // onChanged: (String? newValue) {
            //   cubit.changeCountry(newValue!);
            // },
            onChanged: null,
          ),
          SizedBox(
            height: MyResponsive.height(value: 35),
          ),
        ],
      ),
    );
  }
}
