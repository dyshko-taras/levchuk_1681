// path: lib/providers/user_profile_provider.dart
// Provides data and actions for the user profile screen.
import 'package:FlutterApp/data/models/achievement.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:FlutterApp/data/models/user_profile.dart';
import 'package:FlutterApp/data/repositories/achievements_repository.dart';
import 'package:FlutterApp/data/repositories/matches_repository.dart';
import 'package:FlutterApp/data/repositories/predictions_repository.dart';
import 'package:FlutterApp/data/repositories/profile_repository.dart';
import 'package:flutter/foundation.dart';

@immutable
class RecentPredictionInfo {
  const RecentPredictionInfo({
    required this.prediction,
    required this.fixture,
  });

  final Prediction prediction;
  final Fixture? fixture;
}

@immutable
class ProfileStatistics {
  const ProfileStatistics({
    required this.total,
    required this.correct,
    required this.missed,
    required this.accuracyPct,
  });

  final int total;
  final int correct;
  final int missed;
  final double accuracyPct;
}

@immutable
class UserProfileState {
  const UserProfileState({
    required this.isLoading,
    required this.error,
    required this.profile,
    required this.statistics,
    required this.recentPredictions,
    required this.earnedBadges,
    required this.isSaving,
  });

  final bool isLoading;
  final String? error;
  final UserProfile? profile;
  final ProfileStatistics statistics;
  final List<RecentPredictionInfo> recentPredictions;
  final int earnedBadges;
  final bool isSaving;

  UserProfileState copyWith({
    bool? isLoading,
    Object? error = _sentinel,
    Object? profile = _sentinel,
    ProfileStatistics? statistics,
    List<RecentPredictionInfo>? recentPredictions,
    int? earnedBadges,
    bool? isSaving,
  }) {
    return UserProfileState(
      isLoading: isLoading ?? this.isLoading,
      error: identical(error, _sentinel) ? this.error : error as String?,
      profile:
          identical(profile, _sentinel) ? this.profile : profile as UserProfile?,
      statistics: statistics ?? this.statistics,
      recentPredictions: recentPredictions ?? this.recentPredictions,
      earnedBadges: earnedBadges ?? this.earnedBadges,
      isSaving: isSaving ?? this.isSaving,
    );
  }

  static const Object _sentinel = Object();
}

class UserProfileProvider extends ChangeNotifier {
  UserProfileProvider({
    required ProfileRepository profileRepository,
    required PredictionsRepository predictionsRepository,
    required MatchesRepository matchesRepository,
    required AchievementsRepository achievementsRepository,
  })  : _profileRepository = profileRepository,
        _predictionsRepository = predictionsRepository,
        _matchesRepository = matchesRepository,
        _achievementsRepository = achievementsRepository,
        _state = UserProfileState(
          isLoading: false,
          error: null,
          profile: null,
          statistics: const ProfileStatistics(
            total: 0,
            correct: 0,
            missed: 0,
            accuracyPct: 0,
          ),
          recentPredictions: const <RecentPredictionInfo>[],
          earnedBadges: 0,
          isSaving: false,
        );

  final ProfileRepository _profileRepository;
  final PredictionsRepository _predictionsRepository;
  final MatchesRepository _matchesRepository;
  final AchievementsRepository _achievementsRepository;

  UserProfileState _state;

  UserProfileState get state => _state;

  Future<void> load() async {
    _state = _state.copyWith(isLoading: true, error: UserProfileState._sentinel);
    notifyListeners();
    try {
      final profile = await _profileRepository.getProfile();
      final predictions = await _predictionsRepository.getAll();
      final achievements = await _achievementsRepository.getAchievements();
      final stats = _buildStatistics(predictions);
      final recent = await _buildRecent(predictions.take(5).toList());
      final earned = achievements.where((a) => a.earnedAt != null).length;
      _state = _state.copyWith(
        isLoading: false,
        profile: profile,
        statistics: stats,
        recentPredictions: recent,
        earnedBadges: earned,
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

  Future<void> updateProfile({String? username, int? avatarId}) async {
    final current = state.profile;
    if (current == null) {
      return;
    }
    _state = _state.copyWith(isSaving: true);
    notifyListeners();
    try {
      await _profileRepository.updateProfile(
        username: username,
        avatarId: avatarId,
      );
      final refreshed = await _profileRepository.getProfile();
      _state = _state.copyWith(
        profile: refreshed,
        isSaving: false,
      );
    } catch (e) {
      _state = _state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  ProfileStatistics _buildStatistics(List<Prediction> predictions) {
    final graded = predictions.where((p) => p.result != null).toList();
    final correct = graded.where((p) => p.result == 'correct').length;
    final missed = graded.where((p) => p.result == 'missed').length;
    final accuracy = graded.isEmpty ? 0 : correct / graded.length * 100;
    return ProfileStatistics(
      total: predictions.length,
      correct: correct,
      missed: missed,
      accuracyPct: accuracy.toDouble(),
    );
  }

  Future<List<RecentPredictionInfo>> _buildRecent(
    List<Prediction> predictions,
  ) async {
    if (predictions.isEmpty) return const <RecentPredictionInfo>[];
    predictions.sort((a, b) => b.madeAt.compareTo(a.madeAt));
    final futures = predictions.map((prediction) async {
      final fixture = await _matchesRepository.getById(prediction.fixtureId);
      return RecentPredictionInfo(prediction: prediction, fixture: fixture);
    });
    return Future.wait(futures);
  }
}

