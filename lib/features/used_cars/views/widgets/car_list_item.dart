import 'package:flutter/material.dart';
import '../../../../../core/helper/my_responsive.dart';
import '../../../../../core/shared_widgets/cached_network_image_wrapper.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_text_styles.dart';
import '../../data/models/car_model.dart';

/// Widget for displaying a single car item in the list
class CarListItem extends StatelessWidget {
  final CarModel car;
  final String imageUrl;
  final VoidCallback onTap;

  const CarListItem({
    super.key,
    required this.car,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCarImage(),
            _buildCarDetails(),
          ],
        ),
      ),
    );
  }

  Widget _buildCarImage() {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(
        top: Radius.circular(16),
      ),
      child: car.images.isNotEmpty
          ? CachedNetworkImageWrapper(
              imagePath: imageUrl,
              width: double.infinity,
              height: MyResponsive.height(value: 200),
              fit: BoxFit.cover,
            )
          : Container(
              width: double.infinity,
              height: MyResponsive.height(value: 200),
              color: Colors.grey.shade300,
              child: Icon(
                Icons.directions_car,
                size: 80,
                color: Colors.grey.shade500,
              ),
            ),
    );
  }

  Widget _buildCarDetails() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNameAndYear(),
          const SizedBox(height: 8),
          _buildPrice(),
          const SizedBox(height: 8),
          _buildDescription(),
          const SizedBox(height: 12),
          _buildLocationAndPhone(),
        ],
      ),
    );
  }

  Widget _buildNameAndYear() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            car.name,
            style: AppTextStyles.semiBold16,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 6,
          ),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            '${car.createdAtYear}',
            style: AppTextStyles.regular14.copyWith(
              color: AppColors.primary,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrice() {
    return Text(
      '${car.price.toStringAsFixed(0)} ج.م',
      style: AppTextStyles.bold20.copyWith(
        color: Colors.green.shade600,
      ),
    );
  }

  Widget _buildDescription() {
    return Text(
      car.description,
      style: AppTextStyles.regular14.copyWith(
        color: Colors.grey[700],
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }

  Widget _buildLocationAndPhone() {
    return Row(
      children: [
        Icon(
          Icons.location_on,
          size: 18,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          car.city,
          style: AppTextStyles.regular14.copyWith(
            color: Colors.grey[700],
          ),
        ),
        const SizedBox(width: 16),
        Icon(
          Icons.phone,
          size: 18,
          color: Colors.grey[600],
        ),
        const SizedBox(width: 4),
        Text(
          car.buyerPhoneNumber,
          style: AppTextStyles.regular14.copyWith(
            color: Colors.grey[700],
          ),
        ),
      ],
    );
  }
}
