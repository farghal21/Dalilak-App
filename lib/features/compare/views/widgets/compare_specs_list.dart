import 'package:dalilak_app/features/home/data/models/send_chat_messages_response_model.dart';
import 'package:flutter/material.dart';

import 'spec_expansion_tile.dart';
import 'spec_row.dart';

class CompareSpecsList extends StatefulWidget {
  final CarModel leftCar;
  final CarModel rightCar;
  final AnimationController animationController;

  const CompareSpecsList({
    super.key,
    required this.leftCar,
    required this.rightCar,
    required this.animationController,
  });

  @override
  State<CompareSpecsList> createState() => _CompareSpecsListState();
}

class _CompareSpecsListState extends State<CompareSpecsList> {
  final Map<int, bool> _expandedSections = {};

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildAnimatedSection(
          index: 1,
          child: SpecExpansionTile(
            title: 'المحرك والأداء',
            icon: Icons.speed_rounded,
            isExpanded: _expandedSections[1] ?? false,
            onTap: () => _toggleSection(1),
            specs: [
              _buildRow('قوة المحرك', (s) => s.horsepower),
              _buildRow('العزم', (s) => s.torque),
              _buildRow('السعة اللترية', (s) => s.engineCapacity),
              _buildRow('السلندرات', (s) => s.cylinders),
              _buildRow('تيربو', (s) => s.turbo),
              _buildRow('التسارع', (s) => s.acceleration),
              _buildRow('السرعة القصوى', (s) => s.maxSpeed),
              _buildRow('نوع الوقود', (s) => s.fuelType),
              _buildRow('استهلاك الوقود', (s) => s.fuelConsumption),
              _buildRow('سعة الخزان', (s) => s.fuelTankCapacity),
            ],
          ),
        ),
        _buildAnimatedSection(
          index: 2,
          child: SpecExpansionTile(
            title: 'ناقل الحركة',
            icon: Icons.settings_applications_rounded,
            isExpanded: _expandedSections[2] ?? false,
            onTap: () => _toggleSection(2),
            specs: [
              _buildRow('نوع الناقل', (s) => s.transmission),
              _buildRow('عدد النقلات', (s) => s.gears),
              _buildRow('نظام الدفع', (s) => s.driveType),
            ],
          ),
        ),
        _buildAnimatedSection(
          index: 3,
          child: SpecExpansionTile(
            title: 'الأبعاد والمساحات',
            icon: Icons.aspect_ratio_rounded,
            isExpanded: _expandedSections[3] ?? false,
            onTap: () => _toggleSection(3),
            specs: [
              _buildRow('نمط الهيكل', (s) => s.bodyType),
              _buildRow('عدد المقاعد', (s) => s.seats),
              _buildRow('الطول', (s) => s.length),
              _buildRow('العرض', (s) => s.width),
              _buildRow('الارتفاع', (s) => s.height),
              _buildRow('قاعدة العجلات', (s) => s.wheelbase),
              _buildRow('الخلوص الأرضي', (s) => s.groundClearance),
              _buildRow('سعة الشنطة', (s) => s.trunkCapacity),
            ],
          ),
        ),
        _buildAnimatedSection(
          index: 4,
          child: SpecExpansionTile(
            title: 'المنشأ والضمان',
            icon: Icons.public_rounded,
            isExpanded: _expandedSections[4] ?? false,
            onTap: () => _toggleSection(4),
            specs: [
              _buildRow('بلد المنشأ', (s) => s.originCountry),
              _buildRow('بلد التجميع', (s) => s.assemblyCountry),
              _buildRow('سنوات الضمان', (s) => s.warrantyYears),
              _buildRow('كيلومترات الضمان', (s) => s.warrantyKm),
            ],
          ),
        ),
        if (widget.leftCar.specs.batteryCapacity != null ||
            widget.rightCar.specs.batteryCapacity != null)
          _buildAnimatedSection(
            index: 5,
            child: SpecExpansionTile(
              title: 'المنظومة الكهربائية',
              icon: Icons.battery_charging_full_rounded,
              isExpanded: _expandedSections[5] ?? false,
              onTap: () => _toggleSection(5),
              specs: [
                _buildRow('سعة البطارية', (s) => s.batteryCapacity),
                _buildRow('المدى الكهربائي', (s) => s.batteryRange),
              ],
            ),
          ),
      ],
    );
  }

  void _toggleSection(int index) {
    setState(() {
      _expandedSections[index] = !(_expandedSections[index] ?? false);
    });
  }

  Widget _buildAnimatedSection({required int index, required Widget child}) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        final double start = (index * 0.1).clamp(0.0, 1.0);
        final double end = (start + 0.5).clamp(0.0, 1.0);
        final double animationValue = widget.animationController.value;
        final double progress =
            ((animationValue - start) / (end - start)).clamp(0.0, 1.0);

        return Opacity(
          opacity: progress.clamp(0.0, 1.0),
          child: Transform.translate(
            offset: Offset(0, 30 * (1 - progress)),
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  SpecRow _buildRow(String title, String? Function(CarSpecs) selector) {
    return SpecRow(
      title: title,
      leftValue: selector(widget.leftCar.specs) ?? '-',
      rightValue: selector(widget.rightCar.specs) ?? '-',
    );
  }
}
