import 'dart:io';
import 'package:dalilak_app/core/utils/app_assets.dart';
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
          padding:
              EdgeInsets.symmetric(horizontal: MyResponsive.width(value: 20)),
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
                SizedBox(height: MyResponsive.height(value: 140)),

                // --- 1. صورة البروفايل ---
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor: Colors.grey[200],
                        backgroundImage: cubit.imageFile != null
                            ? FileImage(File(cubit.imageFile!.path))
                                as ImageProvider
                            : (cubit.userModel.profileImageUrl != null
                                ? NetworkImage(
                                    // 👇 هنا قمنا بإضافة الرابط الذي طلبته قبل مسار الصورة
                                    'https://jrkmal-001-site1.jtempurl.com${cubit.userModel.profileImageUrl}')
                                : const AssetImage(AppAssets.profileImage)),
                      ),
                      InkWell(
                        onTap: () {
                          cubit.pickProfileImage();
                        },
                        child: CircleAvatar(
                          radius: 18,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: const Icon(Icons.camera_alt,
                              size: 18, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: MyResponsive.height(value: 40)),

                // --- 2. حقل الاسم ---
                CustomTextFormField(
                  controller: cubit.nameController,
                  type: TextFieldType.name,
                  // ❌ شيلنا validator لأنه بيتعمل أتوماتيك
                  // ❌ شيلنا hintText
                ),
                SizedBox(height: MyResponsive.height(value: 20)),

                // --- 3. حقل البريد الإلكتروني ---
                CustomTextFormField(
                  controller: cubit.emailController,
                  type: TextFieldType.email,
                  // ❌ شيلنا validator لأنه بيتعمل أتوماتيك
                ),
                SizedBox(height: MyResponsive.height(value: 20)),

                // --- 4. حقل الباسورد ---

                // النص التوضيحي (بما إن مفيش hintText)
                Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding:
                        EdgeInsets.only(bottom: MyResponsive.height(value: 8)),
                    child: Text(
                      "كلمة المرور (مطلوبة فقط عند تغيير البريد الإلكتروني)",
                      style: AppTextStyles.light16.copyWith(
                        color: Colors.grey,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),

                CustomTextFormField(
                  controller: cubit.passwordController,
                  type: TextFieldType.password,
                  // 👇 اربط المتغير والدالة هنا عشان الويجت تحس بالضغط
                  obsecure: cubit.obsecure,
                  onSuffixTapped: () {
                    cubit.togglePasswordVisibility();
                  },
                ),

                SizedBox(height: MyResponsive.height(value: 50)),

                // --- 5. زر الحفظ ---
                // --- 5. زر الحفظ ---
                CustomButton(
                  title: AppStrings.save,
                  onPressed: () {
                    // 1. هنجيب القيم الحالية من الـ Controllers
                    String currentEmail = cubit.emailController.text;
                    String? oldEmail = cubit.userModel.email;
                    String password = cubit.passwordController.text;

                    // 2. هل المستخدم غير الإيميل؟
                    bool isEmailChanged = currentEmail != oldEmail;

                    // 3. لو غير الإيميل والباسورد فاضي، نطلّع رسالة تنبيه
                    if (isEmailChanged && password.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              "يرجى إدخال كلمة المرور لتأكيد تغيير البريد الإلكتروني"),
                          backgroundColor: Colors.orange,
                        ),
                      );
                      return; // نوقف التنفيذ هنا وميناديش الـ API
                    }

                    // 4. لو كل تمام (تغيير اسم بس أو غير إيميل وكتب باسورد) نعتمد الحفظ
                    cubit.saveProfileData();
                  },
                ),
                SizedBox(height: MyResponsive.height(value: 20)),
              ],
            ),
          ),
        );
      },
    );
  }
}
