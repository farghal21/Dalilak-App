import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/features/favorite/manager/favorite_cubit.dart';
import 'package:dalilak_app/features/favorite/manager/favorite_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
                    child: Text(
                      'لا يوجد سيارات مفضلة',
                      style: AppTextStyles.semiBold16,
                    ),
                  );
                }

                return ListView.separated(
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
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
