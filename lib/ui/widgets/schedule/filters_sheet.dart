import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:flutter/material.dart';

class ScheduleFilterValue {
  const ScheduleFilterValue({
    this.leagues = const <int>{},
    this.countries = const <String>{},
    this.statuses = const <String>{},
    this.favoritesOnly = false,
  });

  final Set<int> leagues;
  final Set<String> countries;
  final Set<String> statuses;
  final bool favoritesOnly;

  ScheduleFilterValue copyWith({
    Set<int>? leagues,
    Set<String>? countries,
    Set<String>? statuses,
    bool? favoritesOnly,
  }) {
    return ScheduleFilterValue(
      leagues: leagues ?? this.leagues,
      countries: countries ?? this.countries,
      statuses: statuses ?? this.statuses,
      favoritesOnly: favoritesOnly ?? this.favoritesOnly,
    );
  }

  ScheduleFilterValue cleared() => const ScheduleFilterValue();
}

class FilterOption<T> {
  const FilterOption({required this.value, required this.label});

  final T value;
  final String label;
}

Future<ScheduleFilterValue?> showScheduleFiltersSheet({
  required BuildContext context,
  required ScheduleFilterValue initialValue,
  required List<FilterOption<int>> leagues,
  required List<FilterOption<String>> countries,
  required List<FilterOption<String>> statuses,
}) {
  return showModalBottomSheet<ScheduleFilterValue>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: AppColors.primaryBlack,
    builder: (ctx) {
      // ВАЖЛИВО: без FractionallySizedBox — висота = мінімально необхідна
      return _ScheduleFiltersSheet(
        initialValue: initialValue,
        leagues: leagues,
        countries: countries,
        statuses: statuses,
      );
    },
  );
}

class _ScheduleFiltersSheet extends StatefulWidget {
  const _ScheduleFiltersSheet({
    required this.initialValue,
    required this.leagues,
    required this.countries,
    required this.statuses,
  });

  final ScheduleFilterValue initialValue;
  final List<FilterOption<int>> leagues;
  final List<FilterOption<String>> countries;
  final List<FilterOption<String>> statuses;

  @override
  State<_ScheduleFiltersSheet> createState() => _ScheduleFiltersSheetState();
}

class _ScheduleFiltersSheetState extends State<_ScheduleFiltersSheet> {
  late Set<int> _selectedLeagues;
  late Set<String> _selectedCountries;
  late Set<String> _selectedStatuses;
  late bool _favoritesOnly;

  @override
  void initState() {
    super.initState();
    final initial = widget.initialValue;
    _selectedLeagues = initial.leagues.toSet();
    _selectedCountries = initial.countries.toSet();
    _selectedStatuses = initial.statuses.toSet();
    _favoritesOnly = initial.favoritesOnly;
  }

  void _toggleLeague(int value) {
    setState(() {
      if (_selectedLeagues.contains(value)) {
        _selectedLeagues.remove(value);
      } else {
        _selectedLeagues.add(value);
      }
    });
  }

  void _toggleCountry(String value) {
    setState(() {
      if (_selectedCountries.contains(value)) {
        _selectedCountries.remove(value);
      } else {
        _selectedCountries.add(value);
      }
    });
  }

  void _toggleStatus(String value) {
    setState(() {
      if (_selectedStatuses.contains(value)) {
        _selectedStatuses.remove(value);
      } else {
        _selectedStatuses.add(value);
      }
    });
  }

  void _toggleFavorites() {
    setState(() => _favoritesOnly = !_favoritesOnly);
  }

  void _handleReset() {
    setState(() {
      _selectedLeagues.clear();
      _selectedCountries.clear();
      _selectedStatuses.clear();
      _favoritesOnly = false;
    });
  }

  void _handleApply() {
    Navigator.of(context).pop(
      ScheduleFilterValue(
        leagues: _selectedLeagues,
        countries: _selectedCountries,
        statuses: _selectedStatuses,
        favoritesOnly: _favoritesOnly,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final padding = EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.lg,
      AppSpacing.lg + bottomInset,
    );

    return SafeArea(
      child: SingleChildScrollView(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min, // ключ до мінімальної висоти
          children: [
            Center(
              child: Container(
                width: 48,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.borderGray,
                  borderRadius: AppRadius.chipRadius,
                ),
              ),
            ),
            Gaps.hLg,
            Text(
              AppStrings.matchScheduleFilterSectionLeagues,
              style: theme.textTheme.titleMedium,
            ),
            Gaps.hSm,
            _ChipsWrap<int>(
              options: widget.leagues,
              isSelected: _selectedLeagues.contains,
              onToggle: _toggleLeague,
            ),
            Gaps.hLg,
            Text(
              AppStrings.matchScheduleFilterSectionCountry,
              style: theme.textTheme.titleMedium,
            ),
            Gaps.hSm,
            _ChipsWrap<String>(
              options: widget.countries,
              isSelected: _selectedCountries.contains,
              onToggle: _toggleCountry,
            ),
            if (widget.statuses.isNotEmpty) ...[
              Gaps.hLg,
              Text(
                AppStrings.matchScheduleFilterSectionStatus,
                style: theme.textTheme.titleMedium,
              ),
              Gaps.hSm,
              _ChipsWrap<String>(
                options: widget.statuses,
                isSelected: _selectedStatuses.contains,
                onToggle: _toggleStatus,
              ),
            ],
            Gaps.hLg,
            _FavoritesToggle(
              active: _favoritesOnly,
              onTap: _toggleFavorites,
            ),
            Gaps.hLg,
            Row(
              children: [
                Expanded(
                  child: _ResetButton(onTap: _handleReset),
                ),
                Gaps.wSm,
                Expanded(
                  child: PrimaryButton(
                    label: AppStrings.matchScheduleFilterApply,
                    onPressed: _handleApply,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ChipsWrap<T> extends StatelessWidget {
  const _ChipsWrap({
    required this.options,
    required this.isSelected,
    required this.onToggle,
  });

  final List<FilterOption<T>> options;
  final bool Function(T value) isSelected;
  final ValueChanged<T> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        for (final option in options)
          _FilterChip<T>(
            label: option.label,
            selected: isSelected(option.value),
            onTap: () => onToggle(option.value),
          ),
      ],
    );
  }
}

class _FilterChip<T> extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = selected ? AppColors.warningYellow : Colors.transparent;
    final fg = selected ? AppColors.primaryBlack : AppColors.textWhite;
    final borderColor = selected
        ? AppColors.warningYellow
        : AppColors.borderGray;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.chipHeight,
        padding: Insets.hMd,
        decoration: BoxDecoration(
          color: bg,
          borderRadius: AppRadius.chipRadius,
          border: Border.all(color: borderColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Icons.check : Icons.add,
              size: AppSizes.iconSm,
              color: fg,
            ),
            Gaps.wXs,
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FavoritesToggle extends StatelessWidget {
  const _FavoritesToggle({required this.active, required this.onTap});

  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    const bg = AppColors.warningYellow;
    const fg = AppColors.primaryBlack;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: Insets.vSm.add(Insets.hMd),
        decoration: const BoxDecoration(
          color: bg,
          borderRadius: AppRadius.btnLg,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              active ? Icons.star : Icons.star_border,
              size: AppSizes.iconSm,
              color: fg,
            ),
            Gaps.wSm,
            Text(
              AppStrings.matchScheduleFilterShowFavorites,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: fg,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetButton extends StatelessWidget {
  const _ResetButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.buttonHeightMd,
      child: Material(
        color: AppColors.textWhite,
        borderRadius: AppRadius.btnLg,
        child: InkWell(
          borderRadius: AppRadius.btnLg,
          onTap: onTap,
          child: Center(
            child: Text(
              AppStrings.matchScheduleFilterReset,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: AppColors.primaryBlack,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
