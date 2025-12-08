import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/shared_widgets/svg_wrapper.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class StatesFilterDropdownWidget extends StatelessWidget {
  const StatesFilterDropdownWidget({
    super.key,
    required this.selectedValue,
    required this.items,
    this.onChanged,
  });

  final String selectedValue;
  final List<Map<String, dynamic>> items;
  final Function(String?)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingSymmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 5)),
        color: const Color(0xFF9B09FD).withValues(alpha: .3),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          dropdownColor: AppColors.appFill,
          iconEnabledColor: Colors.white,
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 5)),
          value: selectedValue,
          icon: const Icon(Icons.keyboard_arrow_down),
          menuWidth: MyResponsive.width(value: 215),
          isExpanded: true,
          iconSize: MyResponsive.fontSize(value: 30),
          selectedItemBuilder: (context) {
            return items.map((item) {
              return Row(
                children: [
                  SvgWrapper(path: item['icon']),
                  SizedBox(width: MyResponsive.width(value: 30)),
                  Text(
                    item['title'],
                    style: AppTextStyles.semiBold17,
                  ),
                ],
              );
            }).toList();
          },
          items: items.map((item) {
            return DropdownMenuItem<String>(
              alignment: Alignment.centerLeft,
              value: item['title'] as String,
              child: Container(
                padding:
                    MyResponsive.paddingSymmetric(vertical: 8, horizontal: 12),
                decoration: BoxDecoration(
                  color: item['color'] as Color,
                  borderRadius:
                      BorderRadius.circular(MyResponsive.radius(value: 5)),
                ),
                child: Row(
                  children: [
                    SvgWrapper(path: item['icon']),
                    SizedBox(width: MyResponsive.width(value: 30)),
                    Text(
                      item['title'] as String,
                      style: AppTextStyles.semiBold17,
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}
