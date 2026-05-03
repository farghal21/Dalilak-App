import 'package:dalilak_app/features/compare/views/widgets/spec_row.dart';
import 'package:flutter/material.dart';

class SpecsSection extends StatelessWidget {
  final List<SpecRow> specs;

  const SpecsSection({
    super.key,
    required this.specs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: specs,
    );
  }
}
