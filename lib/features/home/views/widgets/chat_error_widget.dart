import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class ChatErrorWidget extends StatelessWidget {
  const ChatErrorWidget({
    super.key,
    required this.errorMessage,
    required this.onRetry,
  });

  final String errorMessage;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          AppAssets.chatImage,
          width: MyResponsive.width(value: 57),
          fit: BoxFit.fill,
        ),
        SizedBox(width: MyResponsive.width(value: 8)),

        /// 👇 دي أهم حتة
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.chatErrorTitle,
                style: AppTextStyles.bold20,
              ),
              SizedBox(height: MyResponsive.height(value: 4)),
              Text(
                errorMessage,
                softWrap: true, // 👈 مهم
                overflow: TextOverflow.visible, // 👈 بلاش ellipsis هنا
                style: AppTextStyles.bold16,
              ),
              SizedBox(height: MyResponsive.height(value: 4)),
              Row(
                children: [
                  Text(
                    AppStrings.tryAgain,
                    style: AppTextStyles.regular14,
                  ),
                  IconButton(
                    onPressed: onRetry,
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
