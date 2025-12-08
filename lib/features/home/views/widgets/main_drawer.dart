import 'package:flutter/material.dart';

import '../../../../core/cache/cache_helper.dart';
import '../../../../core/cache/cache_key.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../auth/views/login_view.dart';
import '../../../billing/views/billing_view.dart';
import '../../../history/views/history_view.dart';
import '../../../settings/views/settings_view.dart';
import '../../../wallet/views/wallet_view.dart';
import '../home_view.dart';
import 'main_drawer_item.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key, required this.selectedIndex});

  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.black,
      child: Padding(
        padding: MyResponsive.paddingAll(value: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SvgWrapper(path: AppAssets.appBranding),
            SizedBox(height: MyResponsive.height(value: 20)),
            Image.asset(AppAssets.appBranding),

            SizedBox(height: MyResponsive.height(value: 38)),
            MainDrawerItem(
              imagePath: AppAssets.newChat,
              title: AppStrings.newChat,
              onTap: () {
                Navigator.pushNamedAndRemoveUntil(
                    context, HomeView.routeName, (route) => false);
              },
              isSelected: selectedIndex == 0,
            ),
            SizedBox(height: MyResponsive.height(value: 45)),
            MainDrawerItem(
              imagePath: AppAssets.bills,
              title: AppStrings.history,
              onTap: () {
                if (selectedIndex == 0) {
                  Navigator.pushNamed(context, BillingView.routeName);
                } else {
                  Navigator.pushReplacementNamed(
                      context, BillingView.routeName);
                }
              },
              isSelected: selectedIndex == 2,
            ),
            SizedBox(height: MyResponsive.height(value: 45)),
            MainDrawerItem(
              imagePath: AppAssets.favoriteIcon,
              title: AppStrings.favorite,
              onTap: () {
                if (selectedIndex == 0) {
                  Navigator.pushNamed(context, WalletView.routeName);
                } else {
                  Navigator.pushReplacementNamed(context, WalletView.routeName);
                }
              },
              isSelected: selectedIndex == 1,
            ),
            SizedBox(height: MyResponsive.height(value: 45)),
            MainDrawerItem(
              imagePath: AppAssets.faz3a,
              title: AppStrings.compare,
              onTap: () {
                if (selectedIndex == 0) {
                  Navigator.pushNamed(context, HistoryView.routeName);
                } else {
                  Navigator.pushReplacementNamed(
                      context, HistoryView.routeName);
                }
              },
              isSelected: selectedIndex == 3,
            ),
            SizedBox(height: MyResponsive.height(value: 45)),
            MainDrawerItem(
              imagePath: AppAssets.settings,
              title: AppStrings.settings,
              onTap: () {
                if (selectedIndex == 0) {
                  Navigator.pushNamed(context, SettingsView.routeName);
                } else {
                  Navigator.pushReplacementNamed(
                      context, SettingsView.routeName);
                }
              },
              isSelected: selectedIndex == 4,
            ),
            // Spacer(),
            MainDrawerItem(
              imagePath: AppAssets.support,
              title: AppStrings.support,
              onTap: () {
                // Navigator.pushNamed(context, routeName);
              },
              isSelected: false,
            ),
            SizedBox(height: MyResponsive.height(value: 18)),
            Spacer(),
            Container(
              padding:
                  MyResponsive.paddingSymmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.fillColor,
                borderRadius:
                    BorderRadius.circular(MyResponsive.radius(value: 15)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      AppStrings.userName,
                      style: AppTextStyles.bold20,
                    ),
                    // subtitle: Text(
                    //   AppStrings.addUserSubtitle,
                    //   style: AppTextStyles.regular11
                    //       .copyWith(color: AppColors.gray),
                    // ),
                    trailing: SvgWrapper(
                      path: AppAssets.friends,
                      fit: BoxFit.fill,
                      width: MyResponsive.fontSize(value: 30),
                    ),
                    leading: ClipRRect(
                      borderRadius:
                          BorderRadius.circular(MyResponsive.radius(value: 10)),
                      child: Image.asset(
                        AppAssets.profileImage,
                        width: MyResponsive.width(value: 53),
                      ),
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 14)),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      children: [
                        SizedBox(width: MyResponsive.width(value: 10)),
                      ],
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 5)),
                  Divider(color: AppColors.gray),
                  SizedBox(height: MyResponsive.height(value: 5)),
                  GestureDetector(
                    onTap: () async {
                      await CacheHelper.removeData(key: CacheKeys.accessToken);
                      await CacheHelper.removeData(key: CacheKeys.refreshToken);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        LoginView.routeName,
                        (route) => false,
                      );
                    },
                    child: Row(
                      children: [
                        SvgWrapper(
                          path: AppAssets.logout,
                          color: AppColors.red,
                        ),
                        SizedBox(width: MyResponsive.width(value: 10)),
                        Text(
                          AppStrings.logout,
                          style: AppTextStyles.semiBold11
                              .copyWith(color: AppColors.red),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: MyResponsive.height(value: 10)),
                ],
              ),
            ),
            SizedBox(height: MyResponsive.height(value: 50)),
          ],
        ),
      ),
    );
  }
}
