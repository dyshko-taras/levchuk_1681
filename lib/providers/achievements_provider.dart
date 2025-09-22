// path: lib/providers/achievements_provider.dart
// Provides achievement progress for the achievements screen.
import 'package:FlutterApp/constants/app_icons.dart';
import 'package:FlutterApp/data/models/achievement.dart';
import 'package:FlutterApp/data/repositories/achievements_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
class AchievementsState {
  const AchievementsState({
    required this.isLoading,
    required this.error,
    required this.achievements,
  });

  final bool isLoading;
  final String? error;
  final List<Achievement> achievements;

  int get earnedCount => achievements.where((a) => a.earnedAt != null).length;

  /// Get the next milestone achievement (first unearned milestone)
  Achievement? get nextMilestone {
    const milestoneCodes = [
      'prediction_enthusiast',
      'prediction_veteran',
      'century_club',
      'prediction_marathoner',
    ];
    for (final code in milestoneCodes) {
      final achievement = achievements.firstWhere(
        (a) => a.id == code,
        orElse: () => const Achievement(id: '', title: '', description: ''),
      );
      if (achievement.id.isNotEmpty && achievement.earnedAt == null) {
        return achievement;
      }
    }
    return null;
  }

  AchievementsState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    List<Achievement>? achievements,
  }) {
    return AchievementsState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      achievements: achievements ?? this.achievements,
    );
  }

  static const Object _sentinel = Object();
}

class AchievementsProvider extends ChangeNotifier {
  AchievementsProvider(this._repository)
    : _state = const AchievementsState(
        isLoading: false,
        error: null,
        achievements: <Achievement>[],
      );

  final AchievementsRepository _repository;

  AchievementsState _state;

  AchievementsState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    try {
      final achievements = await _repository.refreshAchievements();
      _state = _state.copyWith(
        isLoading: false,
        achievements: achievements,
        error: null,
      );
    } catch (e) {
      _state = _state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> resetAchievement(String code) async {
    await _repository.setEarned(code, null);
    await load();
  }

  /// Get the appropriate icon for an achievement based on its code and earned status
  String getIconForAchievement(String code, bool isEarned) {
    if (!isEarned) return AppIcons.badgeSilver;

    // Special icons for specific achievements
    switch (code) {
      case 'ten_wins_row':
      case 'streak_master':
        return AppIcons.badgeGold;
      case 'perfect_day':
        return AppIcons.badgeGold;
      case 'accuracy_king':
        return AppIcons.badgeGold;
      case 'underdog_hero':
        return AppIcons.badgeSilver;
      case 'balanced_mind':
        return AppIcons.badgeGold;
      default:
        return AppIcons.badgeGold;
    }
  }

  /// Format date for display
  String formatDate(DateTime date) {
    final formatter = DateFormat('MMM d, yyyy');
    return formatter.format(date);
  }

  /// Get subtitle text for an achievement
  String getSubtitleForAchievement(Achievement achievement) {
    if (achievement.earnedAt != null) {
      return 'Earned ${formatDate(achievement.earnedAt!)}';
    }

    // Return description for locked achievements
    return achievement.description;
  }

  /// Navigate back
  void onBack() {
    // This will be handled by the navigation system
  }

  /// Handle tile tap (for future details dialog)
  void onTileTap(Achievement achievement) {
    // Future: Open achievement details dialog
  }
}
