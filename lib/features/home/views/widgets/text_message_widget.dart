import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/message_model.dart';

class TextMessageWidget extends StatelessWidget {
  const TextMessageWidget({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingSymmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
        color: message.sender == MessageSender.bot
            ? AppColors.fillColor
            : AppColors.appFill,
        borderRadius: message.borderRadius,
      ),
      child: message.sender == MessageSender.bot
          ? Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  AppAssets.chatImage,
                  width: MyResponsive.width(value: 57),
                  // height: MyResponsive.height(value: 24),
                  fit: BoxFit.fill,
                ),
                SizedBox(
                  width: MyResponsive.width(value: 12),
                ),
                Expanded(
                  child: Text(
                    message.message,
                    style: AppTextStyles.regular16,
                  ),
                ),
              ],
            )
          : Text(
              message.message,
              style: AppTextStyles.regular16,
            ),
    );
  }
}
