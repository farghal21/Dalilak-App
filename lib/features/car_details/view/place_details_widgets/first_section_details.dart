

import 'package:dalilak_app/core/shared_widgets/svg_wrapper.dart';
import 'package:dalilak_app/core/utils/app_assets.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';



class FirstSectionDetails extends StatelessWidget {
  const FirstSectionDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'مرسيدس C200',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: AppTextStyles.bold20,
                ),
              ),
              SizedBox(width: MyResponsive.width(value: 6)),
              IconButton(
                onPressed: () {},
                  icon: SvgWrapper(path: AppAssets.favorite , width: MyResponsive.width(value: 30),)

              ),
              IconButton(
                onPressed: () {},

                icon: SvgWrapper(path: AppAssets.compare , width: MyResponsive.width(value: 30),)
              ),

            ],
          ),
          SizedBox(height: MyResponsive.height(value: 8)),
          Row(
            children: [

              Text(
                'sub title',
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: AppTextStyles.semiBold14
              ),
            ],
          ),
          SizedBox(height: MyResponsive.height(value: 15)),
          Text(
            'وصف العربيه',
              style: AppTextStyles.semiBold14
          ),
        ],
      ),
    );
  }
}
