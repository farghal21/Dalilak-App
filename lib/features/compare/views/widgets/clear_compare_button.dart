import 'package:dalilak_app/core/shared_widgets/custom_button.dart';
import 'package:flutter/material.dart';

class ClearCompareButton extends StatelessWidget {
  final VoidCallback onPressed;

  const ClearCompareButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CustomButton(
        title: 'مسح المقارنة',
        onPressed: onPressed,
        backgroundColor: const Color(0xFFCF2A2A),
      ),
    );
  }
}
