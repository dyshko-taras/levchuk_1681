import 'package:flutter/material.dart';

/// Radius tokens (buttons & cards) from DS.
/// - Buttons: 6px
/// - Cards: 15px
/// Sources: Visual Style + Implementation Plan.
/// :contentReference[oaicite:16]{index=16} :contentReference[oaicite:17]{index=17} :contentReference[oaicite:18]{index=18}
class AppRadius {
  AppRadius._();

  static const BorderRadius sm = BorderRadius.all(Radius.circular(6));
  static const BorderRadius md = BorderRadius.all(
    Radius.circular(10),
  );
  static const BorderRadius lg = BorderRadius.all(Radius.circular(15));
  static const BorderRadius xl = BorderRadius.all(
    Radius.circular(20),
  );

  // Named roles
  static const BorderRadius button = sm; // 6px
  static const BorderRadius card = lg; // 15px
}
