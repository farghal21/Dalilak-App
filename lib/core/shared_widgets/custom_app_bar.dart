import 'dart:ui';
import 'package:dalilak_app/core/shared_widgets/cached_network_image_wrapper.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_state.dart';
import 'package:dalilak_app/features/settings/views/profile_setting_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../helper/my_responsive.dart';
import '../utils/app_assets.dart';
import '../utils/app_colors.dart';
import '../utils/app_text_styles.dart';

AppBar customAppBar(BuildContext context) {
  return AppBar(
    backgroundColor: Colors.transparent,
    centerTitle: true,
    title: const AppBarTitle(),
    scrolledUnderElevation: 0,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    actions: [
      Padding(
        padding: MyResponsive.paddingSymmetric(horizontal: 10),
      )
    ],
  );
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. نتأكد من اسم الصفحة الحالية
    final currentRoute = ModalRoute.of(context)?.settings.name;
    final isProfileSettings = currentRoute == ProfileSettingView.routeName;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return GestureDetector(
          // 2. لو إحنا في نفس الصفحة، نعطل الضغط (null)
          onTap: isProfileSettings
              ? null
              : () {
                  Navigator.pushNamed(context, ProfileSettingView.routeName);
                },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: MyResponsive.width(value: 8),
                  vertical: MyResponsive.height(value: 6),
                ),
                decoration: BoxDecoration(
                  color: AppColors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Profile Image
                    Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.transparent,
                      ),
                      child: ClipOval(
                        child: SizedBox(
                          width: MyResponsive.width(value: 36),
                          height: MyResponsive.width(value: 36),
                          child: cubit.userModel.profileImageUrl != null
                              ? CachedNetworkImageWrapper(
                                  imagePath:
                                      'https://jrkmal-001-site1.jtempurl.com${cubit.userModel.profileImageUrl}',
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  AppAssets.profileImage,
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                    ),

                    SizedBox(width: MyResponsive.width(value: 12)),

                    // Text
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: MyResponsive.width(
                                value: 8)), // مسافة ناحية الاسم
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "مرحباً 👋",
                              style: AppTextStyles.regular12.copyWith(
                                color: Colors.grey,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              cubit.userModel.fullName ?? 'Dalilak User',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.semiBold14.copyWith(
                                color: Colors.white,
                                height: 1.2,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
