// path: lib/data/local/database/daos/matches_dao.dart
// DAO bridging fixtures with the local Drift cache (Implementation Plan section 4).
import 'package:FlutterApp/data/local/database/app_database.dart';
import 'package:FlutterApp/data/local/database/schema/matches_table.dart';
import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/team_ref.dart';
import 'package:drift/drift.dart';

part 'matches_dao.g.dart';

@DriftAccessor(tables: [MatchesTable])
class MatchesDao extends DatabaseAccessor<AppDatabase> with _$MatchesDaoMixin {
  MatchesDao(AppDatabase db) : super(db);

  Future<void> replaceForDate(
    DateTime date,
    List<Fixture> fixtures, {
    int? season,
  }) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    await transaction(() async {
      await (delete(matchesTable)..where(
            (tbl) =>
                tbl.kickoffUtc.isBiggerOrEqualValue(dayStart) &
                tbl.kickoffUtc.isSmallerThanValue(dayEnd),
          ))
          .go();
      if (fixtures.isEmpty) return;
      await batch((batch) {
        batch.insertAll(
          matchesTable,
          fixtures.map((fixture) => _toCompanion(fixture, season: season)),
          mode: InsertMode.insertOrReplace,
        );
      });
    });
  }

  Future<void> upsertFixtures(
    Iterable<Fixture> fixtures, {
    int? season,
  }) async {
    if (fixtures.isEmpty) return;
    await batch((batch) {
      batch.insertAllOnConflictUpdate(
        matchesTable,
        fixtures.map((fixture) => _toCompanion(fixture, season: season)),
      );
    });
  }

  Future<List<Fixture>> getByDate(DateTime date) async {
    final dayStart = DateTime(date.year, date.month, date.day);
    final dayEnd = dayStart.add(const Duration(days: 1));
    final rows =
        await (select(matchesTable)
              ..where(
                (tbl) =>
                    tbl.kickoffUtc.isBiggerOrEqualValue(dayStart) &
                    tbl.kickoffUtc.isSmallerThanValue(dayEnd),
              )
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.kickoffUtc)]))
            .get();
    return rows.map(_fromData).toList();
  }

  Future<List<Fixture>> getByLeague({
    required int leagueId,
    int? season,
    DateTime? date,
    String? status,
  }) async {
    final query = select(matchesTable)
      ..where((tbl) => tbl.leagueId.equals(leagueId));
    if (season != null) {
      query.where((tbl) => tbl.season.equals(season));
    }
    if (date != null) {
      final dayStart = DateTime(date.year, date.month, date.day);
      final dayEnd = dayStart.add(const Duration(days: 1));
      query.where(
        (tbl) =>
            tbl.kickoffUtc.isBiggerOrEqualValue(dayStart) &
            tbl.kickoffUtc.isSmallerThanValue(dayEnd),
      );
    }
    if (status != null && status.isNotEmpty) {
      query.where((tbl) => tbl.status.equals(status));
    }
    query.orderBy([(tbl) => OrderingTerm.asc(tbl.kickoffUtc)]);
    final rows = await query.get();
    return rows.map(_fromData).toList();
  }

  Future<List<Fixture>> getLiveFixtures() async {
    const liveStatuses = <String>['1H', 'HT', '2H', 'ET', 'P', 'LIVE'];
    final rows =
        await (select(matchesTable)
              ..where((tbl) => tbl.status.isIn(liveStatuses))
              ..orderBy([(tbl) => OrderingTerm.asc(tbl.kickoffUtc)]))
            .get();
    return rows.map(_fromData).toList();
  }

  Future<Fixture?> getById(int fixtureId) async {
    final row =
        await (select(matchesTable)
              ..where((tbl) => tbl.fixtureId.equals(fixtureId))
              ..limit(1))
            .getSingleOrNull();
    return row == null ? null : _fromData(row);
  }

  MatchesTableCompanion _toCompanion(
    Fixture fixture, {
    int? season,
  }) => MatchesTableCompanion(
    fixtureId: Value(fixture.fixtureId),
    leagueId: Value(fixture.leagueId),
    season: Value(season),
    leagueName: Value(fixture.leagueName),
    country: Value(fixture.country),
    homeTeamId: Value(fixture.homeTeam.id),
    homeTeamName: Value(fixture.homeTeam.name),
    awayTeamId: Value(fixture.awayTeam.id),
    awayTeamName: Value(fixture.awayTeam.name),
    venue: const Value(null),
    referee: const Value(null),
    kickoffUtc: Value(fixture.dateUtc),
    status: Value(fixture.status),
    minute: Value(fixture.minute),
    scoreHome: Value(fixture.goalsHome),
    scoreAway: Value(fixture.goalsAway),
    homeLogo: Value(fixture.homeTeam.logo),
    awayLogo: Value(fixture.awayTeam.logo),
    syncedAt: Value(DateTime.now()),
  );

  Fixture _fromData(MatchesTableData data) => Fixture(
    fixtureId: data.fixtureId,
    leagueId: data.leagueId,
    leagueName: data.leagueName,
    country: data.country,
    dateUtc: data.kickoffUtc,
    status: data.status,
    minute: data.minute,
    homeTeam: TeamRef(
      id: data.homeTeamId,
      name: data.homeTeamName,
      logo: data.homeLogo,
    ),
    awayTeam: TeamRef(
      id: data.awayTeamId,
      name: data.awayTeamName,
      logo: data.awayLogo,
    ),
    goalsHome: data.scoreHome,
    goalsAway: data.scoreAway,
  );
}
