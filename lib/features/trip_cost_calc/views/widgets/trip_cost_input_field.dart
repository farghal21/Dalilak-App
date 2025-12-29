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
  });

  final String label;
  final String hint;
  final IconData icon;
  final String initialValue;
  final ValueChanged<String> onChanged;

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
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: AppTextStyles.regular14.copyWith(color: Colors.white70),
        ),
        SizedBox(height: MyResponsive.height(value: 8)),
        TextFormField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
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
