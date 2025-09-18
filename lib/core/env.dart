class Env {
  Env._();

  /// True when running a non-release build.
  static const bool isDebug = bool.fromEnvironment('dart.vm.product') == false;

  /// Compile-time flavor gates (set via --dart-define).
  static const String flavor = String.fromEnvironment(
    'FLAVOR',
    defaultValue: 'dev',
  );

  static bool get isProd => flavor.toLowerCase() == 'prod';
  static bool get isDev => !isProd;

  /// Feature flags (toggled via --dart-define or code during experiments).
  static const bool enableExperimentalCharts = bool.fromEnvironment(
    'FF_EXPERIMENTAL_CHARTS',
  );

  static const bool enableInsightsBackgroundRecompute = bool.fromEnvironment(
    'FF_INSIGHTS_BG_RECOMPUTE',
  );
}
