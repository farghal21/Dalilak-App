import 'package:dalilak_app/core/helper/my_navigator.dart';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/car_details/car_details_view.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
    return Dismissible(
      key: ValueKey(car.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerLeft,
        padding: MyResponsive.paddingSymmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.red,
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Icon(
              Icons.delete_outline,
              color: AppColors.white,
              size: MyResponsive.fontSize(value: 30),
            ),
            SizedBox(width: MyResponsive.width(value: 10)),
            Text(
              'حذف',
              style: AppTextStyles.bold20.copyWith(color: AppColors.white),
            ),
          ],
        ),
      ),
      // ❌ لغينا الـ confirmDismiss (Dialog) نهائياً

      onDismissed: (direction) {
        // ✅ الحذف بيتم فوراً هنا
        HapticFeedback.mediumImpact(); // هزة بسيطة للتأكيد
        onRemove();
      },

      child: InkWell(
        onTap: () {
          UserCubit.get(context).selectedCar = car;
          MyNavigator.goTo(screen: () => const CarDetailsView());
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
                  // حماية إضافية لو الصورة باظت
                  errorBuilder: (context, error, stackTrace) => Container(
                    width: MyResponsive.width(value: 120),
                    height: MyResponsive.height(value: 80),
                    color: Colors.grey[800],
                    child: const Icon(Icons.car_repair, color: Colors.white54),
                  ),
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
                    Row(
                      children: [
                        Icon(
                          Icons.swipe_left,
                          size: MyResponsive.fontSize(value: 16),
                          color: AppColors.gray,
                        ),
                        SizedBox(width: MyResponsive.width(value: 5)),
                        Text(
                          'اسحب لليسار للحذف',
                          style: AppTextStyles.regular11.copyWith(
                            color: AppColors.gray,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
