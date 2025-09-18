// path: lib/data/local/database/schema/matches_table.dart
// Drift table storing cached fixtures per Implementation Plan section 4.
import 'package:drift/drift.dart';

class MatchesTable extends Table {
  IntColumn get fixtureId => integer().named('fixture_id')();
  IntColumn get leagueId => integer().named('league_id')();
  IntColumn get season => integer().named('season').nullable()();
  TextColumn get leagueName => text().named('league_name')();
  TextColumn get country => text().named('country').nullable()();
  IntColumn get homeTeamId => integer().named('home_team_id')();
  TextColumn get homeTeamName => text().named('home_team_name')();
  IntColumn get awayTeamId => integer().named('away_team_id')();
  TextColumn get awayTeamName => text().named('away_team_name')();
  TextColumn get venue => text().named('venue').nullable()();
  TextColumn get referee => text().named('referee').nullable()();
  DateTimeColumn get kickoffUtc => dateTime().named('kickoff_utc')();
  TextColumn get status => text().named('status')();
  IntColumn get minute => integer().named('minute').nullable()();
  IntColumn get scoreHome => integer().named('score_home').nullable()();
  IntColumn get scoreAway => integer().named('score_away').nullable()();
  TextColumn get homeLogo => text().named('home_logo').nullable()();
  TextColumn get awayLogo => text().named('away_logo').nullable()();
  DateTimeColumn get syncedAt => dateTime().named('last_synced_at')();

  @override
  Set<Column> get primaryKey => {fixtureId};

  List<Index> get indexes => [
    Index('idx_matches_status', 'status'),
    Index('idx_matches_kickoff', 'kickoff_utc'),
  ];
}
