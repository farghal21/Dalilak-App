import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class ChatErrorWidget extends StatelessWidget {
  const ChatErrorWidget({super.key, required this.errorMessage});

  final String errorMessage;

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
              Expanded(
                child: Text(
                  errorMessage,
                  style: AppTextStyles.bold16,
                ),
              ),
              SizedBox(
                height: MyResponsive.height(value: 4),
              ),
              Row(
                children: [
                  Text(
                    AppStrings.tryAgain,
                    style: AppTextStyles.regular16,
                  ),
                  SizedBox(width: MyResponsive.width(value: 5)),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.refresh,
                      size: MyResponsive.fontSize(value: 30),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
