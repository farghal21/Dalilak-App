import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/features/compare/views/widgets/vs_cycle_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/app_assets.dart';
import 'car_item_wedgit.dart';

class CompareHeaderCard extends StatelessWidget {
  const CompareHeaderCard({super.key});

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
          children: const [
            CarItemWidget(
              image: AppAssets.car1,
              title: 'T01 2026 212',
              subtitle: '2.0T Adventurer',
              price: '3,200,000 ج.م',
            ),
            VsCircleWidget(),
            CarItemWidget(
              image: AppAssets.car2,
              title: 'BMW 118i',
              subtitle: 'Series 2026',
              price: '2,200,000 ج.م',
            ),
          ],
        ),
      ),
    );
  }
}
