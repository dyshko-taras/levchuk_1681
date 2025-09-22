import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/widgets/common/counter_card.dart';
import 'package:flutter/material.dart';

/// Three counters row (Predicted / Upcoming / Completed) used on Match Schedule.
class CountersTriple extends StatelessWidget {
  const CountersTriple({
    required this.predicted,
    required this.upcoming,
    required this.completed,
    super.key,
    this.onTapPredicted,
    this.onTapUpcoming,
    this.onTapCompleted,
  });

  final int predicted;
  final int upcoming;
  final int completed;
  final VoidCallback? onTapPredicted;
  final VoidCallback? onTapUpcoming;
  final VoidCallback? onTapCompleted;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CounterCard(
            label: AppStrings.matchScheduleCountersPredicted,
            value: predicted,
            accent: CounterAccent.blue,
            onTap: onTapPredicted,
          ),
        ),
        Gaps.wMd,
        Expanded(
          child: CounterCard(
            label: AppStrings.matchScheduleCountersUpcoming,
            value: upcoming,
            accent: CounterAccent.yellow,
            onTap: onTapUpcoming,
          ),
        ),
        Gaps.wMd,
        Expanded(
          child: CounterCard(
            label: AppStrings.matchScheduleCountersCompleted,
            value: completed,
            onTap: onTapCompleted,
          ),
        ),
      ],
    );
  }
}
