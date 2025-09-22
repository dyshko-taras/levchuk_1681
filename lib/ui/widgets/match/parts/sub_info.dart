import 'package:FlutterApp/ui/theme/app_colors.dart';
import 'package:flutter/material.dart';

enum SubInfoVariant { odds, predictionSummary, finished }

class SubInfo extends StatelessWidget {
  const SubInfo.odds({
    double? home,
    double? draw,
    double? away,
    super.key,
  }) : _variant = SubInfoVariant.odds,
       _homeOdd = home,
       _drawOdd = draw,
       _awayOdd = away,
       _text = null,
       _pick = null,
       _odds = null;

  const SubInfo.predictionSummary({
    required String pick,
    double? odds,
    super.key,
  }) : _variant = SubInfoVariant.predictionSummary,
       _text = null,
       _pick = pick,
       _odds = odds,
       _homeOdd = null,
       _drawOdd = null,
       _awayOdd = null;

  const SubInfo.finished({
    super.key,
    String text = 'Finished',
  }) : _variant = SubInfoVariant.finished,
       _text = text,
       _pick = null,
       _odds = null,
       _homeOdd = null,
       _drawOdd = null,
       _awayOdd = null;

  final SubInfoVariant _variant;
  final double? _homeOdd;
  final double? _drawOdd;
  final double? _awayOdd;
  final String? _text;
  final String? _pick;
  final double? _odds;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.bodySmall?.copyWith(
      color: AppColors.textGray,
      fontWeight: FontWeight.w500,
    );

    switch (_variant) {
      case SubInfoVariant.odds:
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _OddsTile(label: 'Home Win', value: _homeOdd),
            _OddsTile(label: 'Draw', value: _drawOdd),
            _OddsTile(label: 'Away Win', value: _awayOdd),
          ],
        );
      case SubInfoVariant.predictionSummary:
        final odds = _odds;
        var oddsText = '';
        if (odds != null) {
          oddsText = ' - Odds ${odds.toStringAsFixed(2)}';
        }
        return Text('Prediction: $_pick$oddsText', style: style);
      case SubInfoVariant.finished:
        return Text(_text ?? 'Finished', style: style);
    }
  }
}

class _OddsTile extends StatelessWidget {
  const _OddsTile({required this.label, required this.value});

  final String label;
  final double? value;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final odd = value;
    final valueText = odd == null || odd == 0 ? '--' : odd.toStringAsFixed(2);
    return RichText(
      text: TextSpan(
        text: '$label: ',
        style: theme.textTheme.bodySmall?.copyWith(color: AppColors.textGray),
        children: [
          TextSpan(
            text: valueText,
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppColors.textWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
