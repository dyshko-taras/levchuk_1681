import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsBarChart extends StatelessWidget {
  const StatsBarChart({
    required this.data,
    required this.xLabels,
    super.key,
  });

  final Map<String, int> data;
  final List<String> xLabels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    // Prepare data for fl_chart
    final barGroups = xLabels.asMap().entries.map((entry) {
      final index = entry.key;
      final label = entry.value;
      final value = data[label] ?? 0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: value.toDouble(),
            color: AppColors.successGreen,
            width: 20,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    }).toList();

    return Container(
      padding: Insets.allMd,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        children: [
          // Chart area
          SizedBox(
            height: 140,
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 50,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 &&
                            value.toInt() < xLabels.length) {
                          final label = xLabels[value.toInt()];
                          final barValue = data[label] ?? 0;
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                barValue.toString(),
                                style: theme.labelSmall?.copyWith(
                                  color: AppColors.textWhite,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                label,
                                style: theme.labelSmall?.copyWith(
                                  color: AppColors.textGray,
                                ),
                              ),
                            ],
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                barTouchData: BarTouchData(
                  touchTooltipData: BarTouchTooltipData(
                    getTooltipColor: (group) => AppColors.cardDark,
                    getTooltipItem: (group, groupIndex, rod, rodIndex) {
                      return BarTooltipItem(
                        '${rod.toY.toInt()}',
                        theme.labelSmall?.copyWith(
                              color: AppColors.textWhite,
                            ) ??
                            const TextStyle(),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
