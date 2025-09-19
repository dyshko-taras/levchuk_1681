// path: lib/ui/theme/app_decorations.dart
// Common box decorations shared across screens.
import 'package:flutter/material.dart';

class AppDecorations {
  const AppDecorations._();

  static const BoxDecoration heroDimOverlay = BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: <Color>[
        Color(0x00000000),
        Color(0xCC000000),
      ],
    ),
  );
}
