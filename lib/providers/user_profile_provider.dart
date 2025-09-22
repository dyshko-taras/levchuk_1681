// path: lib/providers/user_profile_provider.dart
// Provides data and actions for the user profile screen.
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
      profile: identical(profile, _sentinel)
          ? this.profile
          : profile as UserProfile?,
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
  }) : _profileRepository = profileRepository,
       _predictionsRepository = predictionsRepository,
       _matchesRepository = matchesRepository,
       _achievementsRepository = achievementsRepository,
       _state = const UserProfileState(
         isLoading: false,
         error: null,
         profile: null,
         statistics: ProfileStatistics(
           total: 0,
           correct: 0,
           missed: 0,
           accuracyPct: 0,
         ),
         recentPredictions: <RecentPredictionInfo>[],
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
    _state = _state.copyWith(
      isLoading: true,
    );
    notifyListeners();
    try {
      final profile = await _profileRepository.getProfile();
      final predictions = await _predictionsRepository.getAll();
      final achievements = await _achievementsRepository.getAchievements();
      final stats = await _buildStatisticsAsync(predictions);
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

  Future<ProfileStatistics> _buildStatisticsAsync(
    List<Prediction> predictions,
  ) async {
    // Get all predictions with their fixtures to calculate actual results
    final graded = predictions.where((p) => p.result != null).toList();
    final correct = graded.where((p) => p.result == 'correct').length;
    final missed = graded.where((p) => p.result == 'missed').length;

    // For predictions without result, we need to calculate them
    final ungraded = predictions.where((p) => p.result == null).toList();
    var calculatedCorrect = 0;
    var calculatedMissed = 0;

    // Calculate results for ungraded predictions
    for (final prediction in ungraded) {
      final fixture = await _matchesRepository.getById(prediction.fixtureId);
      if (fixture != null && _isFixtureFinished(fixture)) {
        final result = _calculatePredictionResult(prediction, fixture);
        if (result == 'correct') {
          calculatedCorrect++;
        } else if (result == 'missed') {
          calculatedMissed++;
        }
      }
    }

    final totalCorrect = correct + calculatedCorrect;
    final totalMissed = missed + calculatedMissed;
    final totalGraded = totalCorrect + totalMissed;
    final accuracy = totalGraded == 0 ? 0 : totalCorrect / totalGraded * 100;

    return ProfileStatistics(
      total: predictions.length,
      correct: totalCorrect,
      missed: totalMissed,
      accuracyPct: accuracy.toDouble(),
    );
  }

  Future<void> resetStatisticsOnly() async {
    _state = _state.copyWith(isSaving: true);
    notifyListeners();
    try {
      // Reset only achievements (statistics) - keep predictions
      final achievements = await _achievementsRepository.getAchievements();
      for (final achievement in achievements) {
        if (achievement.earnedAt != null) {
          await _achievementsRepository.setEarned(achievement.id, null);
        }
      }

      // Reload data to reflect reset
      await load();
    } catch (e) {
      _state = _state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<void> resetAllData() async {
    _state = _state.copyWith(isSaving: true);
    notifyListeners();
    try {
      // Reset all predictions - using existing method
      final predictions = await _predictionsRepository.getAll();
      for (final prediction in predictions) {
        await _predictionsRepository.deletePrediction(prediction.fixtureId);
      }

      // Reset achievements - using existing method
      final achievements = await _achievementsRepository.getAchievements();
      for (final achievement in achievements) {
        if (achievement.earnedAt != null) {
          await _achievementsRepository.setEarned(achievement.id, null);
        }
      }

      // Reload data to reflect reset
      await load();
    } catch (e) {
      _state = _state.copyWith(
        isSaving: false,
        error: e.toString(),
      );
    }
    notifyListeners();
  }

  Future<List<RecentPredictionInfo>> _buildRecent(
    List<Prediction> predictions,
  ) async {
    if (predictions.isEmpty) return const <RecentPredictionInfo>[];
    predictions.sort((a, b) => b.madeAt.compareTo(a.madeAt));
    final limited = predictions.take(5);
    final futures = limited.map((prediction) async {
      final fixture = await _matchesRepository.getById(prediction.fixtureId);
      return RecentPredictionInfo(prediction: prediction, fixture: fixture);
    });
    return Future.wait(futures);
  }

  bool _isFixtureFinished(Fixture fixture) {
    const finishedStatuses = {'FT', 'AET', 'PEN'};
    return finishedStatuses.contains(fixture.status.toUpperCase());
  }

  String? _calculatePredictionResult(Prediction prediction, Fixture fixture) {
    final homeGoals = fixture.goalsHome;
    final awayGoals = fixture.goalsAway;

    if (homeGoals == null || awayGoals == null) return null;

    final actualWinner = homeGoals > awayGoals
        ? 'home'
        : homeGoals < awayGoals
        ? 'away'
        : 'draw';

    final predictionPick = prediction.pick.toLowerCase();
    return predictionPick == actualWinner ? 'correct' : 'missed';
  }
}
