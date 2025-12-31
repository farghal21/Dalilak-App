import 'package:dalilak_app/features/add_car/views/add_car_view.dart';
import 'package:dalilak_app/features/car_inspection/car_inspection_view.dart';
import 'package:dalilak_app/features/chat_history/views/history_view.dart';
import 'package:dalilak_app/features/compare/views/compare_view.dart';
import 'package:dalilak_app/features/favorite/view/favorite_view.dart';
import 'package:dalilak_app/features/trip_cost_calc/views/trip_cost_view.dart';
import 'package:flutter/material.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
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
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),

            // Fixed Logo at Top
            SizedBox(
              height: 60,
              child: Image.asset(
                AppAssets.appBranding,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 30),

            // Scrollable Menu Items
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Core Features
                    MainDrawerItem(
                      imagePath: AppAssets.newChat,
                      title: AppStrings.newChat,
                      onTap: () {
                        Navigator.pushNamedAndRemoveUntil(
                            context, HomeView.routeName, (route) => false);
                      },
                      isSelected: selectedIndex == 0,
                    ),
                    const SizedBox(height: 20),

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
                    const SizedBox(height: 20),

                    // User Collections
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
                    const SizedBox(height: 20),

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
                    const SizedBox(height: 20),

                    // Tools
                    MainDrawerItem(
                      imagePath: AppAssets.cartPlus,
                      title: AppStrings.sellYourCar,
                      isSelected: selectedIndex == 7,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AddCarView()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    MainDrawerItem(
                      imagePath: AppAssets.estimate,
                      title: "حاسبة المشوار",
                      isSelected: selectedIndex == 5,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const TripCostView()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    MainDrawerItem(
                      imagePath: AppAssets.checklist,
                      title: AppStrings.carInspectionDrawerTitle,
                      isSelected: selectedIndex == 6,
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CarInspectionView()),
                        );
                      },
                    ),
                    const SizedBox(height: 20),

                    // Settings at bottom
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

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
