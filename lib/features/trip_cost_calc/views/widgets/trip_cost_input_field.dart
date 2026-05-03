import 'package:flutter/material.dart';
import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_text_styles.dart';

class TripCostInputField extends StatefulWidget {
  const TripCostInputField({
    super.key,
    required this.label,
    required this.hint,
    required this.icon,
    required this.initialValue,
    required this.onChanged,
    this.isNumber = false,
  });

  final String label;
  final String hint;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;
  final bool isNumber;

  @override
  State<TripCostInputField> createState() => _TripCostInputFieldState();
}

class _TripCostInputFieldState extends State<TripCostInputField> {
  late TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(TripCostInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != controller.text) {
      // Only update if the value is different to avoid cursor jumping issues
      // caused by round-trip updates during typing.
      // However, for external updates (like Slider), we want to update.
      // A simple equality check usually suffices if the format matches.
      // But if user types "10." and state is "10", we shouldn't overwrite "10." with "10".

      // For this specific case (syncing with slider), we prioritize external updates that are significantly different.
      // But since user types -> updates state -> updates props, this loop is tricky.

      // Safe bet: Update controller text, but try to preserve selection if possible,
      // or simply rely on the fact that if user is typing, the value in controller
      // is likely same as state.

      // If the update comes from Slider, the user is NOT typing in this field.
      // If the update comes from typing, controller.text == widget.initialValue (mostly).

      // One check: is the widget currently focused?
      // If focused, avoid updating unless necessary?

      // Let's just update. If it causes issues, I'll fix cursor.
      // Actually, better to check:
      if (oldWidget.initialValue != widget.initialValue) {
        controller.text = widget.initialValue;
        controller.selection = TextSelection.fromPosition(
            TextPosition(offset: controller.text.length));
      }
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label.isNotEmpty) ...[
          Text(
            widget.label,
            style: AppTextStyles.regular14.copyWith(color: Colors.white70),
          ),
          SizedBox(height: MyResponsive.height(value: 8)),
        ],
        TextFormField(
          controller: controller,
          keyboardType: widget.isNumber
              ? const TextInputType.numberWithOptions(decimal: true)
              : TextInputType.text,
          onChanged: widget.onChanged,
          style: AppTextStyles.semiBold16.copyWith(color: AppColors.white),
          decoration: InputDecoration(
            hintText: widget.hint,
            hintStyle: AppTextStyles.regular14.copyWith(color: Colors.white30),
            suffixIcon: Icon(widget.icon, color: AppColors.secondary, size: 22),
            filled: true,
            fillColor: AppColors.black.withOpacity(0.3),
            contentPadding:
                MyResponsive.paddingSymmetric(vertical: 16, horizontal: 16),
            enabledBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 12)),
              borderSide: BorderSide(color: AppColors.gray.withOpacity(0.2)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.circular(MyResponsive.radius(value: 12)),
              borderSide: BorderSide(color: AppColors.secondary),
            ),
          ),
        ),
      ],
    );
  }
}
