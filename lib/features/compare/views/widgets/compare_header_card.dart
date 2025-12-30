import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/compare/views/widgets/vs_cycle_widget.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter/material.dart';

class CompareHeaderCard extends StatelessWidget {
  final CarModel leftCar;
  final CarModel rightCar;
  final VoidCallback onRemoveLeft;
  final VoidCallback onRemoveRight;

  const CompareHeaderCard({
    super.key,
    required this.leftCar,
    required this.rightCar,
    required this.onRemoveLeft,
    required this.onRemoveRight,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.fillColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      child: Padding(
        padding: MyResponsive.paddingAll(value: 16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedNetworkImageWrapper(
                          imagePath: leftCar.images.first,
                          fit: BoxFit.contain,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onRemoveLeft,
                      ),
                    ],
                  ),
                ),
                const VsCircleWidget(),
                Expanded(
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      AspectRatio(
                        aspectRatio: 16 / 9,
                        child: CachedNetworkImageWrapper(
                          imagePath: rightCar.images.first,
                          fit: BoxFit.contain,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: onRemoveRight,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: MyResponsive.height(value: 16)),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        leftCar.name,
                        style: AppTextStyles.bold16,
                      ),
                      SizedBox(height: MyResponsive.height(value: 8)),
                      Text(
                        leftCar.price,
                        style: AppTextStyles.semiBold16,
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        rightCar.name,
                        style: AppTextStyles.bold16,
                      ),
                      SizedBox(height: MyResponsive.height(value: 8)),
                      Text(
                        rightCar.price,
                        style: AppTextStyles.semiBold16,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
