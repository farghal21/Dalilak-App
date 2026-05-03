import 'package:dalilak_app/features/settings/manager/delete_account_setting_cubit/delete_account_setting_state.dart';
import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/custom_button.dart';
import '../../../../core/shared_widgets/custom_text_form_field.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';
import '../../../chat_history/views/widgets/history_app_bar.dart';
import '../../manager/delete_account_setting_cubit/delete_account_setting_cubit.dart';
import 'delete_account_showing_dialog_widget.dart';

class DeleteAccountSettingViewBody extends StatelessWidget {
  const DeleteAccountSettingViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = DeleteAccountSettingCubit.get(context);

    return Column(
      children: [
        SizedBox(height: MyResponsive.height(value: 120)),

        // AppBar
        Padding(
          padding: MyResponsive.paddingSymmetric(horizontal: 20),
          child: HistoryAppBar(title: AppStrings.deleteAccount),
        ),

        Expanded(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: MyResponsive.paddingSymmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MyResponsive.height(value: 40)),

                // --- Warning Banner ---
                TweenAnimationBuilder<double>(
                  duration: const Duration(milliseconds: 600),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Opacity(
                      opacity: value,
                      child: Transform.translate(
                        offset: Offset(0, 20 * (1 - value)),
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: MyResponsive.paddingAll(value: 16),
                    decoration: BoxDecoration(
                      color: AppColors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: AppColors.red.withOpacity(0.3),
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Icon(Icons.warning_amber_rounded,
                                color: AppColors.red, size: 28),
                            SizedBox(width: MyResponsive.width(value: 12)),
                            Text(
                              AppStrings.alert,
                              style: AppTextStyles.semiBold19.copyWith(
                                color: AppColors.red,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: MyResponsive.height(value: 12)),
                        Text(
                          AppStrings.deleteAccountSubtitle,
                          style: AppTextStyles.regular14.copyWith(
                            color: AppColors.white.withOpacity(0.8),
                            height: 1.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: MyResponsive.height(value: 40)),

                BlocBuilder<DeleteAccountSettingCubit,
                    DeleteAccountSettingState>(
                  builder: (context, state) {
                    return Form(
                      key: cubit.formKey,
                      child: Column(
                        children: [
                          _buildAnimatedField(
                            delay: 200,
                            child: CustomTextFormField(
                              type: TextFieldType.password,
                              controller: cubit.passwordController,
                              obsecure: cubit.isPasswordVisible,
                              onSuffixTapped: cubit.changePasswordVisibility,
                              // hintText: "كلمة المرور الحالية",
                            ),
                          ),
                          SizedBox(height: MyResponsive.height(value: 20)),
                          _buildAnimatedField(
                            delay: 400,
                            child: CustomTextFormField(
                              type: TextFieldType.password,
                              controller: cubit.confirmPasswordController,
                              passController: cubit.passwordController,
                              obsecure: cubit.isConfirmPasswordVisible,
                              onSuffixTapped:
                                  cubit.changeConfirmPasswordVisibility,
                              // hintText: "تأكيد كلمة المرور",
                            ),
                          ),
                          SizedBox(height: MyResponsive.height(value: 50)),

                          // Delete Button
                          _buildAnimatedField(
                            delay: 600,
                            child: CustomButton(
                              title: AppStrings.delete,
                              backgroundColor: AppColors.red, // زرار أحمر
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
                            ),
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
        ),
      ],
    );
  }

  Widget _buildAnimatedField({
    required int delay,
    required Widget child,
  }) {
    return TweenAnimationBuilder<double>(
      duration: Duration(milliseconds: 500 + delay),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutQuart,
      builder: (context, value, _) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
    );
  }
}
