import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/favorite/manager/favorite_cubit.dart';
import 'package:dalilak_app/features/favorite/manager/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';

import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../chat_history/views/widgets/history_app_bar.dart';
import 'favorite_item.dart';

class FavoriteViewBody extends StatelessWidget {
  const FavoriteViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit.get(context);

    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: MyResponsive.height(value: 120)),
          HistoryAppBar(title: AppStrings.favorite),
          SizedBox(height: MyResponsive.height(value: 30)),
          Expanded(
            child: BlocBuilder<FavoriteCubit, FavoriteState>(
              builder: (context, state) {
                final cubit = FavoriteCubit.get(context);

                if (cubit.favoriteCars.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: MyResponsive.paddingSymmetric(horizontal: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Lottie animation with fallback
                          Lottie.network(
                            'https://lottie.host/embed/a7f3e3e0-5e0a-4e3a-8e3a-5e0a4e3a8e3a/empty-box.json',
                            width: MyResponsive.width(value: 200),
                            height: MyResponsive.height(value: 200),
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return Icon(
                                Icons.favorite_border,
                                size: MyResponsive.fontSize(value: 120),
                                color: AppColors.gray.withOpacity(0.3),
                              );
                            },
                          ),
                          SizedBox(height: MyResponsive.height(value: 20)),
                          Text(
                            'لا توجد سيارات مفضلة بعد',
                            style: AppTextStyles.bold20,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: MyResponsive.height(value: 8)),
                          Text(
                            'ابدأ بإضافة سياراتك المفضلة لتسهيل الوصول إليها',
                            style: AppTextStyles.regular14.copyWith(
                              color: AppColors.gray,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(height: MyResponsive.height(value: 30)),
                          CustomButton(
                            title: 'استكشف السيارات',
                            onPressed: () {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                'home',
                                (route) => false,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(const Duration(seconds: 2));
                    FavoriteCubit.get(context)
                        .init(UserCubit.get(context).favoriteCars);
                  },
                  child: ListView.separated(
                    padding: EdgeInsets.zero,
                    itemCount: cubit.favoriteCars.length,
                    separatorBuilder: (_, __) =>
                        SizedBox(height: MyResponsive.height(value: 20)),
                    itemBuilder: (context, index) {
                      final car = cubit.favoriteCars[index];

                      return FavoriteItem(
                        car: car,
                        onRemove: () {
                          cubit.removeFromFavorite(
                            car: car,
                            userCubit: userCubit,
                          );
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
