import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../core/helper/my_responsive.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/app_text_styles.dart';

class WalletChartWidget extends StatelessWidget {
  final List<ChartDataPoint> data;

  const WalletChartWidget({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: MyResponsive.paddingOnly(
        top: 32,
        bottom: 16,
        left: 16,
        right: 16,
      ),
      decoration: BoxDecoration(
        color: AppColors.appFill,
        borderRadius: BorderRadius.circular(MyResponsive.radius(value: 10)),
      ),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MyResponsive.height(value: 250),
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: _getMaxY(),
                minY: 0,
                gridData: FlGridData(
                  show: false,
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < data.length) {
                          return Padding(
                            padding: MyResponsive.paddingOnly(top: 8.0),
                            child: Text(
                              data[value.toInt()].date,
                              style: AppTextStyles.regular12,
                            ),
                          );
                        }
                        return Text('');
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      interval: 80,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          value.toInt().toString(),
                          style: AppTextStyles.regular12,
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: false,
                ),
                barGroups: _getBarGroups(),
                barTouchData: BarTouchData(
                  enabled: true,
                  touchTooltipData: BarTouchTooltipData(
                    // tooltipBgColor: Colors.black87,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      String label =
                          rodIndex == 0 ? AppStrings.charge : AppStrings.bay;
                      return BarTooltipItem(
                        '$label: ${rod.toY.toStringAsFixed(0)}',
                        AppTextStyles.regular12,
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: MyResponsive.height(value: 16)),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildLegendItem(AppStrings.charge, AppColors.primary),
              SizedBox(width: MyResponsive.width(value: 24)),
              _buildLegendItem(AppStrings.bay, AppColors.secondary),
            ],
          ),
        ],
      ),
    );
  }

  double _getMaxY() {
    double max = 0;
    for (var point in data) {
      if (point.charge > max) max = point.charge;
      if (point.payment > max) max = point.payment;
    }
    return (max * 1.2).ceilToDouble();
  }

  List<BarChartGroupData> _getBarGroups() {
    return List.generate(
      data.length,
      (index) => _makeGroupData(
        index,
        data[index].charge,
        data[index].payment,
      ),
    );
  }

  BarChartGroupData _makeGroupData(int x, double charge, double payment) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: charge,
          color: AppColors.secondary,
          width: MyResponsive.width(value: 16),
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 200)),
        ),
        BarChartRodData(
          toY: payment,
          color: AppColors.primary,
          width: MyResponsive.width(value: 16),
          borderRadius: BorderRadius.circular(MyResponsive.radius(value: 200)),
        ),
      ],
      barsSpace: MyResponsive.width(value: 4),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: MyResponsive.width(value: 12),
          height: MyResponsive.width(value: 12),
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: MyResponsive.width(value: 8)),
        Text(
          label,
          style: AppTextStyles.regular12,
        ),
      ],
    );
  }
}

class ChartDataPoint {
  final String date;
  final double charge;
  final double payment;

  ChartDataPoint({
    required this.date,
    required this.charge,
    required this.payment,
  });
}
