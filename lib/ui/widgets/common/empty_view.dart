// path: lib/ui/widgets/common/empty_view.dart
// Reusable empty-state widget per Implementation Plan "Cross-Cutting: Error/Empty patterns".
import 'package:FlutterApp/constants/app_images.dart';
import 'package:FlutterApp/constants/app_spacing.dart';
import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({
    super.key,
    this.title,
    this.subtitle,
    this.imageConst = AppImages.emptyMatches,
    this.primaryAction,
  });

  final String? title;
  final String? subtitle;
  final String imageConst;
  final Widget? primaryAction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: Insets.allLg,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(imageConst),
          Gaps.hMd,
          if (title != null)
            Text(
              title!,
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          if (subtitle != null) ...[
            Gaps.hSm,
            Text(
              subtitle!,
              style: theme.textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
          if (primaryAction != null) ...[Gaps.hLg, primaryAction!],
        ],
      ),
    );
  }
}
