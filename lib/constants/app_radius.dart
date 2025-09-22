import 'package:flutter/material.dart';

/// Corner radius tokens. Never hardcode raw radii in widgets.
abstract final class AppRadius {
  AppRadius._();

  static const double xs = 4;
  static const double sm = 6;
  static const double md = 10;
  static const double lg = 15;
  static const double xl = 20;
  static const double segment = 18;
  static const double chip = 12;
  static const double note = 16;
  static const double pill = 999;

  static const BorderRadius cardLg = BorderRadius.all(Radius.circular(lg));
  static const BorderRadius btnLg = BorderRadius.all(Radius.circular(sm));
  static const BorderRadius segmented = BorderRadius.all(
    Radius.circular(segment),
  );
  static const BorderRadius chipRadius = BorderRadius.all(
    Radius.circular(chip),
  );
  static const BorderRadius noteRadius = BorderRadius.all(
    Radius.circular(note),
  );

  static BorderRadius circular(double radius) =>
      BorderRadius.all(Radius.circular(radius));
}
