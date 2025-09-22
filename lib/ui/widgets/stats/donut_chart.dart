import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatsDonutChart extends StatelessWidget {
  const StatsDonutChart({
    required this.data,
    required this.legend,
    super.key,
  });

  final Map<String, int> data;
  final List<DonutLegendItem> legend;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    // Prepare data for fl_chart
    final total = data.values.fold(0, (a, b) => a + b);
    if (total == 0) {
      return Container(
        padding: Insets.allMd,
        decoration: const BoxDecoration(
          color: AppColors.cardDark,
          borderRadius: AppRadius.cardLg,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 200,
              child: Center(
                child: Text(
                  'No data available',
                  style: theme.bodyMedium?.copyWith(
                    color: AppColors.textGray,
                  ),
                ),
              ),
            ),
            Gaps.hMd,
            // Legend
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: legend.map((item) => _LegendItem(item: item)).toList(),
            ),
          ],
        ),
      );
    }

    final pieData = <PieChartSectionData>[];

    // Home wins (blue)
    final homeCount = data['home'] ?? 0;
    if (homeCount > 0) {
      final homePercentage = (homeCount / total * 100).round();
      pieData.add(
        PieChartSectionData(
          color: AppColors.accentBlue,
          value: homeCount.toDouble(),
          title: '$homePercentage%',
          radius: 60,
          titleStyle: theme.labelSmall,
        ),
      );
    }

    // Draws (red)
    final drawCount = data['draw'] ?? 0;
    if (drawCount > 0) {
      final drawPercentage = (drawCount / total * 100).round();
      pieData.add(
        PieChartSectionData(
          color: AppColors.errorRed,
          value: drawCount.toDouble(),
          title: '$drawPercentage%',
          radius: 60,
          titleStyle: theme.labelSmall,
        ),
      );
    }

    // Away wins (orange)
    final awayCount = data['away'] ?? 0;
    if (awayCount > 0) {
      final awayPercentage = (awayCount / total * 100).round();
      pieData.add(
        PieChartSectionData(
          color: AppColors.accentOrange,
          value: awayCount.toDouble(),
          title: '$awayPercentage%',
          radius: 60,
          titleStyle: theme.labelSmall,
        ),
      );
    }

    return Container(
      padding: Insets.allMd,
      decoration: const BoxDecoration(
        color: AppColors.cardDark,
        borderRadius: AppRadius.cardLg,
      ),
      child: Column(
        children: [
          // Donut chart
          SizedBox(
            height: 200,
            child: PieChart(
              PieChartData(
                pieTouchData: PieTouchData(
                  touchCallback: (FlTouchEvent event, pieTouchResponse) {
                    // Handle touch events if needed
                  },
                ),
                borderData: FlBorderData(show: false),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
                sections: pieData,
              ),
            ),
          ),
          Gaps.hMd,
          // Legend
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: legend.map((item) => _LegendItem(item: item)).toList(),
          ),
        ],
      ),
    );
  }
}

class DonutLegendItem {
  const DonutLegendItem({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.item});

  final DonutLegendItem item;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: item.color,
            shape: BoxShape.circle,
          ),
        ),
        Gaps.wXs,
        Text(
          item.label,
          style: theme.bodySmall?.copyWith(
            color: AppColors.textGray,
          ),
        ),
      ],
    );
  }
}
