import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class ChatLoadingWidget extends StatelessWidget {
  const ChatLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppAssets.chatImage,
          width: MyResponsive.width(value: 57),
          // height: MyResponsive.height(value: 24),
          fit: BoxFit.fill,
        ),
        SizedBox(
          width: MyResponsive.width(value: 8),
        ),
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: Text(
                  AppStrings.chatLoadingTitle,
                  style: AppTextStyles.bold20,
                ),
              ),
              SizedBox(
                height: MyResponsive.height(value: 4),
              ),
              Expanded(
                child: Text(
                  AppStrings.chatLoadingSubTitle,
                  style: AppTextStyles.regular16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
