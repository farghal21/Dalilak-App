import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_text_styles.dart';

class FirstSectionDetails extends StatefulWidget {
  const FirstSectionDetails({super.key});

  @override
  State<FirstSectionDetails> createState() => _FirstSectionDetailsState();
}

class _FirstSectionDetailsState extends State<FirstSectionDetails> {
  bool favoriteLoading = false;
  bool compareLoading = false;

  @override
  Widget build(BuildContext context) {
    final userCubit = UserCubit.get(context);
    final car = userCubit.selectedCar!;

    final isFavorite = userCubit.favoriteCars.any((c) => c.id == car.id);

    final isCompared = userCubit.comparedCars.any((c) => c.id == car.id);

    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  car.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bold20,
                ),
              ),

              /// ❤️ Favorite
              IconButton(
                onPressed: favoriteLoading
                    ? null
                    : () async {
                        setState(() => favoriteLoading = true);
                        await Future.delayed(const Duration(seconds: 1));

                        if (isFavorite) {
                          userCubit.favoriteCars
                              .removeWhere((c) => c.id == car.id);
                        } else {
                          userCubit.favoriteCars.add(car);
                        }

                        setState(() => favoriteLoading = false);
                      },
                icon: favoriteLoading
                    ? _loader()
                    : Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Colors.red : null,
                        size: MyResponsive.width(value: 28),
                      ),
              ),

              /// ⚖️ Compare
              IconButton(
                onPressed: compareLoading
                    ? null
                    : () async {
                        /// ❗ limit 2
                        if (!isCompared && userCubit.comparedCars.length >= 2) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'مسموح بمقارنة عربيتين فقط',
                              ),
                            ),
                          );
                          return;
                        }

                        setState(() => compareLoading = true);
                        await Future.delayed(const Duration(seconds: 1));

                        if (isCompared) {
                          userCubit.comparedCars
                              .removeWhere((c) => c.id == car.id);
                        } else {
                          userCubit.comparedCars.add(car);
                        }

                        setState(() => compareLoading = false);
                      },
                icon: compareLoading
                    ? _loader()
                    : Icon(
                        isCompared ? Icons.check_circle : Icons.compare_arrows,
                        color: isCompared ? Colors.green : null,
                        size: MyResponsive.width(value: 28),
                      ),
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 12)),
          Text(
            car.price,
            style: AppTextStyles.bold18,
          ),
        ],
      ),
    );
  }

  Widget _loader() {
    return SizedBox(
      width: MyResponsive.width(value: 22),
      height: MyResponsive.width(value: 22),
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }
}
