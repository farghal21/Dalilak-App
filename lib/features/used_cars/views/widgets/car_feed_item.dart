import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/used_cars/data/models/car_model.dart';
import 'package:flutter/material.dart';

class CarFeedItem extends StatelessWidget {
  const CarFeedItem({
    super.key,
    required this.car,
  });

  final CarModel car;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 20)),
        border: Border.all(
          color: Colors.white.withOpacity(0.08),
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Car Image with AspectRatio
          ClipRRect(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(MyResponsive.radius(value: 20)),
              topRight: Radius.circular(MyResponsive.radius(value: 20)),
            ),
            child: AspectRatio(
              aspectRatio: 1.6,
              child: Image.network(
                car.images.isNotEmpty ? car.images.first : '',
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: const Color(0xFF2A2A3E),
                    child: Center(
                      child: Icon(
                        Icons.directions_car_outlined,
                        size: 60,
                        color: Colors.grey[700],
                      ),
                    ),
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return Container(
                    color: const Color(0xFF2A2A3E),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: AppColors.primary,
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),

          // Car Details
          Padding(
            padding: EdgeInsets.all(MyResponsive.width(value: 16)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name and Price Row
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Car Name
                    Expanded(
                      child: Text(
                        car.name,
                        style: AppTextStyles.bold18.copyWith(
                          color: AppColors.white,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: MyResponsive.width(value: 12)),

                    // Price Badge
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MyResponsive.width(value: 12),
                        vertical: MyResponsive.height(value: 6),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(
                          MyResponsive.radius(value: 8),
                        ),
                      ),
                      child: Text(
                        '\$${car.price.toStringAsFixed(0)}',
                        style: AppTextStyles.semiBold14.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: MyResponsive.height(value: 12)),

                // Divider
                Divider(
                  color: Colors.white.withOpacity(0.1),
                  height: 1,
                ),

                SizedBox(height: MyResponsive.height(value: 12)),

                // Location and Year Row
                Row(
                  children: [
                    Icon(
                      Icons.location_on_outlined,
                      size: 18,
                      color: AppColors.gray,
                    ),
                    SizedBox(width: MyResponsive.width(value: 6)),
                    Text(
                      car.city,
                      style: AppTextStyles.regular12.copyWith(
                        color: AppColors.gray,
                      ),
                    ),
                    SizedBox(width: MyResponsive.width(value: 20)),
                    Icon(
                      Icons.calendar_today_outlined,
                      size: 18,
                      color: AppColors.gray,
                    ),
                    SizedBox(width: MyResponsive.width(value: 6)),
                    Text(
                      car.createdAtYear.toString(),
                      style: AppTextStyles.regular12.copyWith(
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
    );
  }
}
