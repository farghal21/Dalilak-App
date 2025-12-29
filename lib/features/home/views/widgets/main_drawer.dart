import 'package:dalilak_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_state.dart';
import 'package:dalilak_app/features/car_inspection/car_inspection_view.dart';
import 'package:dalilak_app/features/chat_history/views/history_view.dart';
import 'package:dalilak_app/features/compare/views/compare_view.dart';
import 'package:dalilak_app/features/favorite/view/favorite_view.dart';
import 'package:dalilak_app/features/trip_cost_calc/trip_cost_calculator_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../settings/views/settings_view.dart';
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
            // ✅ 1. الجزء العلوي القابل للـ Scroll (اللوجو + عناصر القائمة)
            Expanded(
              child: SingleChildScrollView(
                physics:
                    const BouncingScrollPhysics(), // تأثير لطيف عند السكرول
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: MyResponsive.height(value: 50)),
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
                    SizedBox(height: MyResponsive.height(value: 25)),

                    MainDrawerItem(
                      imagePath: AppAssets.history,
                      title: AppStrings.history,
                      onTap: () {
                        if (selectedIndex == 0) {
                          Navigator.pushNamed(context, HistoryView.routeName);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, HistoryView.routeName);
                        }
                      },
                      isSelected: selectedIndex == 1,
                    ),
                    SizedBox(height: MyResponsive.height(value: 25)),

                    MainDrawerItem(
                      imagePath: AppAssets.compare,
                      title: AppStrings.compare,
                      onTap: () {
                        if (selectedIndex == 0) {
                          Navigator.pushNamed(context, CompareView.routeName);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, CompareView.routeName);
                        }
                      },
                      isSelected: selectedIndex == 2,
                    ),
                    SizedBox(height: MyResponsive.height(value: 25)),

                    MainDrawerItem(
                      imagePath: AppAssets.favorite,
                      title: AppStrings.favorite,
                      onTap: () {
                        if (selectedIndex == 0) {
                          Navigator.pushNamed(context, FavoriteView.routeName);
                        } else {
                          Navigator.pushReplacementNamed(
                              context, FavoriteView.routeName);
                        }
                      },
                      isSelected: selectedIndex == 3,
                    ),
                    SizedBox(height: MyResponsive.height(value: 25)),

                    // 👇👇 حاسبة المشوار 👇👇
                    MainDrawerItem(
                      imagePath:
                          AppAssets.estimate, // لا تنس تغيير الأيقونة لاحقاً
                      title: "حاسبة المشوار",
                      isSelected: selectedIndex == 5,
                      onTap: () {
                        Navigator.pop(context); // إغلاق الـ Drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TripCostView()),
                        );
                      },
                    ),
                    SizedBox(height: MyResponsive.height(value: 25)),

                    // 👇👇 ورقة فحص المستعمل 👇👇
                    MainDrawerItem(
                      imagePath: AppAssets.checklist,
                      title: AppStrings.carInspectionDrawerTitle,
                      isSelected: selectedIndex == 6,
                      onTap: () {
                        Navigator.pop(context); // إغلاق الـ Drawer
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarInspectionView()),
                        );
                      },
                    ),
                    SizedBox(height: MyResponsive.height(value: 25)),

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

                    // مسافة إضافية في نهاية القائمة عشان اللمس
                    SizedBox(height: MyResponsive.height(value: 20)),
                  ],
                ),
              ),
            ),

            // ✅ 2. الجزء السفلي الثابت (البروفايل) - بدون Spacer
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                final cubit = UserCubit.get(context);
                final userModel = cubit.userModel;
                return Container(
                  padding: MyResponsive.paddingSymmetric(
                      horizontal: 12, vertical: 8),
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
                          userModel.fullName ?? '',
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                          style: AppTextStyles.bold20,
                        ),
                        trailing: SvgWrapper(
                          path: AppAssets.friends,
                          fit: BoxFit.fill,
                          width: MyResponsive.fontSize(value: 30),
                        ),
                        leading: CircleAvatar(
                          radius: MyResponsive.radius(value: 25),
                          backgroundColor: Colors.transparent,
                          child: ClipOval(
                            child: userModel.profileImageUrl != null
                                ? CachedNetworkImageWrapper(
                                    imagePath:
                                        'https://jrkmal-001-site1.jtempurl.com${userModel.profileImageUrl}',
                                    width: MyResponsive.width(value: 50),
                                    height: MyResponsive.width(value: 50),
                                    fit: BoxFit.cover,
                                  )
                                : Image.asset(AppAssets.profileImage),
                          ),
                        ),
                      ),
                      SizedBox(height: MyResponsive.height(value: 8)),
                      Divider(color: AppColors.gray),
                      SizedBox(height: MyResponsive.height(value: 8)),
                      GestureDetector(
                        onTap: () {
                          cubit.logout();
                        },
                        child: Row(
                          children: [
                            SvgWrapper(
                              path: AppAssets.logout,
                              color: AppColors.red,
                            ),
                            SizedBox(width: MyResponsive.width(value: 16)),
                            Text(
                              AppStrings.logout,
                              style: AppTextStyles.semiBold16
                                  .copyWith(color: AppColors.red),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: MyResponsive.height(value: 10)),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: MyResponsive.height(value: 30)),
          ],
        ),
      ),
    );
  }
}
