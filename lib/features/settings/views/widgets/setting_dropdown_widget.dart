import 'package:flutter/material.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class SettingDropdownWidget extends StatelessWidget {
  final String title;
  final String selectedValue;
  final List<String> items;
  final Function(String?)? onChanged;

  const SettingDropdownWidget({
    super.key,
    required this.title,
    required this.selectedValue,
    required this.items,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: AppTextStyles.semiBold17,
        ),
        IntrinsicWidth(
          child: Container(
            padding:
                MyResponsive.paddingSymmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.fillColor,
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 10)),
              // Removed Border for cleaner look
            ),
            child: DropdownButton<String>(
              value: selectedValue,
              isDense: true,
              isExpanded: false,
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        value,
                        style: AppTextStyles.semiBold14,
                      ),
                      SizedBox(width: MyResponsive.width(value: 25)),
                    ],
                  ),
                );
              }).toList(),
              onChanged: onChanged,
              icon: const Icon(Icons.keyboard_arrow_down),
              underline: const SizedBox(),
              dropdownColor: AppColors.black,
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 10)),
            ),
          ),
        ),
      ],
    );
  }
}
