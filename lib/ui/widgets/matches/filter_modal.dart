// path: lib/ui/widgets/matches/filter_modal.dart
// Bottom sheet for Matches filters: date picker + segmented view (All/Live/Final).
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/widgets/common/segmented_tabs.dart';
import 'package:flutter/material.dart';

/// Result of the filter modal.
class MatchesFilter {
  const MatchesFilter({required this.date, required this.segmentIndex});
  final DateTime date; // Calendar date to load
  final int segmentIndex; // 0: All, 1: Live, 2: Final
}

/// Shows the filter modal and returns user's selection (or null if dismissed).
Future<MatchesFilter?> showMatchesFilterModal({
  required BuildContext context,
  required DateTime initialDate,
  int initialSegment = 0,
}) async {
  var selectedDate = DateTime(
    initialDate.year,
    initialDate.month,
    initialDate.day,
  );
  var segment = initialSegment;

  return showModalBottomSheet<MatchesFilter>(
    context: context,
    useSafeArea: true,
    backgroundColor: Theme.of(context).colorScheme.surface,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setState) {
          return Padding(
            padding: Insets.allMd,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 36,
                  height: 4,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(ctx).colorScheme.outline.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                Text('Filters', style: Theme.of(ctx).textTheme.titleMedium),
                Gaps.hMd,
                // Segmented view selector
                SegmentedTabs(
                  segments: const ['All', 'Live', 'Final'],
                  currentIndex: segment,
                  semanticsPrefix: 'Matches segment',
                  onChanged: (i) => setState(() => segment = i),
                ),
                Gaps.hMd,
                // Date selector row
                Row(
                  children: [
                    Text('Date', style: Theme.of(ctx).textTheme.titleSmall),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        final now = DateTime.now();
                        final d = await showDatePicker(
                          context: ctx,
                          initialDate: selectedDate,
                          firstDate: DateTime(now.year - 2),
                          lastDate: DateTime(now.year + 2),
                        );
                        if (d != null) {
                          setState(
                            () =>
                                selectedDate = DateTime(d.year, d.month, d.day),
                          );
                        }
                      },
                      child: Text(
                        '${selectedDate.year.toString().padLeft(4, '0')}-'
                        '${selectedDate.month.toString().padLeft(2, '0')}-'
                        '${selectedDate.day.toString().padLeft(2, '0')}',
                      ),
                    ),
                  ],
                ),
                Gaps.hLg,
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.of(ctx).pop<MatchesFilter>(),
                        child: const Text('Cancel'),
                      ),
                    ),
                    Gaps.wSm,
                    Expanded(
                      child: FilledButton(
                        onPressed: () {
                          Navigator.of(ctx).pop<MatchesFilter>(
                            MatchesFilter(
                              date: selectedDate,
                              segmentIndex: segment,
                            ),
                          );
                        },
                        child: const Text('Apply'),
                      ),
                    ),
                  ],
                ),
                Gaps.hSm,
              ],
            ),
          );
        },
      );
    },
  );
}
