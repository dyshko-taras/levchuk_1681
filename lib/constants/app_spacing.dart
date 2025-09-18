import 'package:flutter/material.dart';

class AppSpacing {
  AppSpacing._();

  static const double xs = 6;
  static const double sm = 9;
  static const double md = 15;
  static const double lg = 24;
  static const double xl = 36;
}

class Gaps {
  Gaps._();

  static const SizedBox hXs = SizedBox(height: AppSpacing.xs);
  static const SizedBox hSm = SizedBox(height: AppSpacing.sm);
  static const SizedBox hMd = SizedBox(height: AppSpacing.md);
  static const SizedBox hLg = SizedBox(height: AppSpacing.lg);
  static const SizedBox hXl = SizedBox(height: AppSpacing.xl);

  static const SizedBox wXs = SizedBox(width: AppSpacing.xs);
  static const SizedBox wSm = SizedBox(width: AppSpacing.sm);
  static const SizedBox wMd = SizedBox(width: AppSpacing.md);
  static const SizedBox wLg = SizedBox(width: AppSpacing.lg);
  static const SizedBox wXl = SizedBox(width: AppSpacing.xl);
}

/// EdgeInsets helpers (no magic numbers).
class Insets {
  Insets._();

  static const EdgeInsets allXs = EdgeInsets.all(AppSpacing.xs);
  static const EdgeInsets allSm = EdgeInsets.all(AppSpacing.sm);
  static const EdgeInsets allMd = EdgeInsets.all(AppSpacing.md);
  static const EdgeInsets allLg = EdgeInsets.all(AppSpacing.lg);
  static const EdgeInsets allXl = EdgeInsets.all(AppSpacing.xl);

  static const EdgeInsets symHxs = EdgeInsets.symmetric(
    horizontal: AppSpacing.xs,
  );
  static const EdgeInsets symHsm = EdgeInsets.symmetric(
    horizontal: AppSpacing.sm,
  );
  static const EdgeInsets symHmd = EdgeInsets.symmetric(
    horizontal: AppSpacing.md,
  );
  static const EdgeInsets symHlg = EdgeInsets.symmetric(
    horizontal: AppSpacing.lg,
  );
  static const EdgeInsets symHxl = EdgeInsets.symmetric(
    horizontal: AppSpacing.xl,
  );

  static const EdgeInsets symVxs = EdgeInsets.symmetric(
    vertical: AppSpacing.xs,
  );
  static const EdgeInsets symVsm = EdgeInsets.symmetric(
    vertical: AppSpacing.sm,
  );
  static const EdgeInsets symVmd = EdgeInsets.symmetric(
    vertical: AppSpacing.md,
  );
  static const EdgeInsets symVlg = EdgeInsets.symmetric(
    vertical: AppSpacing.lg,
  );
  static const EdgeInsets symVxl = EdgeInsets.symmetric(
    vertical: AppSpacing.xl,
  );
}

extension NumSpaceExtension on num {
  SizedBox get h => SizedBox(height: toDouble());
  SizedBox get w => SizedBox(width: toDouble());
}
