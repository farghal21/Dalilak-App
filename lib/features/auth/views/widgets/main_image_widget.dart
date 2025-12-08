import 'package:flutter/cupertino.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_assets.dart';

class MainImageWidget extends StatelessWidget {
  const MainImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MyResponsive.height(value: 45),
        ),
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.asset(
              AppAssets.welcomeImage,
              width: double.infinity,
              height: MyResponsive.height(value: 200),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );
  }
}
