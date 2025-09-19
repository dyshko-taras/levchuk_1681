import 'package:flutter/material.dart';

class LeagueHeader extends StatelessWidget {
  const LeagueHeader({
    required this.leagueName,
    this.countryName,
    super.key,
  });

  final String leagueName;
  final String? countryName;

  @override
  Widget build(BuildContext context) {
    final country = (countryName?.isNotEmpty ?? false)
        ? ' (${countryName!})'
        : '';
    return Row(
      children: [
        Expanded(
          child: Text(
            '🌍 $leagueName$country',
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
