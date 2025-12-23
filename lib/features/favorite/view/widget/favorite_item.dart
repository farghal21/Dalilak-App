import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/car_details/car_details_view.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_colors.dart';

class FavoriteItem extends StatelessWidget {
  const FavoriteItem({
    super.key,
    required this.car,
    required this.onRemove,
  });

  final CarModel car;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        UserCubit.get(context).selectedCar = car;
        MyNavigator.goTo(screen: CarDetailsView());
      },
      child: Container(
        padding: MyResponsive.paddingSymmetric(horizontal: 20, vertical: 15),
        decoration: BoxDecoration(
          color: AppColors.fillColor,
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 10)),
              child: Image.network(
                car.images.first,
                width: MyResponsive.width(value: 120),
                height: MyResponsive.height(value: 80),
                fit: BoxFit.fill,
              ),
            ),
            SizedBox(width: MyResponsive.width(value: 20)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    car.name,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyles.bold20,
                  ),
                  SizedBox(height: MyResponsive.height(value: 10)),
                  Text(
                    car.price,
                    style: AppTextStyles.semiBold16,
                  ),
                  SizedBox(height: MyResponsive.height(value: 10)),
                  ElevatedButton(
                    onPressed: onRemove,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.red,
                    ),
                    child: Text(
                      AppStrings.remove,
                      style: AppTextStyles.regular11
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
