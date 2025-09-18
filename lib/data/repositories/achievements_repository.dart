// path: lib/data/repositories/achievements_repository.dart
// Repository that manages achievements. Evaluates unlock conditions using
// local predictions and cached fixtures.
import 'package:FlutterApp/data/local/database/daos/achievements_dao.dart';
import 'package:FlutterApp/data/local/database/daos/matches_dao.dart';
import 'package:FlutterApp/data/local/database/daos/predictions_dao.dart';
import 'package:FlutterApp/data/models/achievement.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/prediction.dart';
import 'package:collection/collection.dart';

class AchievementsRepository {
  AchievementsRepository({
    required AchievementsDao achievementsDao,
    required PredictionsDao predictionsDao,
    required MatchesDao matchesDao,
  }) : _achievementsDao = achievementsDao,
       _predictionsDao = predictionsDao,
       _matchesDao = matchesDao;

  final AchievementsDao _achievementsDao;
  final PredictionsDao _predictionsDao;
  final MatchesDao _matchesDao;

  Future<List<Achievement>> getAchievements() async {
    await _ensureSeeded();
    return _achievementsDao.getAll();
  }

  Future<List<Achievement>> refreshAchievements() async {
    await _ensureSeeded();
    final predictions = await _predictionsDao.getAllOrdered();
    final fixtures = await _loadFixtures(predictions);
    final context = _AchievementContext(predictions, fixtures);
    final existing = {
      for (final achievement in await _achievementsDao.getAll())
        achievement.id: achievement,
    };

    final updates = <Achievement>[];
    for (final definition in _definitions) {
      final earned = definition.evaluator(context);
      final previous = existing[definition.code];
      final earnedAt = earned
          ? previous?.earnedAt ?? DateTime.now()
          : previous?.earnedAt;
      updates.add(
        Achievement(
          id: definition.code,
          title: definition.title,
          description: definition.description,
          earnedAt: earned ? earnedAt : null,
        ),
      );
    }
    await _achievementsDao.upsertAll(updates);
    return updates;
  }

  Future<void> setEarned(String code, DateTime? earnedAt) =>
      _achievementsDao.setEarned(code, earnedAt);

  Future<void> _ensureSeeded() async {
    final current = await _achievementsDao.getAll();
    if (current.isNotEmpty) return;
    await _achievementsDao.upsertAll(
      _definitions.map(
        (def) => Achievement(
          id: def.code,
          title: def.title,
          description: def.description,
          earnedAt: null,
        ),
      ),
    );
  }

  Future<Map<int, Fixture>> _loadFixtures(List<Prediction> predictions) async {
    final ids = {
      for (final prediction in predictions) prediction.fixtureId,
    };
    final map = <int, Fixture>{};
    for (final id in ids) {
      final fixture = await _matchesDao.getById(id);
      if (fixture != null) {
        map[id] = fixture;
      }
    }
    return map;
  }
}

class _AchievementDefinition {
  const _AchievementDefinition(
    this.code,
    this.title,
    this.description,
    this.evaluator,
  );

  final String code;
  final String title;
  final String description;
  final bool Function(_AchievementContext context) evaluator;
}

class _AchievementContext {
  _AchievementContext(List<Prediction> predictions, Map<int, Fixture> fixtures)
    : predictions = List<Prediction>.unmodifiable(
        List<Prediction>.from(predictions)
          ..sort((a, b) => a.madeAt.compareTo(b.madeAt)),
      ),
      fixtures = Map<int, Fixture>.unmodifiable(fixtures),
      gradedPredictions = List<Prediction>.unmodifiable(
        List<Prediction>.from(predictions)
          ..sort((a, b) => a.madeAt.compareTo(b.madeAt))
          ..removeWhere((p) => p.result == null),
      );

  final List<Prediction> predictions;
  final List<Prediction> gradedPredictions;
  final Map<int, Fixture> fixtures;
  Iterable<Prediction> get wins =>
      gradedPredictions.where((prediction) => prediction.result == 'correct');

  Iterable<Prediction> get losses =>
      gradedPredictions.where((prediction) => prediction.result == 'missed');

  int get totalPredictions => predictions.length;

  int get totalWins => wins.length;

  double get winRate =>
      gradedPredictions.isEmpty ? 0 : totalWins / gradedPredictions.length;

  int get longestWinStreak => _longestStreak('correct');

  int get longestLossStreak => _longestStreak('missed');

  int _longestStreak(String targetResult) {
    var longest = 0;
    var current = 0;
    for (final prediction in gradedPredictions) {
      if (prediction.result == targetResult) {
        current += 1;
        if (current > longest) {
          longest = current;
        }
      } else {
        current = 0;
      }
    }
    return longest;
  }

  bool get hasPerfectDay {
    final byDay = gradedPredictions.groupListsBy(
      (p) => DateTime.utc(
        p.madeAt.toUtc().year,
        p.madeAt.toUtc().month,
        p.madeAt.toUtc().day,
      ),
    );
    return byDay.values.any(
      (dayPredictions) =>
          dayPredictions.length >= 3 &&
          dayPredictions.every((p) => p.result == 'correct'),
    );
  }

  bool get hasColdStreakSurvivor {
    var lossStreak = 0;
    for (final prediction in gradedPredictions) {
      if (prediction.result == 'missed') {
        lossStreak += 1;
      } else if (prediction.result == 'correct' && lossStreak >= 5) {
        return true;
      } else {
        lossStreak = 0;
      }
    }
    return false;
  }

  bool hasBalancedMind() {
    final counts = <String, int>{'home': 0, 'draw': 0, 'away': 0};
    for (final prediction in wins) {
      counts[prediction.pick] = (counts[prediction.pick] ?? 0) + 1;
    }
    return counts.values.every((value) => value >= 2);
  }

  bool get hasUnderdogHero =>
      wins.where((prediction) => (prediction.odds ?? 0) > 3).length >= 3;

  bool get hasSilentSniper =>
      wins.where((prediction) => prediction.openedDetails == false).length >=
      10;

  bool get hasSharpInstincts {
    for (final prediction in wins) {
      final fixture = fixtures[prediction.fixtureId];
      if (fixture == null) continue;
      final kickoff = fixture.dateUtc.toUtc();
      final delta = kickoff.difference(prediction.madeAt.toUtc()).inMinutes;
      if (delta >= 0 && delta <= 10) {
        return true;
      }
    }
    return false;
  }

  bool get hasWorldExplorer {
    final leagues = <int>{};
    for (final prediction in wins) {
      final fixture = fixtures[prediction.fixtureId];
      if (fixture != null) {
        leagues.add(fixture.leagueId);
      }
    }
    return leagues.length >= 5;
  }
}

final List<_AchievementDefinition> _definitions = [
  _AchievementDefinition(
    'first_steps',
    'First Steps',
    'Make your first prediction.',
    (ctx) => ctx.totalPredictions >= 1,
  ),
  _AchievementDefinition(
    'prediction_enthusiast',
    'Prediction Enthusiast',
    'Log 25 predictions in total.',
    (ctx) => ctx.totalPredictions >= 25,
  ),
  _AchievementDefinition(
    'prediction_veteran',
    'Prediction Veteran',
    'Log 75 predictions.',
    (ctx) => ctx.totalPredictions >= 75,
  ),
  _AchievementDefinition(
    'century_club',
    'Century Club',
    'Reach 100 predictions.',
    (ctx) => ctx.totalPredictions >= 100,
  ),
  _AchievementDefinition(
    'prediction_marathoner',
    'Prediction Marathoner',
    'Reach 300 predictions.',
    (ctx) => ctx.totalPredictions >= 300,
  ),
  _AchievementDefinition(
    'ten_wins_row',
    '10 Wins in a Row',
    'Win 10 consecutive predictions.',
    (ctx) => ctx.longestWinStreak >= 10,
  ),
  _AchievementDefinition(
    'perfect_day',
    'Perfect Day',
    'Win every prediction on a day with at least 3 picks.',
    (ctx) => ctx.hasPerfectDay,
  ),
  _AchievementDefinition(
    'streak_master',
    'Streak Master',
    'Win 20 consecutive predictions.',
    (ctx) => ctx.longestWinStreak >= 20,
  ),
  _AchievementDefinition(
    'cold_streak_survivor',
    'Cold Streak Survivor',
    'Break a losing streak of 5+ losses with a win.',
    (ctx) => ctx.hasColdStreakSurvivor,
  ),
  _AchievementDefinition(
    'accuracy_king',
    'Accuracy King',
    'Maintain at least 70% win rate across 20 graded predictions.',
    (ctx) => ctx.gradedPredictions.length >= 20 && ctx.winRate >= 0.7,
  ),
  _AchievementDefinition(
    'underdog_hero',
    'Underdog Hero',
    'Win 3 predictions with odds above 3.0.',
    (ctx) => ctx.hasUnderdogHero,
  ),
  _AchievementDefinition(
    'balanced_mind',
    'Balanced Mind',
    'Win at least two Home, Draw, and Away predictions each.',
    (ctx) => ctx.hasBalancedMind(),
  ),
  _AchievementDefinition(
    'world_explorer',
    'World Explorer',
    'Win predictions in 5 different leagues.',
    (ctx) => ctx.hasWorldExplorer,
  ),
  _AchievementDefinition(
    'silent_sniper',
    'Silent Sniper',
    'Win 10 predictions without opening match details.',
    (ctx) => ctx.hasSilentSniper,
  ),
  _AchievementDefinition(
    'sharp_instincts',
    'Sharp Instincts',
    'Win a prediction placed within 10 minutes of kickoff.',
    (ctx) => ctx.hasSharpInstincts,
  ),
];

