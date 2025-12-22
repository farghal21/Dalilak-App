import 'package:dalilak_app/core/utils/app_colors.dart';
import 'package:dalilak_app/core/utils/app_text_styles.dart';
import 'package:dalilak_app/features/compare/views/widgets/spec_row.dart';
import 'package:flutter/material.dart';

class SpecsSection extends StatelessWidget {
  final String sectionTitle;
  final List<SpecRow> specs;

  const SpecsSection({
    super.key,
    required this.sectionTitle,
    required this.specs,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.fillColor,
      elevation: 0,
      child: ExpansionTile(
        title: Text(
          sectionTitle,
          style: AppTextStyles.bold20,
        ),
        children: specs,
      ),
    );
  }
}
