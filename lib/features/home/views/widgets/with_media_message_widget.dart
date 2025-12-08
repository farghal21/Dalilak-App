import 'package:dalilak_app/features/home/views/widgets/with_media_list_view_item_widget.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../data/models/message_model.dart';

class WithMediaMessageWidget extends StatelessWidget {
  const WithMediaMessageWidget({super.key, required this.message});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingSymmetric(horizontal: 15, vertical: 10),
      decoration: BoxDecoration(
          // color: AppColors.fillColor,
          // borderRadius: message.borderRadius,
          ),
      child: Column(
        children: [
          Row(
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
                child: Text(
                  message.message,
                  style: AppTextStyles.regular16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: MyResponsive.height(value: 40),
          ),
          if (message.hotels != null && message.hotels!.isNotEmpty) ...[
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return WithMediaListViewItemWidget(
                  hotel: message.hotels![index],
                );
              },
              separatorBuilder: (context, index) => SizedBox(
                height: MyResponsive.height(value: 60),
              ),
              itemCount: message.hotels?.length ?? 0,
            )
          ]
        ],
      ),
    );
  }
}
