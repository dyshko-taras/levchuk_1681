// path: lib/ui/pages/match_schedule_page.dart
// Rebuild per PRD: CustomScrollView with pinned day tabs, counters row, Filter button, and MatchCard list.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/providers/matches_provider.dart';
import 'package:FlutterApp/ui/widgets/common/empty_view.dart';
import 'package:FlutterApp/ui/widgets/common/error_view.dart';
import 'package:FlutterApp/ui/widgets/matches/day_segmented_tabs.dart';
import 'package:FlutterApp/ui/widgets/matches/match_card.dart';
import 'package:FlutterApp/ui/widgets/matches/stat_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class MatchSchedulePage extends StatelessWidget {
  const MatchSchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MatchesProvider>(
      create: (_) => MatchesProvider(context.read<MatchesRepository>())..load(),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  const _Body();
 
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<MatchesProvider>();
    final s = vm.state;

    Future<void> onRefresh() => vm.refresh();

    // ---- AppBar title per PRD
    const appBar = SliverAppBar(
      pinned: true,
      title: Text('MATCH SCHEDULE'),
    );

    // ---- Day tabs (pinned header)
    final dayTabs = SliverPersistentHeader(
      pinned: true,
      delegate: _HeaderDelegate(
        minExtent: AppSizes.segmentedTabHeaderHeight,
        maxExtent: AppSizes.segmentedTabHeaderHeight,
        child: Padding(
          padding: Insets.hMd,
          child: DaySegmentedTabs(
            index: s.selectedDayId == 'yesterday'
                ? 0
                : s.selectedDayId == 'tomorrow'
                ? 2
                : 1,
            onChanged: (i) {
              if (i == 0) vm.setRelativeDate(-1);
              if (i == 1) vm.setRelativeDate(0);
              if (i == 2) vm.setRelativeDate(1);
            },
          ),
        ),
      ),
    );

    // ---- Counters
    final counters = SliverToBoxAdapter(
      child: Padding(
        padding: Insets.allMd,
        child: Row(
          children: [
            Expanded(
              child: StatBadge(value: s.predicted, label: 'Predicted'),
            ),
            Gaps.wMd,
            Expanded(
              child: StatBadge(value: s.upcoming, label: 'Upcoming'),
            ),
            Gaps.wMd,
            Expanded(
              child: StatBadge(value: s.completed, label: 'Completed'),
            ),
          ],
        ),
      ),
    );

    // ---- Filter Button
    final filterBtn = SliverToBoxAdapter(
      child: Padding(
        padding: Insets.hMd,
        child: FilledButton.icon(
          onPressed: () {
            // Opens filter modal (added earlier in Phase 10); leave action as is.
            // ignore: discarded_futures
            // showMatchesFilterModal(context: context, initialDate: s.date);
          },
          icon: SvgPicture.asset(AppIcons.actionFilter),
          label: const Text('Filter'),
        ),
      ),
    );

    // ---- Conditional content
    final slivers = <Widget>[
      appBar,
      dayTabs,
      counters,
      filterBtn,
    ];

    if (s.isLoading) {
      slivers.add(
        const SliverFillRemaining(
          hasScrollBody: false,
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    } else if (s.error != null) {
      slivers.add(
        SliverFillRemaining(
          hasScrollBody: false,
          child: ErrorView(
            message: s.error!,
            onRetry: vm.load,
          ),
        ),
      );
    } else if (s.items.isEmpty) {
      slivers.add(
        const SliverFillRemaining(
          hasScrollBody: false,
          child: EmptyView(),
        ),
      );
    } else {
      slivers.add(
        SliverList.separated(
          itemCount: s.items.length,
          separatorBuilder: (_, __) => Gaps.hMd,
          itemBuilder: (context, index) => Padding(
            padding: Insets.hMd,
            child: MatchCard(fixture: s.items[index]),
          ),
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(slivers: slivers),
    );
  }
}

class _HeaderDelegate extends SliverPersistentHeaderDelegate {
  _HeaderDelegate({
    required this.child,
    required this.minExtent,
    required this.maxExtent,
  });
  final Widget child;
  @override
  final double minExtent;
  @override
  final double maxExtent;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) => child;

  @override
  bool shouldRebuild(covariant _HeaderDelegate oldDelegate) => false;
}
