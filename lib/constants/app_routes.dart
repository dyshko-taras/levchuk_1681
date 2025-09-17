import 'package:flutter/material.dart';

/// Contains routes used in the app
class AppRoutes {
  static const String splash = '/splash';

  static Map<String, WidgetBuilder> get routes {
    return {
      splash: (context) => Container(),
    };
  }
}
