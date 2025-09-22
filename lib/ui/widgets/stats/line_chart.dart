import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsLineChart extends StatelessWidget {
  const StatsLineChart({
    required this.data,
    required this.xLabels,
    super.key,
  });

  final List<double> data;
  final List<String> xLabels;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    if (data.isEmpty) {
      return Container(
        padding: Insets.allMd,
        decoration: const BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: AppRadius.cardLg,
        ),
        child: SizedBox(
          height: 140,
          child: Center(
            child: Text(
              'No data available',
              style: theme.bodyMedium?.copyWith(
                color: AppColors.textGray,
              ),
            ),
          ),
        ),
      );
    }

    // Prepare data for fl_chart
    final spots = data.asMap().entries.map((entry) {
      return FlSpot(entry.key.toDouble(), entry.value);
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
            child: LineChart(
              LineChartData(
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: AppColors.successGreen,
                    barWidth: 3,
                    isStrokeCapRound: true,
                    dotData: FlDotData(
                      getDotPainter: (spot, percent, barData, index) {
                        return FlDotCirclePainter(
                          radius: 4,
                          color: AppColors.successGreen,
                          strokeWidth: 2,
                          strokeColor: AppColors.primaryBlack,
                        );
                      },
                    ),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.successGreen.withOpacity(0.1),
                    ),
                  ),
                ],
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          '${value.toInt()}%',
                          style: theme.labelSmall?.copyWith(
                            color: AppColors.textGray,
                          ),
                        );
                      },
                      reservedSize: 40,
                    ),
                  ),
                  topTitles: const AxisTitles(
                    
                  ),
                  rightTitles: const AxisTitles(
                    
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        if (value.toInt() >= 0 && value.toInt() < xLabels.length) {
                          return Text(
                            xLabels[value.toInt()],
                            style: theme.labelSmall?.copyWith(
                              color: AppColors.textGray,
                            ),
                          );
                        }
                        return const Text('');
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(
                    color: AppColors.borderGray,
                  ),
                ),
                gridData: FlGridData(
                  drawVerticalLine: false,
                  horizontalInterval: 20,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: AppColors.borderGray.withOpacity(0.3),
                      strokeWidth: 1,
                    );
                  },
                ),
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => AppColors.cardDark,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((touchedSpot) {
                        return LineTooltipItem(
                          '${touchedSpot.y.toInt()}%',
                          theme.labelSmall?.copyWith(
                            color: AppColors.textWhite,
                          ) ?? const TextStyle(),
                        );
                      }).toList();
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
