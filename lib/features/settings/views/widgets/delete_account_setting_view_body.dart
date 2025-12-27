import 'package:dalilak_app/features/settings/manager/delete_account_setting_cubit/delete_account_setting_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart'; // لا تنسى الـ Import

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../manager/delete_account_setting_cubit/delete_account_setting_cubit.dart';
import 'delete_account_showing_dialog_widget.dart';

class DeleteAccountSettingViewBody extends StatelessWidget {
  const DeleteAccountSettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = DeleteAccountSettingCubit.get(context);

    return Padding(
      padding: MyResponsive.paddingSymmetric(horizontal: 20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MyResponsive.height(value: 110)),
            Text(AppStrings.deleteAccount, style: AppTextStyles.semiBold24),
            SizedBox(height: MyResponsive.height(value: 33)),
            Text(AppStrings.alert, style: AppTextStyles.semiBold19),
            SizedBox(height: MyResponsive.height(value: 10)),
            SizedBox(
              width: MyResponsive.width(value: 332),
              child: Text(
                AppStrings.deleteAccountSubtitle,
                style: AppTextStyles.semiBold13.copyWith(color: Colors.grey),
              ),
            ),
            SizedBox(height: MyResponsive.height(value: 77)),

            // 👇👇 التعديل هنا: أضفنا BlocBuilder عشان يحس بالتغيير ويعيد الرسم 👇👇
            BlocBuilder<DeleteAccountSettingCubit, DeleteAccountSettingState>(
              builder: (context, state) {
                return Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        type: TextFieldType.password,
                        controller: cubit.passwordController,
                        obsecure: cubit
                            .isPasswordVisible, // دلوقتي القيمة دي هتتحدث لما الـ State تتغير
                        onSuffixTapped: cubit.changePasswordVisibility,
                      ),
                      SizedBox(height: MyResponsive.height(value: 30)),
                      CustomTextFormField(
                        type: TextFieldType.password,
                        controller: cubit.confirmPasswordController,
                        passController: cubit.passwordController,
                        obsecure: cubit.isConfirmPasswordVisible, // ودي كمان
                        onSuffixTapped: cubit.changeConfirmPasswordVisibility,
                      ),
                      SizedBox(height: MyResponsive.height(value: 50)),

                      // زر الحذف
                      CustomButton(
                        title: AppStrings.delete,
                        onPressed: () {
                          if (!cubit.formKey.currentState!.validate()) {
                            return;
                          }
                          showDialog(
                            context: context,
                            builder: (context) =>
                                DeleteAccountShowingDialogWidget(
                              onDelete: () {
                                Navigator.pop(context);
                                cubit.deleteAccount();
                              },
                              onCancel: () {
                                Navigator.pop(context);
                              },
                            ),
                          );
                        },
                      )
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: MyResponsive.height(value: 50)),
          ],
        ),
      ),
    );
  }
}
