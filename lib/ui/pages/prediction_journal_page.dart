// path: lib/ui/pages/prediction_journal_page.dart
// Prediction journal page with daily timeline and notes.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/constants/app_routes.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/providers/prediction_journal_provider.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/common/app_bar_actions.dart';
import 'package:FlutterApp/ui/widgets/common/segmented_tabs.dart';
import 'package:FlutterApp/ui/widgets/journal/journal_notes_section.dart';
import 'package:FlutterApp/ui/widgets/journal/journal_summary_grid.dart';
import 'package:FlutterApp/ui/widgets/predictions/prediction_card.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class PredictionJournalPage extends StatefulWidget {
  const PredictionJournalPage({super.key});

  @override
  State<PredictionJournalPage> createState() => _PredictionJournalPageState();
}

class _PredictionJournalPageState extends State<PredictionJournalPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<PredictionJournalProvider>().loadForDate(
        DateTime.now(),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PredictionJournalProvider>(
        builder: (context, provider, child) {
          final state = provider.state;

          final slivers = <Widget>[];

          if (state.isLoading) {
            slivers.add(
              const SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColors.successGreen,
                  ),
                ),
              ),
            );
          } else if (state.error != null) {
            slivers.add(
              SliverFillRemaining(
                hasScrollBody: false,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Error loading journal',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Gaps.hMd,
                      ElevatedButton(
                        onPressed: () =>
                            provider.loadForDate(state.selectedDate),
                        child: const Text('Retry'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            slivers
              ..add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Insets.allMd,
                    child: AppBarActions(
                      title: AppStrings.journalTitle,
                      leftIcon: AppIcons.actionBack,
                      rightIcon: AppIcons.actionCalendar,
                      onRight: _showDatePicker,
                      onLeft: () =>
                          Navigator.of(context).pushNamed(AppRoutes.profile),
                    ),
                  ),
                ),
              )
              // Header with day selector tabs
              ..add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Insets.allMd,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SegmentedTabs(
                          items: _buildTabItems(state.selectedDate),
                          selectedId: _getSelectedTabId(state.selectedDate),
                          onChange: (id) => _onTabChange(id, provider),
                        ),
                      ],
                    ),
                  ),
                ),
              );

            // Predictions list (compact empty state)
            if (state.timeline.isEmpty) {
              slivers.add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Insets.vMd,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.sports_soccer,
                          size: AppSizes.imageLg,
                          color: AppColors.textGray,
                        ),
                        Gaps.wSm,
                        Text(
                          'No predictions for this day',
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(color: AppColors.textGray),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              slivers.add(
                SliverList.builder(
                  itemCount: state.timeline.length,
                  itemBuilder: (context, index) {
                    final item = state.timeline[index];
                    return Padding(
                      padding: Insets.vMd,
                      child: PredictionCard(
                        prediction: item.prediction,
                        fixture: item.fixture,
                      ),
                    );
                  },
                ),
              );
            }

            // Notes section
            slivers
              ..add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Insets.allMd,
                    child: JournalNotesSection(
                      events: state.events,
                      onAddEvent: (event) => provider.addEvent(event),
                      onRemoveEvent: (event) => provider.removeEvent(event),
                    ),
                  ),
                ),
              )
              // Daily summary
              ..add(
                SliverToBoxAdapter(
                  child: Padding(
                    padding: Insets.allMd,
                    child: JournalSummaryGrid(summary: state.summary),
                  ),
                ),
              )
              // Bottom spacing
              ..add(
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.lg),
                ),
              );
          }

          return RefreshIndicator(
            onRefresh: () => provider.loadForDate(state.selectedDate),
            child: SafeArea(
              child: Padding(
                padding: Insets.hMd,
                child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: slivers,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<SegmentedTabItem> _buildTabItems(DateTime selectedDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));

    final selected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    // If selected date is yesterday, today, or tomorrow, show those labels
    if (selected.isAtSameMomentAs(yesterday)) {
      return const [
        SegmentedTabItem(id: 'yesterday', label: 'Yesterday'),
        SegmentedTabItem(id: 'today', label: 'Today'),
        SegmentedTabItem(id: 'tomorrow', label: 'Tomorrow'),
      ];
    } else if (selected.isAtSameMomentAs(today)) {
      return const [
        SegmentedTabItem(id: 'yesterday', label: 'Yesterday'),
        SegmentedTabItem(id: 'today', label: 'Today'),
        SegmentedTabItem(id: 'tomorrow', label: 'Tomorrow'),
      ];
    } else if (selected.isAtSameMomentAs(tomorrow)) {
      return const [
        SegmentedTabItem(id: 'yesterday', label: 'Yesterday'),
        SegmentedTabItem(id: 'today', label: 'Today'),
        SegmentedTabItem(id: 'tomorrow', label: 'Tomorrow'),
      ];
    } else {
      // For custom dates, show the formatted date
      final dateFormatter = DateFormat('MMM d');
      final customDateLabel = dateFormatter.format(selectedDate);

      return [
        const SegmentedTabItem(id: 'yesterday', label: 'Yesterday'),
        const SegmentedTabItem(id: 'today', label: 'Today'),
        SegmentedTabItem(id: 'custom', label: customDateLabel),
      ];
    }
  }

  String _getSelectedTabId(DateTime selectedDate) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));
    final tomorrow = today.add(const Duration(days: 1));

    final selected = DateTime(
      selectedDate.year,
      selectedDate.month,
      selectedDate.day,
    );

    if (selected.isAtSameMomentAs(yesterday)) {
      return 'yesterday';
    } else if (selected.isAtSameMomentAs(tomorrow)) {
      return 'tomorrow';
    } else if (selected.isAtSameMomentAs(today)) {
      return 'today';
    } else {
      return 'custom';
    }
  }

  Future<void> _onTabChange(
    String tabId,
    PredictionJournalProvider provider,
  ) async {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);

    switch (tabId) {
      case 'yesterday':
        await provider.loadForDate(today.subtract(const Duration(days: 1)));
        return;
      case 'today':
        await provider.loadForDate(today);
        return;
      case 'tomorrow':
        await provider.loadForDate(today.add(const Duration(days: 1)));
        return;
      case 'custom':
        // For custom date, keep the current selected date
        await provider.loadForDate(provider.state.selectedDate);
        return;
    }
  }

  Future<void> _showDatePicker() async {
    final provider = context.read<PredictionJournalProvider>();
    final selectedDate = await showDatePicker(
      context: context,
      initialDate: provider.state.selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppColors.successGreen,
              onPrimary: AppColors.textWhite,
              surface: AppColors.cardDark,
            ),
          ),
          child: child!,
        );
      },
    );

    if (selectedDate != null) {
      await provider.loadForDate(selectedDate);
    }
  }
}
