import 'dart:io';
import 'package:dalilak_app/core/utils/app_assets.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dalilak_app/core/helper/my_responsive.dart';
import 'package:dalilak_app/core/shared_widgets/custom_button.dart';
import 'package:dalilak_app/core/shared_widgets/custom_text_form_field.dart';
import 'package:dalilak_app/core/utils/app_strings.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_state.dart';

class ProfileSettingViewBody extends StatelessWidget {
  const ProfileSettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        var cubit = UserCubit.get(context);
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding:
              EdgeInsets.symmetric(horizontal: MyResponsive.width(value: 20)),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                SizedBox(height: MyResponsive.height(value: 140)),

                // --- 1. Enhanced Profile Image with Animation ---
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Gradient Ring
                        Container(
                          width: 140,
                          height: 140,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.horizontalGradient,
                          ),
                        ),
                        // Profile Image
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.black,
                            image: DecorationImage(
                              image: cubit.imageFile != null
                                  ? FileImage(File(cubit.imageFile!.path))
                                      as ImageProvider
                                  : (cubit.userModel.profileImageUrl != null
                                      ? NetworkImage(
                                          'https://jrkmal-001-site1.jtempurl.com${cubit.userModel.profileImageUrl}')
                                      : const AssetImage(
                                          AppAssets.profileImage)),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        // Camera Button
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () => cubit.pickProfileImage(),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                gradient: AppColors.horizontalGradient,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primary.withOpacity(0.4),
                                    blurRadius: 12,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: MyResponsive.height(value: 50)),

                // --- 2. Animated Form Fields ---
                _buildAnimatedField(
                  delay: 100,
                  child: CustomTextFormField(
                    controller: cubit.nameController,
                    type: TextFieldType.name,
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 20)),

                _buildAnimatedField(
                  delay: 200,
                  child: CustomTextFormField(
                    controller: cubit.emailController,
                    type: TextFieldType.email,
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 20)),

                // Password Info Text
                _buildAnimatedField(
                  delay: 300,
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: MyResponsive.width(value: 12),
                        vertical: MyResponsive.height(value: 8),
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.fillColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppColors.gray.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.info_outline,
                            size: 16,
                            color: AppColors.gray,
                          ),
                          SizedBox(width: MyResponsive.width(value: 8)),
                          Flexible(
                            child: Text(
                              "كلمة المرور مطلوبة فقط عند تغيير البريد الإلكتروني",
                              style: AppTextStyles.regular12.copyWith(
                                color: AppColors.gray,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 12)),

                _buildAnimatedField(
                  delay: 400,
                  child: CustomTextFormField(
                    controller: cubit.passwordController,
                    type: TextFieldType.password,
                    obsecure: cubit.obsecure,
                    onSuffixTapped: () {
                      cubit.togglePasswordVisibility();
                    },
                  ),
                ),

                SizedBox(height: MyResponsive.height(value: 50)),

                // --- 3. Animated Save Button ---
                _buildAnimatedField(
                  delay: 500,
                  child: CustomButton(
                    title: AppStrings.save,
                    onPressed: () {
                      String currentEmail = cubit.emailController.text;
                      String? oldEmail = cubit.userModel.email;
                      String password = cubit.passwordController.text;

                      bool isEmailChanged = currentEmail != oldEmail;

                      if (isEmailChanged && password.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                "يرجى إدخال كلمة المرور لتأكيد تغيير البريد الإلكتروني"),
                            backgroundColor: Colors.orange,
                          ),
                        );
                        return;
                      }

                      cubit.saveProfileData();
                    },
                  ),
                ),
                SizedBox(height: MyResponsive.height(value: 40)),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Animated Field Widget
  Widget _buildAnimatedField({
    required int delay,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 400 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOut,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
    );
  }
}
