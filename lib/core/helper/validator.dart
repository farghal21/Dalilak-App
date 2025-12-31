import 'package:dalilak_app/core/utils/app_strings.dart';

import '../utils/app_strings.dart';

abstract class Validator {
  static String? name(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emptyField;
    }
    return null;
  }

  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailRequired;
    }
    final emailRegex = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.emailInvalid;
    }
    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.passwordRequired;
    }
    if (value.length < 6) {
      return AppStrings.passwordTooShort;
    }
    return null;
  }

  static String? confirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return AppStrings.confirmPasswordRequired;
    }
    if (value != password) {
      return AppStrings.passwordsNotMatch;
    }
    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.phoneRequired;
    }

    value = value.trim();

    final phoneRegex = RegExp(r'^(?:\+966|00966|0)?5\d{8}$');

    if (!phoneRegex.hasMatch(value)) {
      return AppStrings.phoneInvalid;
    }

    return null;
  }

  // Add Car Feature Validators
  static String? carName(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.carNameRequired;
    }
    return null;
  }

  static String? price(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.priceRequired;
    }

    // Check if the value is numeric
    final numericRegex = RegExp(r'^\d+$');
    if (!numericRegex.hasMatch(value.trim())) {
      return AppStrings.priceInvalid;
    }

    return null;
  }

  static String? description(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.descriptionRequired;
    }

    if (value.trim().length < 20) {
      return AppStrings.descriptionTooShort;
    }

    return null;
  }

  static String? phoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.phoneNumberRequired;
    }

    value = value.trim();

    // Check if the value is numeric and exactly 11 digits
    final phoneRegex = RegExp(r'^\d{11}$');
    if (!phoneRegex.hasMatch(value)) {
      return AppStrings.phoneNumberInvalid;
    }

    return null;
  }
}
