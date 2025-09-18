// path: lib/ui/widgets/common/error_view.dart
// Reusable error-state widget with message and optional retry.
import 'package:flutter/material.dart';
import '../../../constants/app_icons.dart';
import '../../../constants/app_spacing.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ErrorView extends StatelessWidget {
  const ErrorView({
    super.key,
    required this.message,
    this.onRetry,
    this.retryLabel = 'Retry',
  });

  final String message;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: Insets.allMd,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(AppIcons.statusError),
          Gaps.hMd,
          Text(
            'Something went wrong',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Gaps.hSm,
          Text(
            message,
            style: theme.textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
          if (onRetry != null) ...[
            Gaps.hMd,
            FilledButton(onPressed: onRetry, child: Text(retryLabel)),
          ],
        ],
      ),
    );
  }
}
