import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_text_styles.dart';

class HistoryAppBar extends StatelessWidget {
  const HistoryAppBar({
    super.key,
    required this.title,
  });

  // 👇 required text
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: MyResponsive.height(value: 50),
          width: MyResponsive.width(value: 50),
          child: Image.asset(AppAssets.chatImage),
        ),
        SizedBox(width: MyResponsive.width(value: 14)),
        Text(
          title,
          style: AppTextStyles.semiBold20,
        ),
      ],
    );
  }
}
