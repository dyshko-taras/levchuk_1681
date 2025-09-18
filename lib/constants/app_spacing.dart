// path: lib/constants/app_spacing.dart
// Spacing helpers per Visual Style scale: XS 6, SM 9, MD 15, LG 24, XL 36.
import 'package:flutter/widgets.dart';

/// Numeric spacing tokens.
/// Usage: AppSpacing.md, etc.
abstract final class AppSpacing {
  static const double xs = 6;
  static const double sm = 9;
  static const double md = 15;
  static const double lg = 24;
  static const double xl = 36;
}

/// Ready-to-use SizedBoxes for quick gaps.
/// Usage: Gaps.hMd, Gaps.wSm, etc.
abstract final class Gaps {
  // Horizontal (width)
  static const SizedBox wXs = SizedBox(width: AppSpacing.xs);
  static const SizedBox wSm = SizedBox(width: AppSpacing.sm);
  static const SizedBox wMd = SizedBox(width: AppSpacing.md);
  static const SizedBox wLg = SizedBox(width: AppSpacing.lg);
  static const SizedBox wXl = SizedBox(width: AppSpacing.xl);

  // Vertical (height)
  static const SizedBox hXs = SizedBox(height: AppSpacing.xs);
  static const SizedBox hSm = SizedBox(height: AppSpacing.sm);
  static const SizedBox hMd = SizedBox(height: AppSpacing.md);
  static const SizedBox hLg = SizedBox(height: AppSpacing.lg);
  static const SizedBox hXl = SizedBox(height: AppSpacing.xl);
}

/// Ready EdgeInsets constants for common paddings/margins.
/// Usage: Insets.allMd, Insets.hLg, Insets.vSm, Insets.symmetric(h:..., v:...) etc.
abstract final class Insets {
  // All
  static const EdgeInsets allXs = EdgeInsets.all(AppSpacing.xs);
  static const EdgeInsets allSm = EdgeInsets.all(AppSpacing.sm);
  static const EdgeInsets allMd = EdgeInsets.all(AppSpacing.md);
  static const EdgeInsets allLg = EdgeInsets.all(AppSpacing.lg);
  static const EdgeInsets allXl = EdgeInsets.all(AppSpacing.xl);

  // Symmetric
  static const EdgeInsets hXs = EdgeInsets.symmetric(horizontal: AppSpacing.xs);
  static const EdgeInsets hSm = EdgeInsets.symmetric(horizontal: AppSpacing.sm);
  static const EdgeInsets hMd = EdgeInsets.symmetric(horizontal: AppSpacing.md);
  static const EdgeInsets hLg = EdgeInsets.symmetric(horizontal: AppSpacing.lg);
  static const EdgeInsets hXl = EdgeInsets.symmetric(horizontal: AppSpacing.xl);

  static const EdgeInsets vXs = EdgeInsets.symmetric(vertical: AppSpacing.xs);
  static const EdgeInsets vSm = EdgeInsets.symmetric(vertical: AppSpacing.sm);
  static const EdgeInsets vMd = EdgeInsets.symmetric(vertical: AppSpacing.md);
  static const EdgeInsets vLg = EdgeInsets.symmetric(vertical: AppSpacing.lg);
  static const EdgeInsets vXl = EdgeInsets.symmetric(vertical: AppSpacing.xl);
}

/// Convenience extension for inline numeric spacing in code samples:
/// `16.h` → SizedBox(height: 16), `8.w` → SizedBox(width: 8).
extension NumSpaceExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
