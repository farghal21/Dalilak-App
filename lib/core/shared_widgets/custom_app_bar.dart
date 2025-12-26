import 'package:dalilak_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:flutter/material.dart';

import '../helper/my_responsive.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    // backgroundColor: Color(0xFF0D0A27),
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: AppBarTitle(),
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,

    actions: [
      Padding(
        padding: MyResponsive.paddingSymmetric(horizontal: 10),
      )
      //   padding: MyResponsive.paddingSymmetric(horizontal: 10),
      //   child: Builder(builder: (context) {
      //     return IconButton(
      //       onPressed: () {
      //         Scaffold.of(context).openEndDrawer();
      //       },
      //       icon: SvgWrapper(path: AppAssets.notificationsImage),
      //     );
      //   }),
      // ),
    ],
  );
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = UserCubit.get(context);
    return Container(
      padding: MyResponsive.paddingSymmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.black,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 30)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
              radius: MyResponsive.radius(value: 16),
              child: ClipRRect(
                borderRadius:
                    BorderRadius.circular(MyResponsive.radius(value: 30)),
                child: cubit.userModel.profileImageUrl != null
                    ? CachedNetworkImageWrapper(
                        imagePath: cubit.userModel.profileImageUrl!,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        AppAssets.profileImage,
                        fit: BoxFit.cover,
                      ),
              )),
          SizedBox(
            width: MyResponsive.width(value: 8),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                cubit.userModel.fullName ?? 'User Name',
                style: AppTextStyles.bold11,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
