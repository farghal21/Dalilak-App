import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/features/compare/views/widgets/vs_cycle_widget.dart';
import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter/material.dart';

import 'car_item_wedgit.dart';

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
        child: Row(
          children: [
            CarItemWidget(
              car: leftCar,
              onRemove: onRemoveLeft,
            ),
            const VsCircleWidget(),
            CarItemWidget(
              car: rightCar,
              onRemove: onRemoveRight,
            ),
          ],
        ),
      ),
    );
  }
}
