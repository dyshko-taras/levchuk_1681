import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/data/models/team_ref.dart';
import 'package:FlutterApp/ui/widgets/match/parts/team_badge.dart';
import 'package:FlutterApp/ui/widgets/match/parts/team_pill.dart';
import 'package:flutter/material.dart';

class TeamsRow extends StatelessWidget {
  const TeamsRow({
    required this.home,
    required this.away,
    super.key,
  });

  final TeamRef home;
  final TeamRef away;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TeamBadge(logoUrl: home.logo),
        Gaps.wXs,
        Expanded(child: TeamPill(name: home.name)),
        Gaps.wMd,
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: TeamPill(
              name: away.name,
              alignment: Alignment.centerRight,
            ),
          ),
        ),
        Gaps.wXs,
        TeamBadge(logoUrl: away.logo),
      ],
    );
  }
}
