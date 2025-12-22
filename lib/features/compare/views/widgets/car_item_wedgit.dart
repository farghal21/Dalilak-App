import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/home/data/models/fetch_chat_messages_response_model.dart';
import 'package:flutter/material.dart';

class CarItemWidget extends StatelessWidget {
  final CarModel car;
  final VoidCallback onRemove;

  const CarItemWidget({
    super.key,
    required this.car,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topRight,
            children: [
              CachedNetworkImageWrapper(
                imagePath: car.images.first,
                width: MyResponsive.width(value: 130),
                height: MyResponsive.height(value: 80),
                fit: BoxFit.fill,
              ),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: onRemove,
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 12)),
          Text(
            car.name,
            style: AppTextStyles.bold16,
          ),
          // Text(car.model, style: AppTextStyles.regular14),
          SizedBox(height: MyResponsive.height(value: 12)),
          Text(
            car.price,
            style: AppTextStyles.semiBold16,
          ),
        ],
      ),
    );
  }
}
