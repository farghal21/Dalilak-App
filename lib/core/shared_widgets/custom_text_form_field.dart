import 'package:flutter/material.dart';

import '../helper/my_responsive.dart';
import '../helper/validator.dart';
import '../utils/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/app_text_styles.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.type,
    this.controller,
    this.passController,
    this.obsecure = true,
    this.onSuffixTapped,
    this.searchOnChange,
  });

  final TextFieldType type;
  final TextEditingController? controller;
  final TextEditingController? passController;
  final bool obsecure;
  final void Function()? onSuffixTapped;
  final void Function(String)? searchOnChange;

  @override
  Widget build(BuildContext context) {
    switch (type) {
      case TextFieldType.password:
        return _passwordField(
          context,
          passController == null
              ? Validator.password
              : (value) =>
                  Validator.confirmPassword(value, passController!.text),
        );

      case TextFieldType.email:
        return _emailField(context, Validator.email);

      case TextFieldType.name:
        return _nameField(context, Validator.name);

      case TextFieldType.phone:
        return _phoneField(context, Validator.phone);

      case TextFieldType.search:
        return _searchField(context);
    }
  }

  ///////////////////////--Decorations//////////////////////
  InputDecoration _inputDecoration(
    BuildContext context, {
    String? label,
    String? hint,
    Widget? suffixIcon,
    Widget? prefixIcon,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: AppTextStyles.bold13.copyWith(color: AppColors.gray),
      labelText: label,
      labelStyle: AppTextStyles.bold13.copyWith(color: AppColors.gray),
      filled: true,
      fillColor: AppColors.fillColor,
      errorMaxLines: 2,
      contentPadding: MyResponsive.paddingSymmetric(
        horizontal: 13,
        vertical: 20,
      ),
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      border: _border(context, AppColors.white),
      focusedErrorBorder: _border(context, AppColors.red),
      focusedBorder: _border(context, AppColors.primary),
      enabledBorder: _border(context, AppColors.white),
      errorBorder: _border(context, AppColors.red),
    );
  }

  TextStyle _textStyle(BuildContext context) {
    return AppTextStyles.semiBold13;
  }

  InputBorder _border(BuildContext context, Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(MyResponsive.radius(value: 10)),
      ),
      borderSide: BorderSide(color: color, width: 1),
    );
  }

  /////////////////////////--TextFields////////////////////////////////
  Widget _nameField(
    BuildContext context,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      controller: controller,
      style: _textStyle(context),
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.name,
      decoration: _inputDecoration(
        context,
        label: AppStrings.fullName,
        prefixIcon: Icon(
          Icons.person,
          color: AppColors.gray,
        ),
      ),
    );
  }

  Widget _emailField(
    BuildContext context,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: _textStyle(context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.emailAddress,
      decoration: _inputDecoration(
        context,
        label: AppStrings.email,
        prefixIcon: Icon(
          Icons.email,
          color: AppColors.gray,
        ),
      ),
    );
  }

  Widget _passwordField(
    BuildContext context,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: _textStyle(context),
      obscureText: obsecure,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.visiblePassword,
      decoration: _inputDecoration(
        context,
        label: passController == null
            ? AppStrings.password
            : AppStrings.confirmPassword,
        prefixIcon: Icon(Icons.lock, color: AppColors.gray),
        suffixIcon: IconButton(
          onPressed: onSuffixTapped,
          icon: obsecure
              ? Icon(
                  Icons.visibility,
                  color: AppColors.gray,
                )
              : Icon(
                  Icons.visibility_off,
                  color: AppColors.gray,
                ),
        ),
      ),
    );
  }

  Widget _phoneField(
    BuildContext context,
    String? Function(String?)? validator,
  ) {
    return TextFormField(
      controller: controller,
      validator: validator,
      style: _textStyle(context),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      keyboardType: TextInputType.phone,
      decoration: _inputDecoration(
        context,
        label: AppStrings.phoneNumber,
        prefixIcon: Icon(
          Icons.phone,
          color: AppColors.gray,
        ),
      ),
    );
  }

  Widget _searchField(
    BuildContext context,
  ) {
    return SearchBar(
      hintText: AppStrings.search,
      leading: Icon(Icons.search, color: AppColors.gray),
      backgroundColor: WidgetStateProperty.all(AppColors.appFill),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
          side: BorderSide(
            color: AppColors.white.withValues(alpha: .1),
            width: 1.2,
          ),
        ),
      ),
      textStyle: WidgetStateProperty.all(
        const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      hintStyle: WidgetStateProperty.all(
        AppTextStyles.semiBold17.copyWith(color: AppColors.gray),
      ),
      padding: WidgetStateProperty.all(
        MyResponsive.paddingSymmetric(
          horizontal: 19,
          vertical: 10,
        ),
      ),
      // elevation: WidgetStateProperty.all(0),

      onChanged: searchOnChange,
    );
  }
}

enum TextFieldType { password, email, name, phone, search }
