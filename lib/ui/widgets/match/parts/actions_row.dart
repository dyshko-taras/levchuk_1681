import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:FlutterApp/ui/widgets/match/parts/card_cta.dart';
import 'package:flutter/material.dart';

class CardAction {
  const CardAction({
    required this.label,
    required this.variant,
    required this.icon,
    this.onPressed,
    this.enabled = true,
  });

  final String label;
  final CardCtaVariant variant;
  final VoidCallback? onPressed;
  final bool enabled;
  final String icon;
}

class ActionsRow extends StatelessWidget {
  const ActionsRow({
    required this.actions,
    super.key,
  });

  final List<CardAction> actions;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < actions.length; i++) ...[
          Expanded(
            child: CardCTA(
              label: actions[i].label,
              variant: actions[i].variant,
              onPressed: actions[i].onPressed,
              enabled: actions[i].enabled,
              leadingIcon: actions[i].icon,
            ),
          ),
          if (i != actions.length - 1) Gaps.wSm,
        ],
      ],
    );
  }
}
