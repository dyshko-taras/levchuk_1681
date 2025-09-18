class AppDurations {
  AppDurations._();

  static const Duration splashMin = Duration(milliseconds: 1800);

  /// Minimum lead time before kickoff when predictions lock.
  static const Duration predictionLock = Duration(minutes: 60);

  /// Common animation speeds.
  static const Duration fast = Duration(milliseconds: 150);
  static const Duration normal = Duration(milliseconds: 250);
  static const Duration slow = Duration(milliseconds: 350);
}
