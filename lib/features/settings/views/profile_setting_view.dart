import 'package:dalilak_app/core/user/manager/user_cubit/user_cubit.dart';
import 'package:dalilak_app/core/user/manager/user_cubit/user_state.dart';
import 'package:dalilak_app/features/settings/views/widgets/profile_setting_view_body.dart';
// 👇 1. تأكد إنك عامل Import للملف الجديد اللي عملناه في الخطوة اللي فاتت
import 'package:dalilak_app/features/settings/views/verify_updated_email_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/shared_widgets/custom_progress_hud.dart';
import '../../../core/shared_widgets/custom_scaffold.dart';

class ProfileSettingView extends StatelessWidget {
  const ProfileSettingView({super.key});

  static const String routeName = 'ProfileSettingView';

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      isHomeScreen: true,
      showDrawer: false,
      drawerSelectedIndex: 4,
      body: BlocConsumer<UserCubit, UserState>(
        // 👇👇 هنا الـ Listener اللي بتسأل عليه
        listener: (context, state) {
          // الحالة الأولى: نجاح عادي (تغيير صورة أو اسم)
          if (state is UserUpdateSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.green),
            );
            Navigator.pop(context);
          }

          // 👇 الحالة الثانية: الإيميل اتغير ومحتاجين نروح صفحة الـ Verify
          else if (state is UserUpdateNeedsVerification) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text("تم إرسال رمز التحقق إلى بريدك الجديد")),
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                // بنفتح الصفحة الجديدة اللي عملناها وبنبعتلها الإيميل
                builder: (context) => VerifyUpdatedEmailView(
                  email: state.email,
                ),
              ),
            ).then((value) {
              // لما يرجع، نحدث البيانات عشان الإيميل الجديد يظهر
              if (context.mounted) {
                // تحقق بسيط لتجنب الأخطاء
                UserCubit.get(context).getUserData();
              }
            });
          }

          // الحالة الثالثة: حصل خطأ
          else if (state is UserUpdateError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          return CustomProgressHud(
            isLoading: state is UserUpdateLoading,
            child: const ProfileSettingViewBody(),
          );
        },
      ),
    );
  }
}
