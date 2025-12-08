import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

import '../../../../core/utils/app_text_styles.dart';

class CircularPercentWidget extends StatelessWidget {
  const CircularPercentWidget({
    super.key,
    required this.percentage,
    required this.radius,
    required this.lineWidth,
  });

  final double percentage;
  final double radius;

  final double lineWidth;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: lineWidth,
      percent: percentage,
      backgroundColor: Colors.white.withValues(alpha: 0.1),
      circularStrokeCap: CircularStrokeCap.round,
      linearGradient: const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          Color(0xFFFF00FF), // pink
          Color(0xFF7C4DFF), // purple
          Color(0xFF00B0FF), // blue
        ],
      ),
      rotateLinearGradient: true,
      animation: true,
      animationDuration: 1200,
      center: Text(
        '${(percentage * 100).toInt()}%',
        style: AppTextStyles.semiBold19,
      ),
    );
  }
}
