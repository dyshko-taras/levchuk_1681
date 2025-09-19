// path: lib/ui/widgets/dialogs/add_to_favorites_dialog.dart
// Modal dialog allowing users to choose which entities to favorite.
import 'package:flutter/material.dart';

import 'package:FlutterApp/constants/app_radius.dart';
import 'package:FlutterApp/constants/app_sizes.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/constants/app_strings.dart';
import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:FlutterApp/ui/widgets/buttons/primary_button.dart';
import 'package:FlutterApp/ui/widgets/buttons/secondary_green_button_light.dart';

typedef AddToFavoritesSelection = ({
  bool league,
  bool homeTeam,
  bool awayTeam,
  bool match,
});

class AddToFavoritesDialog extends StatefulWidget {
  const AddToFavoritesDialog({
    required this.league,
    required this.homeTeam,
    required this.awayTeam,
    required this.onAdd,
    required this.onCancel,
    super.key,
    this.leagueSelected = true,
    this.homeTeamSelected = true,
    this.awayTeamSelected = true,
    this.matchSelected = true,
  });

  final String league;
  final String homeTeam;
  final String awayTeam;
  final ValueChanged<AddToFavoritesSelection> onAdd;
  final VoidCallback onCancel;
  final bool leagueSelected;
  final bool homeTeamSelected;
  final bool awayTeamSelected;
  final bool matchSelected;

  @override
  State<AddToFavoritesDialog> createState() => _AddToFavoritesDialogState();
}

class _AddToFavoritesDialogState extends State<AddToFavoritesDialog> {
  late bool _league;
  late bool _homeTeam;
  late bool _awayTeam;
  late bool _match;

  @override
  void initState() {
    super.initState();
    _league = widget.leagueSelected;
    _homeTeam = widget.homeTeamSelected;
    _awayTeam = widget.awayTeamSelected;
    _match = widget.matchSelected;
  }

  void _toggleLeague() => setState(() => _league = !_league);
  void _toggleHomeTeam() => setState(() => _homeTeam = !_homeTeam);
  void _toggleAwayTeam() => setState(() => _awayTeam = !_awayTeam);
  void _toggleMatch() => setState(() => _match = !_match);

  void _handleAdd() {
    if (!_hasAnySelection) {
      return;
    }
    widget.onAdd((
      league: _league,
      homeTeam: _homeTeam,
      awayTeam: _awayTeam,
      match: _match,
    ));
  }

  bool get _hasAnySelection => _league || _homeTeam || _awayTeam || _match;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final options = <_ToggleOption>[
      _ToggleOption(
        label: AppStrings.matchDetailsFavoriteLeague(widget.league),
        value: _league,
        onTap: _toggleLeague,
      ),
      _ToggleOption(
        label: AppStrings.matchDetailsFavoriteTeam(widget.homeTeam),
        value: _homeTeam,
        onTap: _toggleHomeTeam,
      ),
      _ToggleOption(
        label: AppStrings.matchDetailsFavoriteTeam(widget.awayTeam),
        value: _awayTeam,
        onTap: _toggleAwayTeam,
      ),
      _ToggleOption(
        label: AppStrings.matchDetailsFavoriteMatch(
          widget.homeTeam,
          widget.awayTeam,
        ),
        value: _match,
        onTap: _toggleMatch,
      ),
    ];

    return Dialog(
      backgroundColor: AppColors.primaryBlack,
      shape: RoundedRectangleBorder(borderRadius: AppRadius.cardLg),
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              AppStrings.matchDetailsAddToFavoritesTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.textWhite,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            Gaps.hLg,
            for (var i = 0; i < options.length; i++) ...[
              _FavoriteToggle(option: options[i]),
              if (i != options.length - 1) Gaps.hSm,
            ],
            Gaps.hLg,
            Row(
              children: [
                Expanded(
                  child: SecondaryGreenButtonLight(
                    label: AppStrings.cancel,
                    onPressed: widget.onCancel,
                  ),
                ),
                Gaps.wSm,
                Expanded(
                  child: PrimaryButton(
                    label: AppStrings.add,
                    onPressed: _hasAnySelection ? _handleAdd : null,
                    enabled: _hasAnySelection,
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

class _ToggleOption {
  const _ToggleOption({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final bool value;
  final VoidCallback onTap;
}

class _FavoriteToggle extends StatelessWidget {
  const _FavoriteToggle({required this.option});

  final _ToggleOption option;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderColor = option.value
        ? AppColors.warningYellow
        : AppColors.borderGray;
    final bgColor = option.value ? AppColors.cardDark : AppColors.primaryBlack;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: AppRadius.cardLg,
        onTap: option.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: AppRadius.cardLg,
            border: Border.all(
              color: borderColor,
              width: AppSizes.strokeThin,
            ),
          ),
          child: Row(
            children: [
              _SelectionIndicator(selected: option.value),
              Gaps.wSm,
              Expanded(
                child: Text(
                  option.label,
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppColors.textWhite,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SelectionIndicator extends StatelessWidget {
  const _SelectionIndicator({required this.selected});

  final bool selected;

  @override
  Widget build(BuildContext context) {
    final size = AppSizes.iconMd;
    final baseColor = selected ? AppColors.warningYellow : AppColors.borderGray;

    return SizedBox(
      width: size,
      height: size,
      child: DecoratedBox(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: selected ? baseColor : Colors.transparent,
          border: Border.all(color: baseColor, width: AppSizes.strokeThin),
        ),
        child: Center(
          child: selected
              ? CustomPaint(
                  size: Size.square(size * 0.5),
                  painter: _CheckPainter(color: AppColors.primaryBlack),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }
}

class _CheckPainter extends CustomPainter {
  const _CheckPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;

    final path = Path()
      ..moveTo(0, size.height * 0.6)
      ..lineTo(size.width * 0.4, size.height)
      ..lineTo(size.width, 0);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
