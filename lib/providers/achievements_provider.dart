// path: lib/providers/achievements_provider.dart
// Provides achievement progress for the achievements screen.
import 'package:FlutterApp/data/models/achievement.dart';
import 'package:FlutterApp/data/repositories/achievements_repository.dart';
import 'package:flutter/foundation.dart';

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
      error: AchievementsState._sentinel,
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
}
