// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $MatchesTableTable extends MatchesTable
    with TableInfo<$MatchesTableTable, MatchesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MatchesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _fixtureIdMeta = const VerificationMeta(
    'fixtureId',
  );
  @override
  late final GeneratedColumn<int> fixtureId = GeneratedColumn<int>(
    'fixture_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leagueIdMeta = const VerificationMeta(
    'leagueId',
  );
  @override
  late final GeneratedColumn<int> leagueId = GeneratedColumn<int>(
    'league_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _seasonMeta = const VerificationMeta('season');
  @override
  late final GeneratedColumn<int> season = GeneratedColumn<int>(
    'season',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _leagueNameMeta = const VerificationMeta(
    'leagueName',
  );
  @override
  late final GeneratedColumn<String> leagueName = GeneratedColumn<String>(
    'league_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _countryMeta = const VerificationMeta(
    'country',
  );
  @override
  late final GeneratedColumn<String> country = GeneratedColumn<String>(
    'country',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _homeTeamIdMeta = const VerificationMeta(
    'homeTeamId',
  );
  @override
  late final GeneratedColumn<int> homeTeamId = GeneratedColumn<int>(
    'home_team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _homeTeamNameMeta = const VerificationMeta(
    'homeTeamName',
  );
  @override
  late final GeneratedColumn<String> homeTeamName = GeneratedColumn<String>(
    'home_team_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _awayTeamIdMeta = const VerificationMeta(
    'awayTeamId',
  );
  @override
  late final GeneratedColumn<int> awayTeamId = GeneratedColumn<int>(
    'away_team_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _awayTeamNameMeta = const VerificationMeta(
    'awayTeamName',
  );
  @override
  late final GeneratedColumn<String> awayTeamName = GeneratedColumn<String>(
    'away_team_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _venueMeta = const VerificationMeta('venue');
  @override
  late final GeneratedColumn<String> venue = GeneratedColumn<String>(
    'venue',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _refereeMeta = const VerificationMeta(
    'referee',
  );
  @override
  late final GeneratedColumn<String> referee = GeneratedColumn<String>(
    'referee',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _kickoffUtcMeta = const VerificationMeta(
    'kickoffUtc',
  );
  @override
  late final GeneratedColumn<DateTime> kickoffUtc = GeneratedColumn<DateTime>(
    'kickoff_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minuteMeta = const VerificationMeta('minute');
  @override
  late final GeneratedColumn<int> minute = GeneratedColumn<int>(
    'minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreHomeMeta = const VerificationMeta(
    'scoreHome',
  );
  @override
  late final GeneratedColumn<int> scoreHome = GeneratedColumn<int>(
    'score_home',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scoreAwayMeta = const VerificationMeta(
    'scoreAway',
  );
  @override
  late final GeneratedColumn<int> scoreAway = GeneratedColumn<int>(
    'score_away',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _homeLogoMeta = const VerificationMeta(
    'homeLogo',
  );
  @override
  late final GeneratedColumn<String> homeLogo = GeneratedColumn<String>(
    'home_logo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _awayLogoMeta = const VerificationMeta(
    'awayLogo',
  );
  @override
  late final GeneratedColumn<String> awayLogo = GeneratedColumn<String>(
    'away_logo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _syncedAtMeta = const VerificationMeta(
    'syncedAt',
  );
  @override
  late final GeneratedColumn<DateTime> syncedAt = GeneratedColumn<DateTime>(
    'last_synced_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    fixtureId,
    leagueId,
    season,
    leagueName,
    country,
    homeTeamId,
    homeTeamName,
    awayTeamId,
    awayTeamName,
    venue,
    referee,
    kickoffUtc,
    status,
    minute,
    scoreHome,
    scoreAway,
    homeLogo,
    awayLogo,
    syncedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'matches_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<MatchesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('fixture_id')) {
      context.handle(
        _fixtureIdMeta,
        fixtureId.isAcceptableOrUnknown(data['fixture_id']!, _fixtureIdMeta),
      );
    }
    if (data.containsKey('league_id')) {
      context.handle(
        _leagueIdMeta,
        leagueId.isAcceptableOrUnknown(data['league_id']!, _leagueIdMeta),
      );
    } else if (isInserting) {
      context.missing(_leagueIdMeta);
    }
    if (data.containsKey('season')) {
      context.handle(
        _seasonMeta,
        season.isAcceptableOrUnknown(data['season']!, _seasonMeta),
      );
    }
    if (data.containsKey('league_name')) {
      context.handle(
        _leagueNameMeta,
        leagueName.isAcceptableOrUnknown(data['league_name']!, _leagueNameMeta),
      );
    } else if (isInserting) {
      context.missing(_leagueNameMeta);
    }
    if (data.containsKey('country')) {
      context.handle(
        _countryMeta,
        country.isAcceptableOrUnknown(data['country']!, _countryMeta),
      );
    }
    if (data.containsKey('home_team_id')) {
      context.handle(
        _homeTeamIdMeta,
        homeTeamId.isAcceptableOrUnknown(
          data['home_team_id']!,
          _homeTeamIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeTeamIdMeta);
    }
    if (data.containsKey('home_team_name')) {
      context.handle(
        _homeTeamNameMeta,
        homeTeamName.isAcceptableOrUnknown(
          data['home_team_name']!,
          _homeTeamNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_homeTeamNameMeta);
    }
    if (data.containsKey('away_team_id')) {
      context.handle(
        _awayTeamIdMeta,
        awayTeamId.isAcceptableOrUnknown(
          data['away_team_id']!,
          _awayTeamIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_awayTeamIdMeta);
    }
    if (data.containsKey('away_team_name')) {
      context.handle(
        _awayTeamNameMeta,
        awayTeamName.isAcceptableOrUnknown(
          data['away_team_name']!,
          _awayTeamNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_awayTeamNameMeta);
    }
    if (data.containsKey('venue')) {
      context.handle(
        _venueMeta,
        venue.isAcceptableOrUnknown(data['venue']!, _venueMeta),
      );
    }
    if (data.containsKey('referee')) {
      context.handle(
        _refereeMeta,
        referee.isAcceptableOrUnknown(data['referee']!, _refereeMeta),
      );
    }
    if (data.containsKey('kickoff_utc')) {
      context.handle(
        _kickoffUtcMeta,
        kickoffUtc.isAcceptableOrUnknown(data['kickoff_utc']!, _kickoffUtcMeta),
      );
    } else if (isInserting) {
      context.missing(_kickoffUtcMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('minute')) {
      context.handle(
        _minuteMeta,
        minute.isAcceptableOrUnknown(data['minute']!, _minuteMeta),
      );
    }
    if (data.containsKey('score_home')) {
      context.handle(
        _scoreHomeMeta,
        scoreHome.isAcceptableOrUnknown(data['score_home']!, _scoreHomeMeta),
      );
    }
    if (data.containsKey('score_away')) {
      context.handle(
        _scoreAwayMeta,
        scoreAway.isAcceptableOrUnknown(data['score_away']!, _scoreAwayMeta),
      );
    }
    if (data.containsKey('home_logo')) {
      context.handle(
        _homeLogoMeta,
        homeLogo.isAcceptableOrUnknown(data['home_logo']!, _homeLogoMeta),
      );
    }
    if (data.containsKey('away_logo')) {
      context.handle(
        _awayLogoMeta,
        awayLogo.isAcceptableOrUnknown(data['away_logo']!, _awayLogoMeta),
      );
    }
    if (data.containsKey('last_synced_at')) {
      context.handle(
        _syncedAtMeta,
        syncedAt.isAcceptableOrUnknown(data['last_synced_at']!, _syncedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_syncedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {fixtureId};
  @override
  MatchesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MatchesTableData(
      fixtureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixture_id'],
      )!,
      leagueId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}league_id'],
      )!,
      season: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}season'],
      ),
      leagueName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}league_name'],
      )!,
      country: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}country'],
      ),
      homeTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}home_team_id'],
      )!,
      homeTeamName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_team_name'],
      )!,
      awayTeamId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}away_team_id'],
      )!,
      awayTeamName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}away_team_name'],
      )!,
      venue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}venue'],
      ),
      referee: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}referee'],
      ),
      kickoffUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}kickoff_utc'],
      )!,
      status: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}status'],
      )!,
      minute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute'],
      ),
      scoreHome: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_home'],
      ),
      scoreAway: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}score_away'],
      ),
      homeLogo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}home_logo'],
      ),
      awayLogo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}away_logo'],
      ),
      syncedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_synced_at'],
      )!,
    );
  }

  @override
  $MatchesTableTable createAlias(String alias) {
    return $MatchesTableTable(attachedDatabase, alias);
  }
}

class MatchesTableData extends DataClass
    implements Insertable<MatchesTableData> {
  final int fixtureId;
  final int leagueId;
  final int? season;
  final String leagueName;
  final String? country;
  final int homeTeamId;
  final String homeTeamName;
  final int awayTeamId;
  final String awayTeamName;
  final String? venue;
  final String? referee;
  final DateTime kickoffUtc;
  final String status;
  final int? minute;
  final int? scoreHome;
  final int? scoreAway;
  final String? homeLogo;
  final String? awayLogo;
  final DateTime syncedAt;
  const MatchesTableData({
    required this.fixtureId,
    required this.leagueId,
    this.season,
    required this.leagueName,
    this.country,
    required this.homeTeamId,
    required this.homeTeamName,
    required this.awayTeamId,
    required this.awayTeamName,
    this.venue,
    this.referee,
    required this.kickoffUtc,
    required this.status,
    this.minute,
    this.scoreHome,
    this.scoreAway,
    this.homeLogo,
    this.awayLogo,
    required this.syncedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['fixture_id'] = Variable<int>(fixtureId);
    map['league_id'] = Variable<int>(leagueId);
    if (!nullToAbsent || season != null) {
      map['season'] = Variable<int>(season);
    }
    map['league_name'] = Variable<String>(leagueName);
    if (!nullToAbsent || country != null) {
      map['country'] = Variable<String>(country);
    }
    map['home_team_id'] = Variable<int>(homeTeamId);
    map['home_team_name'] = Variable<String>(homeTeamName);
    map['away_team_id'] = Variable<int>(awayTeamId);
    map['away_team_name'] = Variable<String>(awayTeamName);
    if (!nullToAbsent || venue != null) {
      map['venue'] = Variable<String>(venue);
    }
    if (!nullToAbsent || referee != null) {
      map['referee'] = Variable<String>(referee);
    }
    map['kickoff_utc'] = Variable<DateTime>(kickoffUtc);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || minute != null) {
      map['minute'] = Variable<int>(minute);
    }
    if (!nullToAbsent || scoreHome != null) {
      map['score_home'] = Variable<int>(scoreHome);
    }
    if (!nullToAbsent || scoreAway != null) {
      map['score_away'] = Variable<int>(scoreAway);
    }
    if (!nullToAbsent || homeLogo != null) {
      map['home_logo'] = Variable<String>(homeLogo);
    }
    if (!nullToAbsent || awayLogo != null) {
      map['away_logo'] = Variable<String>(awayLogo);
    }
    map['last_synced_at'] = Variable<DateTime>(syncedAt);
    return map;
  }

  MatchesTableCompanion toCompanion(bool nullToAbsent) {
    return MatchesTableCompanion(
      fixtureId: Value(fixtureId),
      leagueId: Value(leagueId),
      season: season == null && nullToAbsent
          ? const Value.absent()
          : Value(season),
      leagueName: Value(leagueName),
      country: country == null && nullToAbsent
          ? const Value.absent()
          : Value(country),
      homeTeamId: Value(homeTeamId),
      homeTeamName: Value(homeTeamName),
      awayTeamId: Value(awayTeamId),
      awayTeamName: Value(awayTeamName),
      venue: venue == null && nullToAbsent
          ? const Value.absent()
          : Value(venue),
      referee: referee == null && nullToAbsent
          ? const Value.absent()
          : Value(referee),
      kickoffUtc: Value(kickoffUtc),
      status: Value(status),
      minute: minute == null && nullToAbsent
          ? const Value.absent()
          : Value(minute),
      scoreHome: scoreHome == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreHome),
      scoreAway: scoreAway == null && nullToAbsent
          ? const Value.absent()
          : Value(scoreAway),
      homeLogo: homeLogo == null && nullToAbsent
          ? const Value.absent()
          : Value(homeLogo),
      awayLogo: awayLogo == null && nullToAbsent
          ? const Value.absent()
          : Value(awayLogo),
      syncedAt: Value(syncedAt),
    );
  }

  factory MatchesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MatchesTableData(
      fixtureId: serializer.fromJson<int>(json['fixtureId']),
      leagueId: serializer.fromJson<int>(json['leagueId']),
      season: serializer.fromJson<int?>(json['season']),
      leagueName: serializer.fromJson<String>(json['leagueName']),
      country: serializer.fromJson<String?>(json['country']),
      homeTeamId: serializer.fromJson<int>(json['homeTeamId']),
      homeTeamName: serializer.fromJson<String>(json['homeTeamName']),
      awayTeamId: serializer.fromJson<int>(json['awayTeamId']),
      awayTeamName: serializer.fromJson<String>(json['awayTeamName']),
      venue: serializer.fromJson<String?>(json['venue']),
      referee: serializer.fromJson<String?>(json['referee']),
      kickoffUtc: serializer.fromJson<DateTime>(json['kickoffUtc']),
      status: serializer.fromJson<String>(json['status']),
      minute: serializer.fromJson<int?>(json['minute']),
      scoreHome: serializer.fromJson<int?>(json['scoreHome']),
      scoreAway: serializer.fromJson<int?>(json['scoreAway']),
      homeLogo: serializer.fromJson<String?>(json['homeLogo']),
      awayLogo: serializer.fromJson<String?>(json['awayLogo']),
      syncedAt: serializer.fromJson<DateTime>(json['syncedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fixtureId': serializer.toJson<int>(fixtureId),
      'leagueId': serializer.toJson<int>(leagueId),
      'season': serializer.toJson<int?>(season),
      'leagueName': serializer.toJson<String>(leagueName),
      'country': serializer.toJson<String?>(country),
      'homeTeamId': serializer.toJson<int>(homeTeamId),
      'homeTeamName': serializer.toJson<String>(homeTeamName),
      'awayTeamId': serializer.toJson<int>(awayTeamId),
      'awayTeamName': serializer.toJson<String>(awayTeamName),
      'venue': serializer.toJson<String?>(venue),
      'referee': serializer.toJson<String?>(referee),
      'kickoffUtc': serializer.toJson<DateTime>(kickoffUtc),
      'status': serializer.toJson<String>(status),
      'minute': serializer.toJson<int?>(minute),
      'scoreHome': serializer.toJson<int?>(scoreHome),
      'scoreAway': serializer.toJson<int?>(scoreAway),
      'homeLogo': serializer.toJson<String?>(homeLogo),
      'awayLogo': serializer.toJson<String?>(awayLogo),
      'syncedAt': serializer.toJson<DateTime>(syncedAt),
    };
  }

  MatchesTableData copyWith({
    int? fixtureId,
    int? leagueId,
    Value<int?> season = const Value.absent(),
    String? leagueName,
    Value<String?> country = const Value.absent(),
    int? homeTeamId,
    String? homeTeamName,
    int? awayTeamId,
    String? awayTeamName,
    Value<String?> venue = const Value.absent(),
    Value<String?> referee = const Value.absent(),
    DateTime? kickoffUtc,
    String? status,
    Value<int?> minute = const Value.absent(),
    Value<int?> scoreHome = const Value.absent(),
    Value<int?> scoreAway = const Value.absent(),
    Value<String?> homeLogo = const Value.absent(),
    Value<String?> awayLogo = const Value.absent(),
    DateTime? syncedAt,
  }) => MatchesTableData(
    fixtureId: fixtureId ?? this.fixtureId,
    leagueId: leagueId ?? this.leagueId,
    season: season.present ? season.value : this.season,
    leagueName: leagueName ?? this.leagueName,
    country: country.present ? country.value : this.country,
    homeTeamId: homeTeamId ?? this.homeTeamId,
    homeTeamName: homeTeamName ?? this.homeTeamName,
    awayTeamId: awayTeamId ?? this.awayTeamId,
    awayTeamName: awayTeamName ?? this.awayTeamName,
    venue: venue.present ? venue.value : this.venue,
    referee: referee.present ? referee.value : this.referee,
    kickoffUtc: kickoffUtc ?? this.kickoffUtc,
    status: status ?? this.status,
    minute: minute.present ? minute.value : this.minute,
    scoreHome: scoreHome.present ? scoreHome.value : this.scoreHome,
    scoreAway: scoreAway.present ? scoreAway.value : this.scoreAway,
    homeLogo: homeLogo.present ? homeLogo.value : this.homeLogo,
    awayLogo: awayLogo.present ? awayLogo.value : this.awayLogo,
    syncedAt: syncedAt ?? this.syncedAt,
  );
  MatchesTableData copyWithCompanion(MatchesTableCompanion data) {
    return MatchesTableData(
      fixtureId: data.fixtureId.present ? data.fixtureId.value : this.fixtureId,
      leagueId: data.leagueId.present ? data.leagueId.value : this.leagueId,
      season: data.season.present ? data.season.value : this.season,
      leagueName: data.leagueName.present
          ? data.leagueName.value
          : this.leagueName,
      country: data.country.present ? data.country.value : this.country,
      homeTeamId: data.homeTeamId.present
          ? data.homeTeamId.value
          : this.homeTeamId,
      homeTeamName: data.homeTeamName.present
          ? data.homeTeamName.value
          : this.homeTeamName,
      awayTeamId: data.awayTeamId.present
          ? data.awayTeamId.value
          : this.awayTeamId,
      awayTeamName: data.awayTeamName.present
          ? data.awayTeamName.value
          : this.awayTeamName,
      venue: data.venue.present ? data.venue.value : this.venue,
      referee: data.referee.present ? data.referee.value : this.referee,
      kickoffUtc: data.kickoffUtc.present
          ? data.kickoffUtc.value
          : this.kickoffUtc,
      status: data.status.present ? data.status.value : this.status,
      minute: data.minute.present ? data.minute.value : this.minute,
      scoreHome: data.scoreHome.present ? data.scoreHome.value : this.scoreHome,
      scoreAway: data.scoreAway.present ? data.scoreAway.value : this.scoreAway,
      homeLogo: data.homeLogo.present ? data.homeLogo.value : this.homeLogo,
      awayLogo: data.awayLogo.present ? data.awayLogo.value : this.awayLogo,
      syncedAt: data.syncedAt.present ? data.syncedAt.value : this.syncedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MatchesTableData(')
          ..write('fixtureId: $fixtureId, ')
          ..write('leagueId: $leagueId, ')
          ..write('season: $season, ')
          ..write('leagueName: $leagueName, ')
          ..write('country: $country, ')
          ..write('homeTeamId: $homeTeamId, ')
          ..write('homeTeamName: $homeTeamName, ')
          ..write('awayTeamId: $awayTeamId, ')
          ..write('awayTeamName: $awayTeamName, ')
          ..write('venue: $venue, ')
          ..write('referee: $referee, ')
          ..write('kickoffUtc: $kickoffUtc, ')
          ..write('status: $status, ')
          ..write('minute: $minute, ')
          ..write('scoreHome: $scoreHome, ')
          ..write('scoreAway: $scoreAway, ')
          ..write('homeLogo: $homeLogo, ')
          ..write('awayLogo: $awayLogo, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    fixtureId,
    leagueId,
    season,
    leagueName,
    country,
    homeTeamId,
    homeTeamName,
    awayTeamId,
    awayTeamName,
    venue,
    referee,
    kickoffUtc,
    status,
    minute,
    scoreHome,
    scoreAway,
    homeLogo,
    awayLogo,
    syncedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MatchesTableData &&
          other.fixtureId == this.fixtureId &&
          other.leagueId == this.leagueId &&
          other.season == this.season &&
          other.leagueName == this.leagueName &&
          other.country == this.country &&
          other.homeTeamId == this.homeTeamId &&
          other.homeTeamName == this.homeTeamName &&
          other.awayTeamId == this.awayTeamId &&
          other.awayTeamName == this.awayTeamName &&
          other.venue == this.venue &&
          other.referee == this.referee &&
          other.kickoffUtc == this.kickoffUtc &&
          other.status == this.status &&
          other.minute == this.minute &&
          other.scoreHome == this.scoreHome &&
          other.scoreAway == this.scoreAway &&
          other.homeLogo == this.homeLogo &&
          other.awayLogo == this.awayLogo &&
          other.syncedAt == this.syncedAt);
}

class MatchesTableCompanion extends UpdateCompanion<MatchesTableData> {
  final Value<int> fixtureId;
  final Value<int> leagueId;
  final Value<int?> season;
  final Value<String> leagueName;
  final Value<String?> country;
  final Value<int> homeTeamId;
  final Value<String> homeTeamName;
  final Value<int> awayTeamId;
  final Value<String> awayTeamName;
  final Value<String?> venue;
  final Value<String?> referee;
  final Value<DateTime> kickoffUtc;
  final Value<String> status;
  final Value<int?> minute;
  final Value<int?> scoreHome;
  final Value<int?> scoreAway;
  final Value<String?> homeLogo;
  final Value<String?> awayLogo;
  final Value<DateTime> syncedAt;
  const MatchesTableCompanion({
    this.fixtureId = const Value.absent(),
    this.leagueId = const Value.absent(),
    this.season = const Value.absent(),
    this.leagueName = const Value.absent(),
    this.country = const Value.absent(),
    this.homeTeamId = const Value.absent(),
    this.homeTeamName = const Value.absent(),
    this.awayTeamId = const Value.absent(),
    this.awayTeamName = const Value.absent(),
    this.venue = const Value.absent(),
    this.referee = const Value.absent(),
    this.kickoffUtc = const Value.absent(),
    this.status = const Value.absent(),
    this.minute = const Value.absent(),
    this.scoreHome = const Value.absent(),
    this.scoreAway = const Value.absent(),
    this.homeLogo = const Value.absent(),
    this.awayLogo = const Value.absent(),
    this.syncedAt = const Value.absent(),
  });
  MatchesTableCompanion.insert({
    this.fixtureId = const Value.absent(),
    required int leagueId,
    this.season = const Value.absent(),
    required String leagueName,
    this.country = const Value.absent(),
    required int homeTeamId,
    required String homeTeamName,
    required int awayTeamId,
    required String awayTeamName,
    this.venue = const Value.absent(),
    this.referee = const Value.absent(),
    required DateTime kickoffUtc,
    required String status,
    this.minute = const Value.absent(),
    this.scoreHome = const Value.absent(),
    this.scoreAway = const Value.absent(),
    this.homeLogo = const Value.absent(),
    this.awayLogo = const Value.absent(),
    required DateTime syncedAt,
  }) : leagueId = Value(leagueId),
       leagueName = Value(leagueName),
       homeTeamId = Value(homeTeamId),
       homeTeamName = Value(homeTeamName),
       awayTeamId = Value(awayTeamId),
       awayTeamName = Value(awayTeamName),
       kickoffUtc = Value(kickoffUtc),
       status = Value(status),
       syncedAt = Value(syncedAt);
  static Insertable<MatchesTableData> custom({
    Expression<int>? fixtureId,
    Expression<int>? leagueId,
    Expression<int>? season,
    Expression<String>? leagueName,
    Expression<String>? country,
    Expression<int>? homeTeamId,
    Expression<String>? homeTeamName,
    Expression<int>? awayTeamId,
    Expression<String>? awayTeamName,
    Expression<String>? venue,
    Expression<String>? referee,
    Expression<DateTime>? kickoffUtc,
    Expression<String>? status,
    Expression<int>? minute,
    Expression<int>? scoreHome,
    Expression<int>? scoreAway,
    Expression<String>? homeLogo,
    Expression<String>? awayLogo,
    Expression<DateTime>? syncedAt,
  }) {
    return RawValuesInsertable({
      if (fixtureId != null) 'fixture_id': fixtureId,
      if (leagueId != null) 'league_id': leagueId,
      if (season != null) 'season': season,
      if (leagueName != null) 'league_name': leagueName,
      if (country != null) 'country': country,
      if (homeTeamId != null) 'home_team_id': homeTeamId,
      if (homeTeamName != null) 'home_team_name': homeTeamName,
      if (awayTeamId != null) 'away_team_id': awayTeamId,
      if (awayTeamName != null) 'away_team_name': awayTeamName,
      if (venue != null) 'venue': venue,
      if (referee != null) 'referee': referee,
      if (kickoffUtc != null) 'kickoff_utc': kickoffUtc,
      if (status != null) 'status': status,
      if (minute != null) 'minute': minute,
      if (scoreHome != null) 'score_home': scoreHome,
      if (scoreAway != null) 'score_away': scoreAway,
      if (homeLogo != null) 'home_logo': homeLogo,
      if (awayLogo != null) 'away_logo': awayLogo,
      if (syncedAt != null) 'last_synced_at': syncedAt,
    });
  }

  MatchesTableCompanion copyWith({
    Value<int>? fixtureId,
    Value<int>? leagueId,
    Value<int?>? season,
    Value<String>? leagueName,
    Value<String?>? country,
    Value<int>? homeTeamId,
    Value<String>? homeTeamName,
    Value<int>? awayTeamId,
    Value<String>? awayTeamName,
    Value<String?>? venue,
    Value<String?>? referee,
    Value<DateTime>? kickoffUtc,
    Value<String>? status,
    Value<int?>? minute,
    Value<int?>? scoreHome,
    Value<int?>? scoreAway,
    Value<String?>? homeLogo,
    Value<String?>? awayLogo,
    Value<DateTime>? syncedAt,
  }) {
    return MatchesTableCompanion(
      fixtureId: fixtureId ?? this.fixtureId,
      leagueId: leagueId ?? this.leagueId,
      season: season ?? this.season,
      leagueName: leagueName ?? this.leagueName,
      country: country ?? this.country,
      homeTeamId: homeTeamId ?? this.homeTeamId,
      homeTeamName: homeTeamName ?? this.homeTeamName,
      awayTeamId: awayTeamId ?? this.awayTeamId,
      awayTeamName: awayTeamName ?? this.awayTeamName,
      venue: venue ?? this.venue,
      referee: referee ?? this.referee,
      kickoffUtc: kickoffUtc ?? this.kickoffUtc,
      status: status ?? this.status,
      minute: minute ?? this.minute,
      scoreHome: scoreHome ?? this.scoreHome,
      scoreAway: scoreAway ?? this.scoreAway,
      homeLogo: homeLogo ?? this.homeLogo,
      awayLogo: awayLogo ?? this.awayLogo,
      syncedAt: syncedAt ?? this.syncedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fixtureId.present) {
      map['fixture_id'] = Variable<int>(fixtureId.value);
    }
    if (leagueId.present) {
      map['league_id'] = Variable<int>(leagueId.value);
    }
    if (season.present) {
      map['season'] = Variable<int>(season.value);
    }
    if (leagueName.present) {
      map['league_name'] = Variable<String>(leagueName.value);
    }
    if (country.present) {
      map['country'] = Variable<String>(country.value);
    }
    if (homeTeamId.present) {
      map['home_team_id'] = Variable<int>(homeTeamId.value);
    }
    if (homeTeamName.present) {
      map['home_team_name'] = Variable<String>(homeTeamName.value);
    }
    if (awayTeamId.present) {
      map['away_team_id'] = Variable<int>(awayTeamId.value);
    }
    if (awayTeamName.present) {
      map['away_team_name'] = Variable<String>(awayTeamName.value);
    }
    if (venue.present) {
      map['venue'] = Variable<String>(venue.value);
    }
    if (referee.present) {
      map['referee'] = Variable<String>(referee.value);
    }
    if (kickoffUtc.present) {
      map['kickoff_utc'] = Variable<DateTime>(kickoffUtc.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (minute.present) {
      map['minute'] = Variable<int>(minute.value);
    }
    if (scoreHome.present) {
      map['score_home'] = Variable<int>(scoreHome.value);
    }
    if (scoreAway.present) {
      map['score_away'] = Variable<int>(scoreAway.value);
    }
    if (homeLogo.present) {
      map['home_logo'] = Variable<String>(homeLogo.value);
    }
    if (awayLogo.present) {
      map['away_logo'] = Variable<String>(awayLogo.value);
    }
    if (syncedAt.present) {
      map['last_synced_at'] = Variable<DateTime>(syncedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MatchesTableCompanion(')
          ..write('fixtureId: $fixtureId, ')
          ..write('leagueId: $leagueId, ')
          ..write('season: $season, ')
          ..write('leagueName: $leagueName, ')
          ..write('country: $country, ')
          ..write('homeTeamId: $homeTeamId, ')
          ..write('homeTeamName: $homeTeamName, ')
          ..write('awayTeamId: $awayTeamId, ')
          ..write('awayTeamName: $awayTeamName, ')
          ..write('venue: $venue, ')
          ..write('referee: $referee, ')
          ..write('kickoffUtc: $kickoffUtc, ')
          ..write('status: $status, ')
          ..write('minute: $minute, ')
          ..write('scoreHome: $scoreHome, ')
          ..write('scoreAway: $scoreAway, ')
          ..write('homeLogo: $homeLogo, ')
          ..write('awayLogo: $awayLogo, ')
          ..write('syncedAt: $syncedAt')
          ..write(')'))
        .toString();
  }
}

class $OddsTableTable extends OddsTable
    with TableInfo<$OddsTableTable, OddsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OddsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _fixtureIdMeta = const VerificationMeta(
    'fixtureId',
  );
  @override
  late final GeneratedColumn<int> fixtureId = GeneratedColumn<int>(
    'fixture_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES matches_table (fixture_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _homeOddMeta = const VerificationMeta(
    'homeOdd',
  );
  @override
  late final GeneratedColumn<double> homeOdd = GeneratedColumn<double>(
    'home_odd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _drawOddMeta = const VerificationMeta(
    'drawOdd',
  );
  @override
  late final GeneratedColumn<double> drawOdd = GeneratedColumn<double>(
    'draw_odd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _awayOddMeta = const VerificationMeta(
    'awayOdd',
  );
  @override
  late final GeneratedColumn<double> awayOdd = GeneratedColumn<double>(
    'away_odd',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _providerMeta = const VerificationMeta(
    'provider',
  );
  @override
  late final GeneratedColumn<String> provider = GeneratedColumn<String>(
    'provider',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _takenAtMeta = const VerificationMeta(
    'takenAt',
  );
  @override
  late final GeneratedColumn<DateTime> takenAt = GeneratedColumn<DateTime>(
    'taken_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    fixtureId,
    homeOdd,
    drawOdd,
    awayOdd,
    provider,
    takenAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'odds_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<OddsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('fixture_id')) {
      context.handle(
        _fixtureIdMeta,
        fixtureId.isAcceptableOrUnknown(data['fixture_id']!, _fixtureIdMeta),
      );
    }
    if (data.containsKey('home_odd')) {
      context.handle(
        _homeOddMeta,
        homeOdd.isAcceptableOrUnknown(data['home_odd']!, _homeOddMeta),
      );
    } else if (isInserting) {
      context.missing(_homeOddMeta);
    }
    if (data.containsKey('draw_odd')) {
      context.handle(
        _drawOddMeta,
        drawOdd.isAcceptableOrUnknown(data['draw_odd']!, _drawOddMeta),
      );
    } else if (isInserting) {
      context.missing(_drawOddMeta);
    }
    if (data.containsKey('away_odd')) {
      context.handle(
        _awayOddMeta,
        awayOdd.isAcceptableOrUnknown(data['away_odd']!, _awayOddMeta),
      );
    } else if (isInserting) {
      context.missing(_awayOddMeta);
    }
    if (data.containsKey('provider')) {
      context.handle(
        _providerMeta,
        provider.isAcceptableOrUnknown(data['provider']!, _providerMeta),
      );
    }
    if (data.containsKey('taken_at')) {
      context.handle(
        _takenAtMeta,
        takenAt.isAcceptableOrUnknown(data['taken_at']!, _takenAtMeta),
      );
    } else if (isInserting) {
      context.missing(_takenAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {fixtureId};
  @override
  OddsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return OddsTableData(
      fixtureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixture_id'],
      )!,
      homeOdd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}home_odd'],
      )!,
      drawOdd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}draw_odd'],
      )!,
      awayOdd: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}away_odd'],
      )!,
      provider: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}provider'],
      ),
      takenAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}taken_at'],
      )!,
    );
  }

  @override
  $OddsTableTable createAlias(String alias) {
    return $OddsTableTable(attachedDatabase, alias);
  }
}

class OddsTableData extends DataClass implements Insertable<OddsTableData> {
  final int fixtureId;
  final double homeOdd;
  final double drawOdd;
  final double awayOdd;
  final String? provider;
  final DateTime takenAt;
  const OddsTableData({
    required this.fixtureId,
    required this.homeOdd,
    required this.drawOdd,
    required this.awayOdd,
    this.provider,
    required this.takenAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['fixture_id'] = Variable<int>(fixtureId);
    map['home_odd'] = Variable<double>(homeOdd);
    map['draw_odd'] = Variable<double>(drawOdd);
    map['away_odd'] = Variable<double>(awayOdd);
    if (!nullToAbsent || provider != null) {
      map['provider'] = Variable<String>(provider);
    }
    map['taken_at'] = Variable<DateTime>(takenAt);
    return map;
  }

  OddsTableCompanion toCompanion(bool nullToAbsent) {
    return OddsTableCompanion(
      fixtureId: Value(fixtureId),
      homeOdd: Value(homeOdd),
      drawOdd: Value(drawOdd),
      awayOdd: Value(awayOdd),
      provider: provider == null && nullToAbsent
          ? const Value.absent()
          : Value(provider),
      takenAt: Value(takenAt),
    );
  }

  factory OddsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OddsTableData(
      fixtureId: serializer.fromJson<int>(json['fixtureId']),
      homeOdd: serializer.fromJson<double>(json['homeOdd']),
      drawOdd: serializer.fromJson<double>(json['drawOdd']),
      awayOdd: serializer.fromJson<double>(json['awayOdd']),
      provider: serializer.fromJson<String?>(json['provider']),
      takenAt: serializer.fromJson<DateTime>(json['takenAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'fixtureId': serializer.toJson<int>(fixtureId),
      'homeOdd': serializer.toJson<double>(homeOdd),
      'drawOdd': serializer.toJson<double>(drawOdd),
      'awayOdd': serializer.toJson<double>(awayOdd),
      'provider': serializer.toJson<String?>(provider),
      'takenAt': serializer.toJson<DateTime>(takenAt),
    };
  }

  OddsTableData copyWith({
    int? fixtureId,
    double? homeOdd,
    double? drawOdd,
    double? awayOdd,
    Value<String?> provider = const Value.absent(),
    DateTime? takenAt,
  }) => OddsTableData(
    fixtureId: fixtureId ?? this.fixtureId,
    homeOdd: homeOdd ?? this.homeOdd,
    drawOdd: drawOdd ?? this.drawOdd,
    awayOdd: awayOdd ?? this.awayOdd,
    provider: provider.present ? provider.value : this.provider,
    takenAt: takenAt ?? this.takenAt,
  );
  OddsTableData copyWithCompanion(OddsTableCompanion data) {
    return OddsTableData(
      fixtureId: data.fixtureId.present ? data.fixtureId.value : this.fixtureId,
      homeOdd: data.homeOdd.present ? data.homeOdd.value : this.homeOdd,
      drawOdd: data.drawOdd.present ? data.drawOdd.value : this.drawOdd,
      awayOdd: data.awayOdd.present ? data.awayOdd.value : this.awayOdd,
      provider: data.provider.present ? data.provider.value : this.provider,
      takenAt: data.takenAt.present ? data.takenAt.value : this.takenAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('OddsTableData(')
          ..write('fixtureId: $fixtureId, ')
          ..write('homeOdd: $homeOdd, ')
          ..write('drawOdd: $drawOdd, ')
          ..write('awayOdd: $awayOdd, ')
          ..write('provider: $provider, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(fixtureId, homeOdd, drawOdd, awayOdd, provider, takenAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OddsTableData &&
          other.fixtureId == this.fixtureId &&
          other.homeOdd == this.homeOdd &&
          other.drawOdd == this.drawOdd &&
          other.awayOdd == this.awayOdd &&
          other.provider == this.provider &&
          other.takenAt == this.takenAt);
}

class OddsTableCompanion extends UpdateCompanion<OddsTableData> {
  final Value<int> fixtureId;
  final Value<double> homeOdd;
  final Value<double> drawOdd;
  final Value<double> awayOdd;
  final Value<String?> provider;
  final Value<DateTime> takenAt;
  const OddsTableCompanion({
    this.fixtureId = const Value.absent(),
    this.homeOdd = const Value.absent(),
    this.drawOdd = const Value.absent(),
    this.awayOdd = const Value.absent(),
    this.provider = const Value.absent(),
    this.takenAt = const Value.absent(),
  });
  OddsTableCompanion.insert({
    this.fixtureId = const Value.absent(),
    required double homeOdd,
    required double drawOdd,
    required double awayOdd,
    this.provider = const Value.absent(),
    required DateTime takenAt,
  }) : homeOdd = Value(homeOdd),
       drawOdd = Value(drawOdd),
       awayOdd = Value(awayOdd),
       takenAt = Value(takenAt);
  static Insertable<OddsTableData> custom({
    Expression<int>? fixtureId,
    Expression<double>? homeOdd,
    Expression<double>? drawOdd,
    Expression<double>? awayOdd,
    Expression<String>? provider,
    Expression<DateTime>? takenAt,
  }) {
    return RawValuesInsertable({
      if (fixtureId != null) 'fixture_id': fixtureId,
      if (homeOdd != null) 'home_odd': homeOdd,
      if (drawOdd != null) 'draw_odd': drawOdd,
      if (awayOdd != null) 'away_odd': awayOdd,
      if (provider != null) 'provider': provider,
      if (takenAt != null) 'taken_at': takenAt,
    });
  }

  OddsTableCompanion copyWith({
    Value<int>? fixtureId,
    Value<double>? homeOdd,
    Value<double>? drawOdd,
    Value<double>? awayOdd,
    Value<String?>? provider,
    Value<DateTime>? takenAt,
  }) {
    return OddsTableCompanion(
      fixtureId: fixtureId ?? this.fixtureId,
      homeOdd: homeOdd ?? this.homeOdd,
      drawOdd: drawOdd ?? this.drawOdd,
      awayOdd: awayOdd ?? this.awayOdd,
      provider: provider ?? this.provider,
      takenAt: takenAt ?? this.takenAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (fixtureId.present) {
      map['fixture_id'] = Variable<int>(fixtureId.value);
    }
    if (homeOdd.present) {
      map['home_odd'] = Variable<double>(homeOdd.value);
    }
    if (drawOdd.present) {
      map['draw_odd'] = Variable<double>(drawOdd.value);
    }
    if (awayOdd.present) {
      map['away_odd'] = Variable<double>(awayOdd.value);
    }
    if (provider.present) {
      map['provider'] = Variable<String>(provider.value);
    }
    if (takenAt.present) {
      map['taken_at'] = Variable<DateTime>(takenAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OddsTableCompanion(')
          ..write('fixtureId: $fixtureId, ')
          ..write('homeOdd: $homeOdd, ')
          ..write('drawOdd: $drawOdd, ')
          ..write('awayOdd: $awayOdd, ')
          ..write('provider: $provider, ')
          ..write('takenAt: $takenAt')
          ..write(')'))
        .toString();
  }
}

class $PredictionsTableTable extends PredictionsTable
    with TableInfo<$PredictionsTableTable, PredictionsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PredictionsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fixtureIdMeta = const VerificationMeta(
    'fixtureId',
  );
  @override
  late final GeneratedColumn<int> fixtureId = GeneratedColumn<int>(
    'fixture_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES matches_table (fixture_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _pickMeta = const VerificationMeta('pick');
  @override
  late final GeneratedColumn<String> pick = GeneratedColumn<String>(
    'pick',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oddsMeta = const VerificationMeta('odds');
  @override
  late final GeneratedColumn<double> odds = GeneratedColumn<double>(
    'odds',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _lockedAtMeta = const VerificationMeta(
    'lockedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lockedAt = GeneratedColumn<DateTime>(
    'locked_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _gradedAtMeta = const VerificationMeta(
    'gradedAt',
  );
  @override
  late final GeneratedColumn<DateTime> gradedAt = GeneratedColumn<DateTime>(
    'graded_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resultMeta = const VerificationMeta('result');
  @override
  late final GeneratedColumn<String> result = GeneratedColumn<String>(
    'result',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _openedDetailsMeta = const VerificationMeta(
    'openedDetails',
  );
  @override
  late final GeneratedColumn<bool> openedDetails = GeneratedColumn<bool>(
    'opened_details',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("opened_details" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fixtureId,
    pick,
    odds,
    createdAt,
    lockedAt,
    gradedAt,
    result,
    openedDetails,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'predictions_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<PredictionsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fixture_id')) {
      context.handle(
        _fixtureIdMeta,
        fixtureId.isAcceptableOrUnknown(data['fixture_id']!, _fixtureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fixtureIdMeta);
    }
    if (data.containsKey('pick')) {
      context.handle(
        _pickMeta,
        pick.isAcceptableOrUnknown(data['pick']!, _pickMeta),
      );
    } else if (isInserting) {
      context.missing(_pickMeta);
    }
    if (data.containsKey('odds')) {
      context.handle(
        _oddsMeta,
        odds.isAcceptableOrUnknown(data['odds']!, _oddsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('locked_at')) {
      context.handle(
        _lockedAtMeta,
        lockedAt.isAcceptableOrUnknown(data['locked_at']!, _lockedAtMeta),
      );
    }
    if (data.containsKey('graded_at')) {
      context.handle(
        _gradedAtMeta,
        gradedAt.isAcceptableOrUnknown(data['graded_at']!, _gradedAtMeta),
      );
    }
    if (data.containsKey('result')) {
      context.handle(
        _resultMeta,
        result.isAcceptableOrUnknown(data['result']!, _resultMeta),
      );
    }
    if (data.containsKey('opened_details')) {
      context.handle(
        _openedDetailsMeta,
        openedDetails.isAcceptableOrUnknown(
          data['opened_details']!,
          _openedDetailsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PredictionsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PredictionsTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fixtureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixture_id'],
      )!,
      pick: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pick'],
      )!,
      odds: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odds'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      lockedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}locked_at'],
      ),
      gradedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}graded_at'],
      ),
      result: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}result'],
      ),
      openedDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}opened_details'],
      )!,
    );
  }

  @override
  $PredictionsTableTable createAlias(String alias) {
    return $PredictionsTableTable(attachedDatabase, alias);
  }
}

class PredictionsTableData extends DataClass
    implements Insertable<PredictionsTableData> {
  final int id;
  final int fixtureId;
  final String pick;
  final double? odds;
  final DateTime createdAt;
  final DateTime? lockedAt;
  final DateTime? gradedAt;
  final String? result;
  final bool openedDetails;
  const PredictionsTableData({
    required this.id,
    required this.fixtureId,
    required this.pick,
    this.odds,
    required this.createdAt,
    this.lockedAt,
    this.gradedAt,
    this.result,
    required this.openedDetails,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fixture_id'] = Variable<int>(fixtureId);
    map['pick'] = Variable<String>(pick);
    if (!nullToAbsent || odds != null) {
      map['odds'] = Variable<double>(odds);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lockedAt != null) {
      map['locked_at'] = Variable<DateTime>(lockedAt);
    }
    if (!nullToAbsent || gradedAt != null) {
      map['graded_at'] = Variable<DateTime>(gradedAt);
    }
    if (!nullToAbsent || result != null) {
      map['result'] = Variable<String>(result);
    }
    map['opened_details'] = Variable<bool>(openedDetails);
    return map;
  }

  PredictionsTableCompanion toCompanion(bool nullToAbsent) {
    return PredictionsTableCompanion(
      id: Value(id),
      fixtureId: Value(fixtureId),
      pick: Value(pick),
      odds: odds == null && nullToAbsent ? const Value.absent() : Value(odds),
      createdAt: Value(createdAt),
      lockedAt: lockedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lockedAt),
      gradedAt: gradedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(gradedAt),
      result: result == null && nullToAbsent
          ? const Value.absent()
          : Value(result),
      openedDetails: Value(openedDetails),
    );
  }

  factory PredictionsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PredictionsTableData(
      id: serializer.fromJson<int>(json['id']),
      fixtureId: serializer.fromJson<int>(json['fixtureId']),
      pick: serializer.fromJson<String>(json['pick']),
      odds: serializer.fromJson<double?>(json['odds']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lockedAt: serializer.fromJson<DateTime?>(json['lockedAt']),
      gradedAt: serializer.fromJson<DateTime?>(json['gradedAt']),
      result: serializer.fromJson<String?>(json['result']),
      openedDetails: serializer.fromJson<bool>(json['openedDetails']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fixtureId': serializer.toJson<int>(fixtureId),
      'pick': serializer.toJson<String>(pick),
      'odds': serializer.toJson<double?>(odds),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lockedAt': serializer.toJson<DateTime?>(lockedAt),
      'gradedAt': serializer.toJson<DateTime?>(gradedAt),
      'result': serializer.toJson<String?>(result),
      'openedDetails': serializer.toJson<bool>(openedDetails),
    };
  }

  PredictionsTableData copyWith({
    int? id,
    int? fixtureId,
    String? pick,
    Value<double?> odds = const Value.absent(),
    DateTime? createdAt,
    Value<DateTime?> lockedAt = const Value.absent(),
    Value<DateTime?> gradedAt = const Value.absent(),
    Value<String?> result = const Value.absent(),
    bool? openedDetails,
  }) => PredictionsTableData(
    id: id ?? this.id,
    fixtureId: fixtureId ?? this.fixtureId,
    pick: pick ?? this.pick,
    odds: odds.present ? odds.value : this.odds,
    createdAt: createdAt ?? this.createdAt,
    lockedAt: lockedAt.present ? lockedAt.value : this.lockedAt,
    gradedAt: gradedAt.present ? gradedAt.value : this.gradedAt,
    result: result.present ? result.value : this.result,
    openedDetails: openedDetails ?? this.openedDetails,
  );
  PredictionsTableData copyWithCompanion(PredictionsTableCompanion data) {
    return PredictionsTableData(
      id: data.id.present ? data.id.value : this.id,
      fixtureId: data.fixtureId.present ? data.fixtureId.value : this.fixtureId,
      pick: data.pick.present ? data.pick.value : this.pick,
      odds: data.odds.present ? data.odds.value : this.odds,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lockedAt: data.lockedAt.present ? data.lockedAt.value : this.lockedAt,
      gradedAt: data.gradedAt.present ? data.gradedAt.value : this.gradedAt,
      result: data.result.present ? data.result.value : this.result,
      openedDetails: data.openedDetails.present
          ? data.openedDetails.value
          : this.openedDetails,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PredictionsTableData(')
          ..write('id: $id, ')
          ..write('fixtureId: $fixtureId, ')
          ..write('pick: $pick, ')
          ..write('odds: $odds, ')
          ..write('createdAt: $createdAt, ')
          ..write('lockedAt: $lockedAt, ')
          ..write('gradedAt: $gradedAt, ')
          ..write('result: $result, ')
          ..write('openedDetails: $openedDetails')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fixtureId,
    pick,
    odds,
    createdAt,
    lockedAt,
    gradedAt,
    result,
    openedDetails,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PredictionsTableData &&
          other.id == this.id &&
          other.fixtureId == this.fixtureId &&
          other.pick == this.pick &&
          other.odds == this.odds &&
          other.createdAt == this.createdAt &&
          other.lockedAt == this.lockedAt &&
          other.gradedAt == this.gradedAt &&
          other.result == this.result &&
          other.openedDetails == this.openedDetails);
}

class PredictionsTableCompanion extends UpdateCompanion<PredictionsTableData> {
  final Value<int> id;
  final Value<int> fixtureId;
  final Value<String> pick;
  final Value<double?> odds;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lockedAt;
  final Value<DateTime?> gradedAt;
  final Value<String?> result;
  final Value<bool> openedDetails;
  const PredictionsTableCompanion({
    this.id = const Value.absent(),
    this.fixtureId = const Value.absent(),
    this.pick = const Value.absent(),
    this.odds = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lockedAt = const Value.absent(),
    this.gradedAt = const Value.absent(),
    this.result = const Value.absent(),
    this.openedDetails = const Value.absent(),
  });
  PredictionsTableCompanion.insert({
    this.id = const Value.absent(),
    required int fixtureId,
    required String pick,
    this.odds = const Value.absent(),
    required DateTime createdAt,
    this.lockedAt = const Value.absent(),
    this.gradedAt = const Value.absent(),
    this.result = const Value.absent(),
    this.openedDetails = const Value.absent(),
  }) : fixtureId = Value(fixtureId),
       pick = Value(pick),
       createdAt = Value(createdAt);
  static Insertable<PredictionsTableData> custom({
    Expression<int>? id,
    Expression<int>? fixtureId,
    Expression<String>? pick,
    Expression<double>? odds,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lockedAt,
    Expression<DateTime>? gradedAt,
    Expression<String>? result,
    Expression<bool>? openedDetails,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fixtureId != null) 'fixture_id': fixtureId,
      if (pick != null) 'pick': pick,
      if (odds != null) 'odds': odds,
      if (createdAt != null) 'created_at': createdAt,
      if (lockedAt != null) 'locked_at': lockedAt,
      if (gradedAt != null) 'graded_at': gradedAt,
      if (result != null) 'result': result,
      if (openedDetails != null) 'opened_details': openedDetails,
    });
  }

  PredictionsTableCompanion copyWith({
    Value<int>? id,
    Value<int>? fixtureId,
    Value<String>? pick,
    Value<double?>? odds,
    Value<DateTime>? createdAt,
    Value<DateTime?>? lockedAt,
    Value<DateTime?>? gradedAt,
    Value<String?>? result,
    Value<bool>? openedDetails,
  }) {
    return PredictionsTableCompanion(
      id: id ?? this.id,
      fixtureId: fixtureId ?? this.fixtureId,
      pick: pick ?? this.pick,
      odds: odds ?? this.odds,
      createdAt: createdAt ?? this.createdAt,
      lockedAt: lockedAt ?? this.lockedAt,
      gradedAt: gradedAt ?? this.gradedAt,
      result: result ?? this.result,
      openedDetails: openedDetails ?? this.openedDetails,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fixtureId.present) {
      map['fixture_id'] = Variable<int>(fixtureId.value);
    }
    if (pick.present) {
      map['pick'] = Variable<String>(pick.value);
    }
    if (odds.present) {
      map['odds'] = Variable<double>(odds.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lockedAt.present) {
      map['locked_at'] = Variable<DateTime>(lockedAt.value);
    }
    if (gradedAt.present) {
      map['graded_at'] = Variable<DateTime>(gradedAt.value);
    }
    if (result.present) {
      map['result'] = Variable<String>(result.value);
    }
    if (openedDetails.present) {
      map['opened_details'] = Variable<bool>(openedDetails.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PredictionsTableCompanion(')
          ..write('id: $id, ')
          ..write('fixtureId: $fixtureId, ')
          ..write('pick: $pick, ')
          ..write('odds: $odds, ')
          ..write('createdAt: $createdAt, ')
          ..write('lockedAt: $lockedAt, ')
          ..write('gradedAt: $gradedAt, ')
          ..write('result: $result, ')
          ..write('openedDetails: $openedDetails')
          ..write(')'))
        .toString();
  }
}

class $FavoritesTableTable extends FavoritesTable
    with TableInfo<$FavoritesTableTable, FavoritesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FavoritesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
    'type',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _refIdMeta = const VerificationMeta('refId');
  @override
  late final GeneratedColumn<int> refId = GeneratedColumn<int>(
    'ref_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, type, refId, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'favorites_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<FavoritesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('type')) {
      context.handle(
        _typeMeta,
        type.isAcceptableOrUnknown(data['type']!, _typeMeta),
      );
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('ref_id')) {
      context.handle(
        _refIdMeta,
        refId.isAcceptableOrUnknown(data['ref_id']!, _refIdMeta),
      );
    } else if (isInserting) {
      context.missing(_refIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {type, refId},
  ];
  @override
  FavoritesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FavoritesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      type: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}type'],
      )!,
      refId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ref_id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $FavoritesTableTable createAlias(String alias) {
    return $FavoritesTableTable(attachedDatabase, alias);
  }
}

class FavoritesTableData extends DataClass
    implements Insertable<FavoritesTableData> {
  final int id;
  final String type;
  final int refId;
  final DateTime createdAt;
  const FavoritesTableData({
    required this.id,
    required this.type,
    required this.refId,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['type'] = Variable<String>(type);
    map['ref_id'] = Variable<int>(refId);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  FavoritesTableCompanion toCompanion(bool nullToAbsent) {
    return FavoritesTableCompanion(
      id: Value(id),
      type: Value(type),
      refId: Value(refId),
      createdAt: Value(createdAt),
    );
  }

  factory FavoritesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FavoritesTableData(
      id: serializer.fromJson<int>(json['id']),
      type: serializer.fromJson<String>(json['type']),
      refId: serializer.fromJson<int>(json['refId']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'type': serializer.toJson<String>(type),
      'refId': serializer.toJson<int>(refId),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  FavoritesTableData copyWith({
    int? id,
    String? type,
    int? refId,
    DateTime? createdAt,
  }) => FavoritesTableData(
    id: id ?? this.id,
    type: type ?? this.type,
    refId: refId ?? this.refId,
    createdAt: createdAt ?? this.createdAt,
  );
  FavoritesTableData copyWithCompanion(FavoritesTableCompanion data) {
    return FavoritesTableData(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      refId: data.refId.present ? data.refId.value : this.refId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesTableData(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('refId: $refId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, type, refId, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FavoritesTableData &&
          other.id == this.id &&
          other.type == this.type &&
          other.refId == this.refId &&
          other.createdAt == this.createdAt);
}

class FavoritesTableCompanion extends UpdateCompanion<FavoritesTableData> {
  final Value<int> id;
  final Value<String> type;
  final Value<int> refId;
  final Value<DateTime> createdAt;
  const FavoritesTableCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.refId = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  FavoritesTableCompanion.insert({
    this.id = const Value.absent(),
    required String type,
    required int refId,
    required DateTime createdAt,
  }) : type = Value(type),
       refId = Value(refId),
       createdAt = Value(createdAt);
  static Insertable<FavoritesTableData> custom({
    Expression<int>? id,
    Expression<String>? type,
    Expression<int>? refId,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (refId != null) 'ref_id': refId,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  FavoritesTableCompanion copyWith({
    Value<int>? id,
    Value<String>? type,
    Value<int>? refId,
    Value<DateTime>? createdAt,
  }) {
    return FavoritesTableCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      refId: refId ?? this.refId,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (refId.present) {
      map['ref_id'] = Variable<int>(refId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FavoritesTableCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('refId: $refId, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $NotesTableTable extends NotesTable
    with TableInfo<$NotesTableTable, NotesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _fixtureIdMeta = const VerificationMeta(
    'fixtureId',
  );
  @override
  late final GeneratedColumn<int> fixtureId = GeneratedColumn<int>(
    'fixture_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES matches_table (fixture_id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _noteTextMeta = const VerificationMeta(
    'noteText',
  );
  @override
  late final GeneratedColumn<String> noteText = GeneratedColumn<String>(
    'text',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, fixtureId, noteText, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<NotesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('fixture_id')) {
      context.handle(
        _fixtureIdMeta,
        fixtureId.isAcceptableOrUnknown(data['fixture_id']!, _fixtureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_fixtureIdMeta);
    }
    if (data.containsKey('text')) {
      context.handle(
        _noteTextMeta,
        noteText.isAcceptableOrUnknown(data['text']!, _noteTextMeta),
      );
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {fixtureId},
  ];
  @override
  NotesTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NotesTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      fixtureId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}fixture_id'],
      )!,
      noteText: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}text'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $NotesTableTable createAlias(String alias) {
    return $NotesTableTable(attachedDatabase, alias);
  }
}

class NotesTableData extends DataClass implements Insertable<NotesTableData> {
  final int id;
  final int fixtureId;
  final String noteText;
  final DateTime updatedAt;
  const NotesTableData({
    required this.id,
    required this.fixtureId,
    required this.noteText,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['fixture_id'] = Variable<int>(fixtureId);
    map['text'] = Variable<String>(noteText);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  NotesTableCompanion toCompanion(bool nullToAbsent) {
    return NotesTableCompanion(
      id: Value(id),
      fixtureId: Value(fixtureId),
      noteText: Value(noteText),
      updatedAt: Value(updatedAt),
    );
  }

  factory NotesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotesTableData(
      id: serializer.fromJson<int>(json['id']),
      fixtureId: serializer.fromJson<int>(json['fixtureId']),
      noteText: serializer.fromJson<String>(json['noteText']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'fixtureId': serializer.toJson<int>(fixtureId),
      'noteText': serializer.toJson<String>(noteText),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  NotesTableData copyWith({
    int? id,
    int? fixtureId,
    String? noteText,
    DateTime? updatedAt,
  }) => NotesTableData(
    id: id ?? this.id,
    fixtureId: fixtureId ?? this.fixtureId,
    noteText: noteText ?? this.noteText,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  NotesTableData copyWithCompanion(NotesTableCompanion data) {
    return NotesTableData(
      id: data.id.present ? data.id.value : this.id,
      fixtureId: data.fixtureId.present ? data.fixtureId.value : this.fixtureId,
      noteText: data.noteText.present ? data.noteText.value : this.noteText,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NotesTableData(')
          ..write('id: $id, ')
          ..write('fixtureId: $fixtureId, ')
          ..write('noteText: $noteText, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, fixtureId, noteText, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotesTableData &&
          other.id == this.id &&
          other.fixtureId == this.fixtureId &&
          other.noteText == this.noteText &&
          other.updatedAt == this.updatedAt);
}

class NotesTableCompanion extends UpdateCompanion<NotesTableData> {
  final Value<int> id;
  final Value<int> fixtureId;
  final Value<String> noteText;
  final Value<DateTime> updatedAt;
  const NotesTableCompanion({
    this.id = const Value.absent(),
    this.fixtureId = const Value.absent(),
    this.noteText = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  NotesTableCompanion.insert({
    this.id = const Value.absent(),
    required int fixtureId,
    required String noteText,
    required DateTime updatedAt,
  }) : fixtureId = Value(fixtureId),
       noteText = Value(noteText),
       updatedAt = Value(updatedAt);
  static Insertable<NotesTableData> custom({
    Expression<int>? id,
    Expression<int>? fixtureId,
    Expression<String>? noteText,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fixtureId != null) 'fixture_id': fixtureId,
      if (noteText != null) 'text': noteText,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  NotesTableCompanion copyWith({
    Value<int>? id,
    Value<int>? fixtureId,
    Value<String>? noteText,
    Value<DateTime>? updatedAt,
  }) {
    return NotesTableCompanion(
      id: id ?? this.id,
      fixtureId: fixtureId ?? this.fixtureId,
      noteText: noteText ?? this.noteText,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (fixtureId.present) {
      map['fixture_id'] = Variable<int>(fixtureId.value);
    }
    if (noteText.present) {
      map['text'] = Variable<String>(noteText.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesTableCompanion(')
          ..write('id: $id, ')
          ..write('fixtureId: $fixtureId, ')
          ..write('noteText: $noteText, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $AchievementsTableTable extends AchievementsTable
    with TableInfo<$AchievementsTableTable, AchievementsTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AchievementsTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _codeMeta = const VerificationMeta('code');
  @override
  late final GeneratedColumn<String> code = GeneratedColumn<String>(
    'code',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _earnedAtMeta = const VerificationMeta(
    'earnedAt',
  );
  @override
  late final GeneratedColumn<DateTime> earnedAt = GeneratedColumn<DateTime>(
    'earned_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [code, title, description, earnedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'achievements_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<AchievementsTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('code')) {
      context.handle(
        _codeMeta,
        code.isAcceptableOrUnknown(data['code']!, _codeMeta),
      );
    } else if (isInserting) {
      context.missing(_codeMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('earned_at')) {
      context.handle(
        _earnedAtMeta,
        earnedAt.isAcceptableOrUnknown(data['earned_at']!, _earnedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {code};
  @override
  AchievementsTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AchievementsTableData(
      code: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}code'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      earnedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}earned_at'],
      ),
    );
  }

  @override
  $AchievementsTableTable createAlias(String alias) {
    return $AchievementsTableTable(attachedDatabase, alias);
  }
}

class AchievementsTableData extends DataClass
    implements Insertable<AchievementsTableData> {
  final String code;
  final String title;
  final String description;
  final DateTime? earnedAt;
  const AchievementsTableData({
    required this.code,
    required this.title,
    required this.description,
    this.earnedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['code'] = Variable<String>(code);
    map['title'] = Variable<String>(title);
    map['description'] = Variable<String>(description);
    if (!nullToAbsent || earnedAt != null) {
      map['earned_at'] = Variable<DateTime>(earnedAt);
    }
    return map;
  }

  AchievementsTableCompanion toCompanion(bool nullToAbsent) {
    return AchievementsTableCompanion(
      code: Value(code),
      title: Value(title),
      description: Value(description),
      earnedAt: earnedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(earnedAt),
    );
  }

  factory AchievementsTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AchievementsTableData(
      code: serializer.fromJson<String>(json['code']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String>(json['description']),
      earnedAt: serializer.fromJson<DateTime?>(json['earnedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'code': serializer.toJson<String>(code),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String>(description),
      'earnedAt': serializer.toJson<DateTime?>(earnedAt),
    };
  }

  AchievementsTableData copyWith({
    String? code,
    String? title,
    String? description,
    Value<DateTime?> earnedAt = const Value.absent(),
  }) => AchievementsTableData(
    code: code ?? this.code,
    title: title ?? this.title,
    description: description ?? this.description,
    earnedAt: earnedAt.present ? earnedAt.value : this.earnedAt,
  );
  AchievementsTableData copyWithCompanion(AchievementsTableCompanion data) {
    return AchievementsTableData(
      code: data.code.present ? data.code.value : this.code,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      earnedAt: data.earnedAt.present ? data.earnedAt.value : this.earnedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsTableData(')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('earnedAt: $earnedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(code, title, description, earnedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AchievementsTableData &&
          other.code == this.code &&
          other.title == this.title &&
          other.description == this.description &&
          other.earnedAt == this.earnedAt);
}

class AchievementsTableCompanion
    extends UpdateCompanion<AchievementsTableData> {
  final Value<String> code;
  final Value<String> title;
  final Value<String> description;
  final Value<DateTime?> earnedAt;
  final Value<int> rowid;
  const AchievementsTableCompanion({
    this.code = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.earnedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AchievementsTableCompanion.insert({
    required String code,
    required String title,
    required String description,
    this.earnedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : code = Value(code),
       title = Value(title),
       description = Value(description);
  static Insertable<AchievementsTableData> custom({
    Expression<String>? code,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? earnedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (code != null) 'code': code,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (earnedAt != null) 'earned_at': earnedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AchievementsTableCompanion copyWith({
    Value<String>? code,
    Value<String>? title,
    Value<String>? description,
    Value<DateTime?>? earnedAt,
    Value<int>? rowid,
  }) {
    return AchievementsTableCompanion(
      code: code ?? this.code,
      title: title ?? this.title,
      description: description ?? this.description,
      earnedAt: earnedAt ?? this.earnedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (code.present) {
      map['code'] = Variable<String>(code.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (earnedAt.present) {
      map['earned_at'] = Variable<DateTime>(earnedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AchievementsTableCompanion(')
          ..write('code: $code, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('earnedAt: $earnedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProfileTableTable extends ProfileTable
    with TableInfo<$ProfileTableTable, ProfileTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProfileTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _usernameMeta = const VerificationMeta(
    'username',
  );
  @override
  late final GeneratedColumn<String> username = GeneratedColumn<String>(
    'username',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _avatarIdMeta = const VerificationMeta(
    'avatarId',
  );
  @override
  late final GeneratedColumn<int> avatarId = GeneratedColumn<int>(
    'avatar_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metricsCacheJsonMeta = const VerificationMeta(
    'metricsCacheJson',
  );
  @override
  late final GeneratedColumn<String> metricsCacheJson = GeneratedColumn<String>(
    'metrics_cache_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _resetMarkersJsonMeta = const VerificationMeta(
    'resetMarkersJson',
  );
  @override
  late final GeneratedColumn<String> resetMarkersJson = GeneratedColumn<String>(
    'reset_markers_json',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    username,
    avatarId,
    metricsCacheJson,
    resetMarkersJson,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'profile_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<ProfileTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('username')) {
      context.handle(
        _usernameMeta,
        username.isAcceptableOrUnknown(data['username']!, _usernameMeta),
      );
    } else if (isInserting) {
      context.missing(_usernameMeta);
    }
    if (data.containsKey('avatar_id')) {
      context.handle(
        _avatarIdMeta,
        avatarId.isAcceptableOrUnknown(data['avatar_id']!, _avatarIdMeta),
      );
    } else if (isInserting) {
      context.missing(_avatarIdMeta);
    }
    if (data.containsKey('metrics_cache_json')) {
      context.handle(
        _metricsCacheJsonMeta,
        metricsCacheJson.isAcceptableOrUnknown(
          data['metrics_cache_json']!,
          _metricsCacheJsonMeta,
        ),
      );
    }
    if (data.containsKey('reset_markers_json')) {
      context.handle(
        _resetMarkersJsonMeta,
        resetMarkersJson.isAcceptableOrUnknown(
          data['reset_markers_json']!,
          _resetMarkersJsonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ProfileTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ProfileTableData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      username: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}username'],
      )!,
      avatarId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avatar_id'],
      )!,
      metricsCacheJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metrics_cache_json'],
      ),
      resetMarkersJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reset_markers_json'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
    );
  }

  @override
  $ProfileTableTable createAlias(String alias) {
    return $ProfileTableTable(attachedDatabase, alias);
  }
}

class ProfileTableData extends DataClass
    implements Insertable<ProfileTableData> {
  final int id;
  final String username;
  final int avatarId;
  final String? metricsCacheJson;
  final String? resetMarkersJson;
  final DateTime? updatedAt;
  const ProfileTableData({
    required this.id,
    required this.username,
    required this.avatarId,
    this.metricsCacheJson,
    this.resetMarkersJson,
    this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['username'] = Variable<String>(username);
    map['avatar_id'] = Variable<int>(avatarId);
    if (!nullToAbsent || metricsCacheJson != null) {
      map['metrics_cache_json'] = Variable<String>(metricsCacheJson);
    }
    if (!nullToAbsent || resetMarkersJson != null) {
      map['reset_markers_json'] = Variable<String>(resetMarkersJson);
    }
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    return map;
  }

  ProfileTableCompanion toCompanion(bool nullToAbsent) {
    return ProfileTableCompanion(
      id: Value(id),
      username: Value(username),
      avatarId: Value(avatarId),
      metricsCacheJson: metricsCacheJson == null && nullToAbsent
          ? const Value.absent()
          : Value(metricsCacheJson),
      resetMarkersJson: resetMarkersJson == null && nullToAbsent
          ? const Value.absent()
          : Value(resetMarkersJson),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
    );
  }

  factory ProfileTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ProfileTableData(
      id: serializer.fromJson<int>(json['id']),
      username: serializer.fromJson<String>(json['username']),
      avatarId: serializer.fromJson<int>(json['avatarId']),
      metricsCacheJson: serializer.fromJson<String?>(json['metricsCacheJson']),
      resetMarkersJson: serializer.fromJson<String?>(json['resetMarkersJson']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'username': serializer.toJson<String>(username),
      'avatarId': serializer.toJson<int>(avatarId),
      'metricsCacheJson': serializer.toJson<String?>(metricsCacheJson),
      'resetMarkersJson': serializer.toJson<String?>(resetMarkersJson),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
    };
  }

  ProfileTableData copyWith({
    int? id,
    String? username,
    int? avatarId,
    Value<String?> metricsCacheJson = const Value.absent(),
    Value<String?> resetMarkersJson = const Value.absent(),
    Value<DateTime?> updatedAt = const Value.absent(),
  }) => ProfileTableData(
    id: id ?? this.id,
    username: username ?? this.username,
    avatarId: avatarId ?? this.avatarId,
    metricsCacheJson: metricsCacheJson.present
        ? metricsCacheJson.value
        : this.metricsCacheJson,
    resetMarkersJson: resetMarkersJson.present
        ? resetMarkersJson.value
        : this.resetMarkersJson,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
  );
  ProfileTableData copyWithCompanion(ProfileTableCompanion data) {
    return ProfileTableData(
      id: data.id.present ? data.id.value : this.id,
      username: data.username.present ? data.username.value : this.username,
      avatarId: data.avatarId.present ? data.avatarId.value : this.avatarId,
      metricsCacheJson: data.metricsCacheJson.present
          ? data.metricsCacheJson.value
          : this.metricsCacheJson,
      resetMarkersJson: data.resetMarkersJson.present
          ? data.resetMarkersJson.value
          : this.resetMarkersJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTableData(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('avatarId: $avatarId, ')
          ..write('metricsCacheJson: $metricsCacheJson, ')
          ..write('resetMarkersJson: $resetMarkersJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    username,
    avatarId,
    metricsCacheJson,
    resetMarkersJson,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ProfileTableData &&
          other.id == this.id &&
          other.username == this.username &&
          other.avatarId == this.avatarId &&
          other.metricsCacheJson == this.metricsCacheJson &&
          other.resetMarkersJson == this.resetMarkersJson &&
          other.updatedAt == this.updatedAt);
}

class ProfileTableCompanion extends UpdateCompanion<ProfileTableData> {
  final Value<int> id;
  final Value<String> username;
  final Value<int> avatarId;
  final Value<String?> metricsCacheJson;
  final Value<String?> resetMarkersJson;
  final Value<DateTime?> updatedAt;
  const ProfileTableCompanion({
    this.id = const Value.absent(),
    this.username = const Value.absent(),
    this.avatarId = const Value.absent(),
    this.metricsCacheJson = const Value.absent(),
    this.resetMarkersJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  ProfileTableCompanion.insert({
    this.id = const Value.absent(),
    required String username,
    required int avatarId,
    this.metricsCacheJson = const Value.absent(),
    this.resetMarkersJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
  }) : username = Value(username),
       avatarId = Value(avatarId);
  static Insertable<ProfileTableData> custom({
    Expression<int>? id,
    Expression<String>? username,
    Expression<int>? avatarId,
    Expression<String>? metricsCacheJson,
    Expression<String>? resetMarkersJson,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (username != null) 'username': username,
      if (avatarId != null) 'avatar_id': avatarId,
      if (metricsCacheJson != null) 'metrics_cache_json': metricsCacheJson,
      if (resetMarkersJson != null) 'reset_markers_json': resetMarkersJson,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  ProfileTableCompanion copyWith({
    Value<int>? id,
    Value<String>? username,
    Value<int>? avatarId,
    Value<String?>? metricsCacheJson,
    Value<String?>? resetMarkersJson,
    Value<DateTime?>? updatedAt,
  }) {
    return ProfileTableCompanion(
      id: id ?? this.id,
      username: username ?? this.username,
      avatarId: avatarId ?? this.avatarId,
      metricsCacheJson: metricsCacheJson ?? this.metricsCacheJson,
      resetMarkersJson: resetMarkersJson ?? this.resetMarkersJson,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (username.present) {
      map['username'] = Variable<String>(username.value);
    }
    if (avatarId.present) {
      map['avatar_id'] = Variable<int>(avatarId.value);
    }
    if (metricsCacheJson.present) {
      map['metrics_cache_json'] = Variable<String>(metricsCacheJson.value);
    }
    if (resetMarkersJson.present) {
      map['reset_markers_json'] = Variable<String>(resetMarkersJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProfileTableCompanion(')
          ..write('id: $id, ')
          ..write('username: $username, ')
          ..write('avatarId: $avatarId, ')
          ..write('metricsCacheJson: $metricsCacheJson, ')
          ..write('resetMarkersJson: $resetMarkersJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $JournalEntriesTableTable extends JournalEntriesTable
    with TableInfo<$JournalEntriesTableTable, JournalEntriesTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $JournalEntriesTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dateYmdMeta = const VerificationMeta(
    'dateYmd',
  );
  @override
  late final GeneratedColumn<String> dateYmd = GeneratedColumn<String>(
    'date_ymd',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventsJsonMeta = const VerificationMeta(
    'eventsJson',
  );
  @override
  late final GeneratedColumn<String> eventsJson = GeneratedColumn<String>(
    'events_json',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [dateYmd, eventsJson, updatedAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'journal_entries_table';
  @override
  VerificationContext validateIntegrity(
    Insertable<JournalEntriesTableData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('date_ymd')) {
      context.handle(
        _dateYmdMeta,
        dateYmd.isAcceptableOrUnknown(data['date_ymd']!, _dateYmdMeta),
      );
    } else if (isInserting) {
      context.missing(_dateYmdMeta);
    }
    if (data.containsKey('events_json')) {
      context.handle(
        _eventsJsonMeta,
        eventsJson.isAcceptableOrUnknown(data['events_json']!, _eventsJsonMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dateYmd};
  @override
  JournalEntriesTableData map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return JournalEntriesTableData(
      dateYmd: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}date_ymd'],
      )!,
      eventsJson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}events_json'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $JournalEntriesTableTable createAlias(String alias) {
    return $JournalEntriesTableTable(attachedDatabase, alias);
  }
}

class JournalEntriesTableData extends DataClass
    implements Insertable<JournalEntriesTableData> {
  final String dateYmd;
  final String eventsJson;
  final DateTime updatedAt;
  const JournalEntriesTableData({
    required this.dateYmd,
    required this.eventsJson,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['date_ymd'] = Variable<String>(dateYmd);
    map['events_json'] = Variable<String>(eventsJson);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  JournalEntriesTableCompanion toCompanion(bool nullToAbsent) {
    return JournalEntriesTableCompanion(
      dateYmd: Value(dateYmd),
      eventsJson: Value(eventsJson),
      updatedAt: Value(updatedAt),
    );
  }

  factory JournalEntriesTableData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return JournalEntriesTableData(
      dateYmd: serializer.fromJson<String>(json['dateYmd']),
      eventsJson: serializer.fromJson<String>(json['eventsJson']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dateYmd': serializer.toJson<String>(dateYmd),
      'eventsJson': serializer.toJson<String>(eventsJson),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  JournalEntriesTableData copyWith({
    String? dateYmd,
    String? eventsJson,
    DateTime? updatedAt,
  }) => JournalEntriesTableData(
    dateYmd: dateYmd ?? this.dateYmd,
    eventsJson: eventsJson ?? this.eventsJson,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  JournalEntriesTableData copyWithCompanion(JournalEntriesTableCompanion data) {
    return JournalEntriesTableData(
      dateYmd: data.dateYmd.present ? data.dateYmd.value : this.dateYmd,
      eventsJson: data.eventsJson.present
          ? data.eventsJson.value
          : this.eventsJson,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesTableData(')
          ..write('dateYmd: $dateYmd, ')
          ..write('eventsJson: $eventsJson, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(dateYmd, eventsJson, updatedAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is JournalEntriesTableData &&
          other.dateYmd == this.dateYmd &&
          other.eventsJson == this.eventsJson &&
          other.updatedAt == this.updatedAt);
}

class JournalEntriesTableCompanion
    extends UpdateCompanion<JournalEntriesTableData> {
  final Value<String> dateYmd;
  final Value<String> eventsJson;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const JournalEntriesTableCompanion({
    this.dateYmd = const Value.absent(),
    this.eventsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  JournalEntriesTableCompanion.insert({
    required String dateYmd,
    this.eventsJson = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : dateYmd = Value(dateYmd);
  static Insertable<JournalEntriesTableData> custom({
    Expression<String>? dateYmd,
    Expression<String>? eventsJson,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dateYmd != null) 'date_ymd': dateYmd,
      if (eventsJson != null) 'events_json': eventsJson,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  JournalEntriesTableCompanion copyWith({
    Value<String>? dateYmd,
    Value<String>? eventsJson,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return JournalEntriesTableCompanion(
      dateYmd: dateYmd ?? this.dateYmd,
      eventsJson: eventsJson ?? this.eventsJson,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dateYmd.present) {
      map['date_ymd'] = Variable<String>(dateYmd.value);
    }
    if (eventsJson.present) {
      map['events_json'] = Variable<String>(eventsJson.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('JournalEntriesTableCompanion(')
          ..write('dateYmd: $dateYmd, ')
          ..write('eventsJson: $eventsJson, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $MatchesTableTable matchesTable = $MatchesTableTable(this);
  late final $OddsTableTable oddsTable = $OddsTableTable(this);
  late final $PredictionsTableTable predictionsTable = $PredictionsTableTable(
    this,
  );
  late final $FavoritesTableTable favoritesTable = $FavoritesTableTable(this);
  late final $NotesTableTable notesTable = $NotesTableTable(this);
  late final $AchievementsTableTable achievementsTable =
      $AchievementsTableTable(this);
  late final $ProfileTableTable profileTable = $ProfileTableTable(this);
  late final $JournalEntriesTableTable journalEntriesTable =
      $JournalEntriesTableTable(this);
  late final MatchesDao matchesDao = MatchesDao(this as AppDatabase);
  late final OddsDao oddsDao = OddsDao(this as AppDatabase);
  late final PredictionsDao predictionsDao = PredictionsDao(
    this as AppDatabase,
  );
  late final FavoritesDao favoritesDao = FavoritesDao(this as AppDatabase);
  late final NotesDao notesDao = NotesDao(this as AppDatabase);
  late final AchievementsDao achievementsDao = AchievementsDao(
    this as AppDatabase,
  );
  late final ProfileDao profileDao = ProfileDao(this as AppDatabase);
  late final JournalDao journalDao = JournalDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    matchesTable,
    oddsTable,
    predictionsTable,
    favoritesTable,
    notesTable,
    achievementsTable,
    profileTable,
    journalEntriesTable,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'matches_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('odds_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'matches_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('predictions_table', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'matches_table',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('notes_table', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$MatchesTableTableCreateCompanionBuilder =
    MatchesTableCompanion Function({
      Value<int> fixtureId,
      required int leagueId,
      Value<int?> season,
      required String leagueName,
      Value<String?> country,
      required int homeTeamId,
      required String homeTeamName,
      required int awayTeamId,
      required String awayTeamName,
      Value<String?> venue,
      Value<String?> referee,
      required DateTime kickoffUtc,
      required String status,
      Value<int?> minute,
      Value<int?> scoreHome,
      Value<int?> scoreAway,
      Value<String?> homeLogo,
      Value<String?> awayLogo,
      required DateTime syncedAt,
    });
typedef $$MatchesTableTableUpdateCompanionBuilder =
    MatchesTableCompanion Function({
      Value<int> fixtureId,
      Value<int> leagueId,
      Value<int?> season,
      Value<String> leagueName,
      Value<String?> country,
      Value<int> homeTeamId,
      Value<String> homeTeamName,
      Value<int> awayTeamId,
      Value<String> awayTeamName,
      Value<String?> venue,
      Value<String?> referee,
      Value<DateTime> kickoffUtc,
      Value<String> status,
      Value<int?> minute,
      Value<int?> scoreHome,
      Value<int?> scoreAway,
      Value<String?> homeLogo,
      Value<String?> awayLogo,
      Value<DateTime> syncedAt,
    });

final class $$MatchesTableTableReferences
    extends
        BaseReferences<_$AppDatabase, $MatchesTableTable, MatchesTableData> {
  $$MatchesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OddsTableTable, List<OddsTableData>>
  _oddsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.oddsTable,
    aliasName: $_aliasNameGenerator(
      db.matchesTable.fixtureId,
      db.oddsTable.fixtureId,
    ),
  );

  $$OddsTableTableProcessedTableManager get oddsTableRefs {
    final manager = $$OddsTableTableTableManager($_db, $_db.oddsTable).filter(
      (f) => f.fixtureId.fixtureId.sqlEquals($_itemColumn<int>('fixture_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_oddsTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PredictionsTableTable, List<PredictionsTableData>>
  _predictionsTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.predictionsTable,
    aliasName: $_aliasNameGenerator(
      db.matchesTable.fixtureId,
      db.predictionsTable.fixtureId,
    ),
  );

  $$PredictionsTableTableProcessedTableManager get predictionsTableRefs {
    final manager =
        $$PredictionsTableTableTableManager($_db, $_db.predictionsTable).filter(
          (f) =>
              f.fixtureId.fixtureId.sqlEquals($_itemColumn<int>('fixture_id')!),
        );

    final cache = $_typedResult.readTableOrNull(
      _predictionsTableRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$NotesTableTable, List<NotesTableData>>
  _notesTableRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.notesTable,
    aliasName: $_aliasNameGenerator(
      db.matchesTable.fixtureId,
      db.notesTable.fixtureId,
    ),
  );

  $$NotesTableTableProcessedTableManager get notesTableRefs {
    final manager = $$NotesTableTableTableManager($_db, $_db.notesTable).filter(
      (f) => f.fixtureId.fixtureId.sqlEquals($_itemColumn<int>('fixture_id')!),
    );

    final cache = $_typedResult.readTableOrNull(_notesTableRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MatchesTableTableFilterComposer
    extends Composer<_$AppDatabase, $MatchesTableTable> {
  $$MatchesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get fixtureId => $composableBuilder(
    column: $table.fixtureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get leagueId => $composableBuilder(
    column: $table.leagueId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get leagueName => $composableBuilder(
    column: $table.leagueName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get homeTeamId => $composableBuilder(
    column: $table.homeTeamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeTeamName => $composableBuilder(
    column: $table.homeTeamName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get awayTeamId => $composableBuilder(
    column: $table.awayTeamId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get awayTeamName => $composableBuilder(
    column: $table.awayTeamName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get referee => $composableBuilder(
    column: $table.referee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get kickoffUtc => $composableBuilder(
    column: $table.kickoffUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreHome => $composableBuilder(
    column: $table.scoreHome,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get scoreAway => $composableBuilder(
    column: $table.scoreAway,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get homeLogo => $composableBuilder(
    column: $table.homeLogo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get awayLogo => $composableBuilder(
    column: $table.awayLogo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> oddsTableRefs(
    Expression<bool> Function($$OddsTableTableFilterComposer f) f,
  ) {
    final $$OddsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.oddsTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OddsTableTableFilterComposer(
            $db: $db,
            $table: $db.oddsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> predictionsTableRefs(
    Expression<bool> Function($$PredictionsTableTableFilterComposer f) f,
  ) {
    final $$PredictionsTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.predictionsTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PredictionsTableTableFilterComposer(
            $db: $db,
            $table: $db.predictionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> notesTableRefs(
    Expression<bool> Function($$NotesTableTableFilterComposer f) f,
  ) {
    final $$NotesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.notesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableTableFilterComposer(
            $db: $db,
            $table: $db.notesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $MatchesTableTable> {
  $$MatchesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get fixtureId => $composableBuilder(
    column: $table.fixtureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get leagueId => $composableBuilder(
    column: $table.leagueId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get season => $composableBuilder(
    column: $table.season,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get leagueName => $composableBuilder(
    column: $table.leagueName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get country => $composableBuilder(
    column: $table.country,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get homeTeamId => $composableBuilder(
    column: $table.homeTeamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeTeamName => $composableBuilder(
    column: $table.homeTeamName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get awayTeamId => $composableBuilder(
    column: $table.awayTeamId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get awayTeamName => $composableBuilder(
    column: $table.awayTeamName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get venue => $composableBuilder(
    column: $table.venue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get referee => $composableBuilder(
    column: $table.referee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get kickoffUtc => $composableBuilder(
    column: $table.kickoffUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minute => $composableBuilder(
    column: $table.minute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreHome => $composableBuilder(
    column: $table.scoreHome,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scoreAway => $composableBuilder(
    column: $table.scoreAway,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get homeLogo => $composableBuilder(
    column: $table.homeLogo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get awayLogo => $composableBuilder(
    column: $table.awayLogo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get syncedAt => $composableBuilder(
    column: $table.syncedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MatchesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $MatchesTableTable> {
  $$MatchesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get fixtureId =>
      $composableBuilder(column: $table.fixtureId, builder: (column) => column);

  GeneratedColumn<int> get leagueId =>
      $composableBuilder(column: $table.leagueId, builder: (column) => column);

  GeneratedColumn<int> get season =>
      $composableBuilder(column: $table.season, builder: (column) => column);

  GeneratedColumn<String> get leagueName => $composableBuilder(
    column: $table.leagueName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get country =>
      $composableBuilder(column: $table.country, builder: (column) => column);

  GeneratedColumn<int> get homeTeamId => $composableBuilder(
    column: $table.homeTeamId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get homeTeamName => $composableBuilder(
    column: $table.homeTeamName,
    builder: (column) => column,
  );

  GeneratedColumn<int> get awayTeamId => $composableBuilder(
    column: $table.awayTeamId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get awayTeamName => $composableBuilder(
    column: $table.awayTeamName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get venue =>
      $composableBuilder(column: $table.venue, builder: (column) => column);

  GeneratedColumn<String> get referee =>
      $composableBuilder(column: $table.referee, builder: (column) => column);

  GeneratedColumn<DateTime> get kickoffUtc => $composableBuilder(
    column: $table.kickoffUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<int> get minute =>
      $composableBuilder(column: $table.minute, builder: (column) => column);

  GeneratedColumn<int> get scoreHome =>
      $composableBuilder(column: $table.scoreHome, builder: (column) => column);

  GeneratedColumn<int> get scoreAway =>
      $composableBuilder(column: $table.scoreAway, builder: (column) => column);

  GeneratedColumn<String> get homeLogo =>
      $composableBuilder(column: $table.homeLogo, builder: (column) => column);

  GeneratedColumn<String> get awayLogo =>
      $composableBuilder(column: $table.awayLogo, builder: (column) => column);

  GeneratedColumn<DateTime> get syncedAt =>
      $composableBuilder(column: $table.syncedAt, builder: (column) => column);

  Expression<T> oddsTableRefs<T extends Object>(
    Expression<T> Function($$OddsTableTableAnnotationComposer a) f,
  ) {
    final $$OddsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.oddsTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OddsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.oddsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> predictionsTableRefs<T extends Object>(
    Expression<T> Function($$PredictionsTableTableAnnotationComposer a) f,
  ) {
    final $$PredictionsTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.predictionsTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PredictionsTableTableAnnotationComposer(
            $db: $db,
            $table: $db.predictionsTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> notesTableRefs<T extends Object>(
    Expression<T> Function($$NotesTableTableAnnotationComposer a) f,
  ) {
    final $$NotesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.notesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$NotesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.notesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MatchesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MatchesTableTable,
          MatchesTableData,
          $$MatchesTableTableFilterComposer,
          $$MatchesTableTableOrderingComposer,
          $$MatchesTableTableAnnotationComposer,
          $$MatchesTableTableCreateCompanionBuilder,
          $$MatchesTableTableUpdateCompanionBuilder,
          (MatchesTableData, $$MatchesTableTableReferences),
          MatchesTableData,
          PrefetchHooks Function({
            bool oddsTableRefs,
            bool predictionsTableRefs,
            bool notesTableRefs,
          })
        > {
  $$MatchesTableTableTableManager(_$AppDatabase db, $MatchesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MatchesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MatchesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MatchesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> fixtureId = const Value.absent(),
                Value<int> leagueId = const Value.absent(),
                Value<int?> season = const Value.absent(),
                Value<String> leagueName = const Value.absent(),
                Value<String?> country = const Value.absent(),
                Value<int> homeTeamId = const Value.absent(),
                Value<String> homeTeamName = const Value.absent(),
                Value<int> awayTeamId = const Value.absent(),
                Value<String> awayTeamName = const Value.absent(),
                Value<String?> venue = const Value.absent(),
                Value<String?> referee = const Value.absent(),
                Value<DateTime> kickoffUtc = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<int?> minute = const Value.absent(),
                Value<int?> scoreHome = const Value.absent(),
                Value<int?> scoreAway = const Value.absent(),
                Value<String?> homeLogo = const Value.absent(),
                Value<String?> awayLogo = const Value.absent(),
                Value<DateTime> syncedAt = const Value.absent(),
              }) => MatchesTableCompanion(
                fixtureId: fixtureId,
                leagueId: leagueId,
                season: season,
                leagueName: leagueName,
                country: country,
                homeTeamId: homeTeamId,
                homeTeamName: homeTeamName,
                awayTeamId: awayTeamId,
                awayTeamName: awayTeamName,
                venue: venue,
                referee: referee,
                kickoffUtc: kickoffUtc,
                status: status,
                minute: minute,
                scoreHome: scoreHome,
                scoreAway: scoreAway,
                homeLogo: homeLogo,
                awayLogo: awayLogo,
                syncedAt: syncedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> fixtureId = const Value.absent(),
                required int leagueId,
                Value<int?> season = const Value.absent(),
                required String leagueName,
                Value<String?> country = const Value.absent(),
                required int homeTeamId,
                required String homeTeamName,
                required int awayTeamId,
                required String awayTeamName,
                Value<String?> venue = const Value.absent(),
                Value<String?> referee = const Value.absent(),
                required DateTime kickoffUtc,
                required String status,
                Value<int?> minute = const Value.absent(),
                Value<int?> scoreHome = const Value.absent(),
                Value<int?> scoreAway = const Value.absent(),
                Value<String?> homeLogo = const Value.absent(),
                Value<String?> awayLogo = const Value.absent(),
                required DateTime syncedAt,
              }) => MatchesTableCompanion.insert(
                fixtureId: fixtureId,
                leagueId: leagueId,
                season: season,
                leagueName: leagueName,
                country: country,
                homeTeamId: homeTeamId,
                homeTeamName: homeTeamName,
                awayTeamId: awayTeamId,
                awayTeamName: awayTeamName,
                venue: venue,
                referee: referee,
                kickoffUtc: kickoffUtc,
                status: status,
                minute: minute,
                scoreHome: scoreHome,
                scoreAway: scoreAway,
                homeLogo: homeLogo,
                awayLogo: awayLogo,
                syncedAt: syncedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MatchesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                oddsTableRefs = false,
                predictionsTableRefs = false,
                notesTableRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (oddsTableRefs) db.oddsTable,
                    if (predictionsTableRefs) db.predictionsTable,
                    if (notesTableRefs) db.notesTable,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (oddsTableRefs)
                        await $_getPrefetchedData<
                          MatchesTableData,
                          $MatchesTableTable,
                          OddsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$MatchesTableTableReferences
                              ._oddsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).oddsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fixtureId == item.fixtureId,
                              ),
                          typedResults: items,
                        ),
                      if (predictionsTableRefs)
                        await $_getPrefetchedData<
                          MatchesTableData,
                          $MatchesTableTable,
                          PredictionsTableData
                        >(
                          currentTable: table,
                          referencedTable: $$MatchesTableTableReferences
                              ._predictionsTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).predictionsTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fixtureId == item.fixtureId,
                              ),
                          typedResults: items,
                        ),
                      if (notesTableRefs)
                        await $_getPrefetchedData<
                          MatchesTableData,
                          $MatchesTableTable,
                          NotesTableData
                        >(
                          currentTable: table,
                          referencedTable: $$MatchesTableTableReferences
                              ._notesTableRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MatchesTableTableReferences(
                                db,
                                table,
                                p0,
                              ).notesTableRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.fixtureId == item.fixtureId,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MatchesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MatchesTableTable,
      MatchesTableData,
      $$MatchesTableTableFilterComposer,
      $$MatchesTableTableOrderingComposer,
      $$MatchesTableTableAnnotationComposer,
      $$MatchesTableTableCreateCompanionBuilder,
      $$MatchesTableTableUpdateCompanionBuilder,
      (MatchesTableData, $$MatchesTableTableReferences),
      MatchesTableData,
      PrefetchHooks Function({
        bool oddsTableRefs,
        bool predictionsTableRefs,
        bool notesTableRefs,
      })
    >;
typedef $$OddsTableTableCreateCompanionBuilder =
    OddsTableCompanion Function({
      Value<int> fixtureId,
      required double homeOdd,
      required double drawOdd,
      required double awayOdd,
      Value<String?> provider,
      required DateTime takenAt,
    });
typedef $$OddsTableTableUpdateCompanionBuilder =
    OddsTableCompanion Function({
      Value<int> fixtureId,
      Value<double> homeOdd,
      Value<double> drawOdd,
      Value<double> awayOdd,
      Value<String?> provider,
      Value<DateTime> takenAt,
    });

final class $$OddsTableTableReferences
    extends BaseReferences<_$AppDatabase, $OddsTableTable, OddsTableData> {
  $$OddsTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTableTable _fixtureIdTable(_$AppDatabase db) =>
      db.matchesTable.createAlias(
        $_aliasNameGenerator(db.oddsTable.fixtureId, db.matchesTable.fixtureId),
      );

  $$MatchesTableTableProcessedTableManager get fixtureId {
    final $_column = $_itemColumn<int>('fixture_id')!;

    final manager = $$MatchesTableTableTableManager(
      $_db,
      $_db.matchesTable,
    ).filter((f) => f.fixtureId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fixtureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$OddsTableTableFilterComposer
    extends Composer<_$AppDatabase, $OddsTableTable> {
  $$OddsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<double> get homeOdd => $composableBuilder(
    column: $table.homeOdd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get drawOdd => $composableBuilder(
    column: $table.drawOdd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get awayOdd => $composableBuilder(
    column: $table.awayOdd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchesTableTableFilterComposer get fixtureId {
    final $$MatchesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableFilterComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OddsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $OddsTableTable> {
  $$OddsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<double> get homeOdd => $composableBuilder(
    column: $table.homeOdd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get drawOdd => $composableBuilder(
    column: $table.drawOdd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get awayOdd => $composableBuilder(
    column: $table.awayOdd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get provider => $composableBuilder(
    column: $table.provider,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get takenAt => $composableBuilder(
    column: $table.takenAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchesTableTableOrderingComposer get fixtureId {
    final $$MatchesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableOrderingComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OddsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $OddsTableTable> {
  $$OddsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<double> get homeOdd =>
      $composableBuilder(column: $table.homeOdd, builder: (column) => column);

  GeneratedColumn<double> get drawOdd =>
      $composableBuilder(column: $table.drawOdd, builder: (column) => column);

  GeneratedColumn<double> get awayOdd =>
      $composableBuilder(column: $table.awayOdd, builder: (column) => column);

  GeneratedColumn<String> get provider =>
      $composableBuilder(column: $table.provider, builder: (column) => column);

  GeneratedColumn<DateTime> get takenAt =>
      $composableBuilder(column: $table.takenAt, builder: (column) => column);

  $$MatchesTableTableAnnotationComposer get fixtureId {
    final $$MatchesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OddsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OddsTableTable,
          OddsTableData,
          $$OddsTableTableFilterComposer,
          $$OddsTableTableOrderingComposer,
          $$OddsTableTableAnnotationComposer,
          $$OddsTableTableCreateCompanionBuilder,
          $$OddsTableTableUpdateCompanionBuilder,
          (OddsTableData, $$OddsTableTableReferences),
          OddsTableData,
          PrefetchHooks Function({bool fixtureId})
        > {
  $$OddsTableTableTableManager(_$AppDatabase db, $OddsTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OddsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OddsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OddsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> fixtureId = const Value.absent(),
                Value<double> homeOdd = const Value.absent(),
                Value<double> drawOdd = const Value.absent(),
                Value<double> awayOdd = const Value.absent(),
                Value<String?> provider = const Value.absent(),
                Value<DateTime> takenAt = const Value.absent(),
              }) => OddsTableCompanion(
                fixtureId: fixtureId,
                homeOdd: homeOdd,
                drawOdd: drawOdd,
                awayOdd: awayOdd,
                provider: provider,
                takenAt: takenAt,
              ),
          createCompanionCallback:
              ({
                Value<int> fixtureId = const Value.absent(),
                required double homeOdd,
                required double drawOdd,
                required double awayOdd,
                Value<String?> provider = const Value.absent(),
                required DateTime takenAt,
              }) => OddsTableCompanion.insert(
                fixtureId: fixtureId,
                homeOdd: homeOdd,
                drawOdd: drawOdd,
                awayOdd: awayOdd,
                provider: provider,
                takenAt: takenAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$OddsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fixtureId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fixtureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fixtureId,
                                referencedTable: $$OddsTableTableReferences
                                    ._fixtureIdTable(db),
                                referencedColumn: $$OddsTableTableReferences
                                    ._fixtureIdTable(db)
                                    .fixtureId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$OddsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OddsTableTable,
      OddsTableData,
      $$OddsTableTableFilterComposer,
      $$OddsTableTableOrderingComposer,
      $$OddsTableTableAnnotationComposer,
      $$OddsTableTableCreateCompanionBuilder,
      $$OddsTableTableUpdateCompanionBuilder,
      (OddsTableData, $$OddsTableTableReferences),
      OddsTableData,
      PrefetchHooks Function({bool fixtureId})
    >;
typedef $$PredictionsTableTableCreateCompanionBuilder =
    PredictionsTableCompanion Function({
      Value<int> id,
      required int fixtureId,
      required String pick,
      Value<double?> odds,
      required DateTime createdAt,
      Value<DateTime?> lockedAt,
      Value<DateTime?> gradedAt,
      Value<String?> result,
      Value<bool> openedDetails,
    });
typedef $$PredictionsTableTableUpdateCompanionBuilder =
    PredictionsTableCompanion Function({
      Value<int> id,
      Value<int> fixtureId,
      Value<String> pick,
      Value<double?> odds,
      Value<DateTime> createdAt,
      Value<DateTime?> lockedAt,
      Value<DateTime?> gradedAt,
      Value<String?> result,
      Value<bool> openedDetails,
    });

final class $$PredictionsTableTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $PredictionsTableTable,
          PredictionsTableData
        > {
  $$PredictionsTableTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MatchesTableTable _fixtureIdTable(_$AppDatabase db) =>
      db.matchesTable.createAlias(
        $_aliasNameGenerator(
          db.predictionsTable.fixtureId,
          db.matchesTable.fixtureId,
        ),
      );

  $$MatchesTableTableProcessedTableManager get fixtureId {
    final $_column = $_itemColumn<int>('fixture_id')!;

    final manager = $$MatchesTableTableTableManager(
      $_db,
      $_db.matchesTable,
    ).filter((f) => f.fixtureId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fixtureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PredictionsTableTableFilterComposer
    extends Composer<_$AppDatabase, $PredictionsTableTable> {
  $$PredictionsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pick => $composableBuilder(
    column: $table.pick,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odds => $composableBuilder(
    column: $table.odds,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get lockedAt => $composableBuilder(
    column: $table.lockedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get gradedAt => $composableBuilder(
    column: $table.gradedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get openedDetails => $composableBuilder(
    column: $table.openedDetails,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchesTableTableFilterComposer get fixtureId {
    final $$MatchesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableFilterComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $PredictionsTableTable> {
  $$PredictionsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pick => $composableBuilder(
    column: $table.pick,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odds => $composableBuilder(
    column: $table.odds,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lockedAt => $composableBuilder(
    column: $table.lockedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get gradedAt => $composableBuilder(
    column: $table.gradedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get result => $composableBuilder(
    column: $table.result,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get openedDetails => $composableBuilder(
    column: $table.openedDetails,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchesTableTableOrderingComposer get fixtureId {
    final $$MatchesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableOrderingComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $PredictionsTableTable> {
  $$PredictionsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get pick =>
      $composableBuilder(column: $table.pick, builder: (column) => column);

  GeneratedColumn<double> get odds =>
      $composableBuilder(column: $table.odds, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lockedAt =>
      $composableBuilder(column: $table.lockedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get gradedAt =>
      $composableBuilder(column: $table.gradedAt, builder: (column) => column);

  GeneratedColumn<String> get result =>
      $composableBuilder(column: $table.result, builder: (column) => column);

  GeneratedColumn<bool> get openedDetails => $composableBuilder(
    column: $table.openedDetails,
    builder: (column) => column,
  );

  $$MatchesTableTableAnnotationComposer get fixtureId {
    final $$MatchesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PredictionsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PredictionsTableTable,
          PredictionsTableData,
          $$PredictionsTableTableFilterComposer,
          $$PredictionsTableTableOrderingComposer,
          $$PredictionsTableTableAnnotationComposer,
          $$PredictionsTableTableCreateCompanionBuilder,
          $$PredictionsTableTableUpdateCompanionBuilder,
          (PredictionsTableData, $$PredictionsTableTableReferences),
          PredictionsTableData,
          PrefetchHooks Function({bool fixtureId})
        > {
  $$PredictionsTableTableTableManager(
    _$AppDatabase db,
    $PredictionsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PredictionsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PredictionsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PredictionsTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fixtureId = const Value.absent(),
                Value<String> pick = const Value.absent(),
                Value<double?> odds = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> lockedAt = const Value.absent(),
                Value<DateTime?> gradedAt = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<bool> openedDetails = const Value.absent(),
              }) => PredictionsTableCompanion(
                id: id,
                fixtureId: fixtureId,
                pick: pick,
                odds: odds,
                createdAt: createdAt,
                lockedAt: lockedAt,
                gradedAt: gradedAt,
                result: result,
                openedDetails: openedDetails,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fixtureId,
                required String pick,
                Value<double?> odds = const Value.absent(),
                required DateTime createdAt,
                Value<DateTime?> lockedAt = const Value.absent(),
                Value<DateTime?> gradedAt = const Value.absent(),
                Value<String?> result = const Value.absent(),
                Value<bool> openedDetails = const Value.absent(),
              }) => PredictionsTableCompanion.insert(
                id: id,
                fixtureId: fixtureId,
                pick: pick,
                odds: odds,
                createdAt: createdAt,
                lockedAt: lockedAt,
                gradedAt: gradedAt,
                result: result,
                openedDetails: openedDetails,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$PredictionsTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fixtureId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fixtureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fixtureId,
                                referencedTable:
                                    $$PredictionsTableTableReferences
                                        ._fixtureIdTable(db),
                                referencedColumn:
                                    $$PredictionsTableTableReferences
                                        ._fixtureIdTable(db)
                                        .fixtureId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PredictionsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PredictionsTableTable,
      PredictionsTableData,
      $$PredictionsTableTableFilterComposer,
      $$PredictionsTableTableOrderingComposer,
      $$PredictionsTableTableAnnotationComposer,
      $$PredictionsTableTableCreateCompanionBuilder,
      $$PredictionsTableTableUpdateCompanionBuilder,
      (PredictionsTableData, $$PredictionsTableTableReferences),
      PredictionsTableData,
      PrefetchHooks Function({bool fixtureId})
    >;
typedef $$FavoritesTableTableCreateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> id,
      required String type,
      required int refId,
      required DateTime createdAt,
    });
typedef $$FavoritesTableTableUpdateCompanionBuilder =
    FavoritesTableCompanion Function({
      Value<int> id,
      Value<String> type,
      Value<int> refId,
      Value<DateTime> createdAt,
    });

class $$FavoritesTableTableFilterComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FavoritesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get refId => $composableBuilder(
    column: $table.refId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FavoritesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $FavoritesTableTable> {
  $$FavoritesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get refId =>
      $composableBuilder(column: $table.refId, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$FavoritesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FavoritesTableTable,
          FavoritesTableData,
          $$FavoritesTableTableFilterComposer,
          $$FavoritesTableTableOrderingComposer,
          $$FavoritesTableTableAnnotationComposer,
          $$FavoritesTableTableCreateCompanionBuilder,
          $$FavoritesTableTableUpdateCompanionBuilder,
          (
            FavoritesTableData,
            BaseReferences<
              _$AppDatabase,
              $FavoritesTableTable,
              FavoritesTableData
            >,
          ),
          FavoritesTableData,
          PrefetchHooks Function()
        > {
  $$FavoritesTableTableTableManager(
    _$AppDatabase db,
    $FavoritesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FavoritesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FavoritesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FavoritesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> type = const Value.absent(),
                Value<int> refId = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => FavoritesTableCompanion(
                id: id,
                type: type,
                refId: refId,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String type,
                required int refId,
                required DateTime createdAt,
              }) => FavoritesTableCompanion.insert(
                id: id,
                type: type,
                refId: refId,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FavoritesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FavoritesTableTable,
      FavoritesTableData,
      $$FavoritesTableTableFilterComposer,
      $$FavoritesTableTableOrderingComposer,
      $$FavoritesTableTableAnnotationComposer,
      $$FavoritesTableTableCreateCompanionBuilder,
      $$FavoritesTableTableUpdateCompanionBuilder,
      (
        FavoritesTableData,
        BaseReferences<_$AppDatabase, $FavoritesTableTable, FavoritesTableData>,
      ),
      FavoritesTableData,
      PrefetchHooks Function()
    >;
typedef $$NotesTableTableCreateCompanionBuilder =
    NotesTableCompanion Function({
      Value<int> id,
      required int fixtureId,
      required String noteText,
      required DateTime updatedAt,
    });
typedef $$NotesTableTableUpdateCompanionBuilder =
    NotesTableCompanion Function({
      Value<int> id,
      Value<int> fixtureId,
      Value<String> noteText,
      Value<DateTime> updatedAt,
    });

final class $$NotesTableTableReferences
    extends BaseReferences<_$AppDatabase, $NotesTableTable, NotesTableData> {
  $$NotesTableTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $MatchesTableTable _fixtureIdTable(_$AppDatabase db) =>
      db.matchesTable.createAlias(
        $_aliasNameGenerator(
          db.notesTable.fixtureId,
          db.matchesTable.fixtureId,
        ),
      );

  $$MatchesTableTableProcessedTableManager get fixtureId {
    final $_column = $_itemColumn<int>('fixture_id')!;

    final manager = $$MatchesTableTableTableManager(
      $_db,
      $_db.matchesTable,
    ).filter((f) => f.fixtureId.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_fixtureIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$NotesTableTableFilterComposer
    extends Composer<_$AppDatabase, $NotesTableTable> {
  $$NotesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get noteText => $composableBuilder(
    column: $table.noteText,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MatchesTableTableFilterComposer get fixtureId {
    final $$MatchesTableTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableFilterComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTableTable> {
  $$NotesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get noteText => $composableBuilder(
    column: $table.noteText,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MatchesTableTableOrderingComposer get fixtureId {
    final $$MatchesTableTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableOrderingComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTableTable> {
  $$NotesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get noteText =>
      $composableBuilder(column: $table.noteText, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$MatchesTableTableAnnotationComposer get fixtureId {
    final $$MatchesTableTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.fixtureId,
      referencedTable: $db.matchesTable,
      getReferencedColumn: (t) => t.fixtureId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MatchesTableTableAnnotationComposer(
            $db: $db,
            $table: $db.matchesTable,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$NotesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTableTable,
          NotesTableData,
          $$NotesTableTableFilterComposer,
          $$NotesTableTableOrderingComposer,
          $$NotesTableTableAnnotationComposer,
          $$NotesTableTableCreateCompanionBuilder,
          $$NotesTableTableUpdateCompanionBuilder,
          (NotesTableData, $$NotesTableTableReferences),
          NotesTableData,
          PrefetchHooks Function({bool fixtureId})
        > {
  $$NotesTableTableTableManager(_$AppDatabase db, $NotesTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> fixtureId = const Value.absent(),
                Value<String> noteText = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => NotesTableCompanion(
                id: id,
                fixtureId: fixtureId,
                noteText: noteText,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int fixtureId,
                required String noteText,
                required DateTime updatedAt,
              }) => NotesTableCompanion.insert(
                id: id,
                fixtureId: fixtureId,
                noteText: noteText,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$NotesTableTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({fixtureId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (fixtureId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.fixtureId,
                                referencedTable: $$NotesTableTableReferences
                                    ._fixtureIdTable(db),
                                referencedColumn: $$NotesTableTableReferences
                                    ._fixtureIdTable(db)
                                    .fixtureId,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$NotesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTableTable,
      NotesTableData,
      $$NotesTableTableFilterComposer,
      $$NotesTableTableOrderingComposer,
      $$NotesTableTableAnnotationComposer,
      $$NotesTableTableCreateCompanionBuilder,
      $$NotesTableTableUpdateCompanionBuilder,
      (NotesTableData, $$NotesTableTableReferences),
      NotesTableData,
      PrefetchHooks Function({bool fixtureId})
    >;
typedef $$AchievementsTableTableCreateCompanionBuilder =
    AchievementsTableCompanion Function({
      required String code,
      required String title,
      required String description,
      Value<DateTime?> earnedAt,
      Value<int> rowid,
    });
typedef $$AchievementsTableTableUpdateCompanionBuilder =
    AchievementsTableCompanion Function({
      Value<String> code,
      Value<String> title,
      Value<String> description,
      Value<DateTime?> earnedAt,
      Value<int> rowid,
    });

class $$AchievementsTableTableFilterComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AchievementsTableTableOrderingComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get code => $composableBuilder(
    column: $table.code,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get earnedAt => $composableBuilder(
    column: $table.earnedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AchievementsTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $AchievementsTableTable> {
  $$AchievementsTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get code =>
      $composableBuilder(column: $table.code, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get earnedAt =>
      $composableBuilder(column: $table.earnedAt, builder: (column) => column);
}

class $$AchievementsTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AchievementsTableTable,
          AchievementsTableData,
          $$AchievementsTableTableFilterComposer,
          $$AchievementsTableTableOrderingComposer,
          $$AchievementsTableTableAnnotationComposer,
          $$AchievementsTableTableCreateCompanionBuilder,
          $$AchievementsTableTableUpdateCompanionBuilder,
          (
            AchievementsTableData,
            BaseReferences<
              _$AppDatabase,
              $AchievementsTableTable,
              AchievementsTableData
            >,
          ),
          AchievementsTableData,
          PrefetchHooks Function()
        > {
  $$AchievementsTableTableTableManager(
    _$AppDatabase db,
    $AchievementsTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AchievementsTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AchievementsTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AchievementsTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> code = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<DateTime?> earnedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsTableCompanion(
                code: code,
                title: title,
                description: description,
                earnedAt: earnedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String code,
                required String title,
                required String description,
                Value<DateTime?> earnedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => AchievementsTableCompanion.insert(
                code: code,
                title: title,
                description: description,
                earnedAt: earnedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AchievementsTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AchievementsTableTable,
      AchievementsTableData,
      $$AchievementsTableTableFilterComposer,
      $$AchievementsTableTableOrderingComposer,
      $$AchievementsTableTableAnnotationComposer,
      $$AchievementsTableTableCreateCompanionBuilder,
      $$AchievementsTableTableUpdateCompanionBuilder,
      (
        AchievementsTableData,
        BaseReferences<
          _$AppDatabase,
          $AchievementsTableTable,
          AchievementsTableData
        >,
      ),
      AchievementsTableData,
      PrefetchHooks Function()
    >;
typedef $$ProfileTableTableCreateCompanionBuilder =
    ProfileTableCompanion Function({
      Value<int> id,
      required String username,
      required int avatarId,
      Value<String?> metricsCacheJson,
      Value<String?> resetMarkersJson,
      Value<DateTime?> updatedAt,
    });
typedef $$ProfileTableTableUpdateCompanionBuilder =
    ProfileTableCompanion Function({
      Value<int> id,
      Value<String> username,
      Value<int> avatarId,
      Value<String?> metricsCacheJson,
      Value<String?> resetMarkersJson,
      Value<DateTime?> updatedAt,
    });

class $$ProfileTableTableFilterComposer
    extends Composer<_$AppDatabase, $ProfileTableTable> {
  $$ProfileTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avatarId => $composableBuilder(
    column: $table.avatarId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metricsCacheJson => $composableBuilder(
    column: $table.metricsCacheJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get resetMarkersJson => $composableBuilder(
    column: $table.resetMarkersJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ProfileTableTableOrderingComposer
    extends Composer<_$AppDatabase, $ProfileTableTable> {
  $$ProfileTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get username => $composableBuilder(
    column: $table.username,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avatarId => $composableBuilder(
    column: $table.avatarId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metricsCacheJson => $composableBuilder(
    column: $table.metricsCacheJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get resetMarkersJson => $composableBuilder(
    column: $table.resetMarkersJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ProfileTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $ProfileTableTable> {
  $$ProfileTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get username =>
      $composableBuilder(column: $table.username, builder: (column) => column);

  GeneratedColumn<int> get avatarId =>
      $composableBuilder(column: $table.avatarId, builder: (column) => column);

  GeneratedColumn<String> get metricsCacheJson => $composableBuilder(
    column: $table.metricsCacheJson,
    builder: (column) => column,
  );

  GeneratedColumn<String> get resetMarkersJson => $composableBuilder(
    column: $table.resetMarkersJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$ProfileTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ProfileTableTable,
          ProfileTableData,
          $$ProfileTableTableFilterComposer,
          $$ProfileTableTableOrderingComposer,
          $$ProfileTableTableAnnotationComposer,
          $$ProfileTableTableCreateCompanionBuilder,
          $$ProfileTableTableUpdateCompanionBuilder,
          (
            ProfileTableData,
            BaseReferences<_$AppDatabase, $ProfileTableTable, ProfileTableData>,
          ),
          ProfileTableData,
          PrefetchHooks Function()
        > {
  $$ProfileTableTableTableManager(_$AppDatabase db, $ProfileTableTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProfileTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProfileTableTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProfileTableTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> username = const Value.absent(),
                Value<int> avatarId = const Value.absent(),
                Value<String?> metricsCacheJson = const Value.absent(),
                Value<String?> resetMarkersJson = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProfileTableCompanion(
                id: id,
                username: username,
                avatarId: avatarId,
                metricsCacheJson: metricsCacheJson,
                resetMarkersJson: resetMarkersJson,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String username,
                required int avatarId,
                Value<String?> metricsCacheJson = const Value.absent(),
                Value<String?> resetMarkersJson = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
              }) => ProfileTableCompanion.insert(
                id: id,
                username: username,
                avatarId: avatarId,
                metricsCacheJson: metricsCacheJson,
                resetMarkersJson: resetMarkersJson,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ProfileTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ProfileTableTable,
      ProfileTableData,
      $$ProfileTableTableFilterComposer,
      $$ProfileTableTableOrderingComposer,
      $$ProfileTableTableAnnotationComposer,
      $$ProfileTableTableCreateCompanionBuilder,
      $$ProfileTableTableUpdateCompanionBuilder,
      (
        ProfileTableData,
        BaseReferences<_$AppDatabase, $ProfileTableTable, ProfileTableData>,
      ),
      ProfileTableData,
      PrefetchHooks Function()
    >;
typedef $$JournalEntriesTableTableCreateCompanionBuilder =
    JournalEntriesTableCompanion Function({
      required String dateYmd,
      Value<String> eventsJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$JournalEntriesTableTableUpdateCompanionBuilder =
    JournalEntriesTableCompanion Function({
      Value<String> dateYmd,
      Value<String> eventsJson,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$JournalEntriesTableTableFilterComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dateYmd => $composableBuilder(
    column: $table.dateYmd,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventsJson => $composableBuilder(
    column: $table.eventsJson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$JournalEntriesTableTableOrderingComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dateYmd => $composableBuilder(
    column: $table.dateYmd,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventsJson => $composableBuilder(
    column: $table.eventsJson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$JournalEntriesTableTableAnnotationComposer
    extends Composer<_$AppDatabase, $JournalEntriesTableTable> {
  $$JournalEntriesTableTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dateYmd =>
      $composableBuilder(column: $table.dateYmd, builder: (column) => column);

  GeneratedColumn<String> get eventsJson => $composableBuilder(
    column: $table.eventsJson,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$JournalEntriesTableTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $JournalEntriesTableTable,
          JournalEntriesTableData,
          $$JournalEntriesTableTableFilterComposer,
          $$JournalEntriesTableTableOrderingComposer,
          $$JournalEntriesTableTableAnnotationComposer,
          $$JournalEntriesTableTableCreateCompanionBuilder,
          $$JournalEntriesTableTableUpdateCompanionBuilder,
          (
            JournalEntriesTableData,
            BaseReferences<
              _$AppDatabase,
              $JournalEntriesTableTable,
              JournalEntriesTableData
            >,
          ),
          JournalEntriesTableData,
          PrefetchHooks Function()
        > {
  $$JournalEntriesTableTableTableManager(
    _$AppDatabase db,
    $JournalEntriesTableTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$JournalEntriesTableTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$JournalEntriesTableTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$JournalEntriesTableTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> dateYmd = const Value.absent(),
                Value<String> eventsJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesTableCompanion(
                dateYmd: dateYmd,
                eventsJson: eventsJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dateYmd,
                Value<String> eventsJson = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => JournalEntriesTableCompanion.insert(
                dateYmd: dateYmd,
                eventsJson: eventsJson,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$JournalEntriesTableTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $JournalEntriesTableTable,
      JournalEntriesTableData,
      $$JournalEntriesTableTableFilterComposer,
      $$JournalEntriesTableTableOrderingComposer,
      $$JournalEntriesTableTableAnnotationComposer,
      $$JournalEntriesTableTableCreateCompanionBuilder,
      $$JournalEntriesTableTableUpdateCompanionBuilder,
      (
        JournalEntriesTableData,
        BaseReferences<
          _$AppDatabase,
          $JournalEntriesTableTable,
          JournalEntriesTableData
        >,
      ),
      JournalEntriesTableData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$MatchesTableTableTableManager get matchesTable =>
      $$MatchesTableTableTableManager(_db, _db.matchesTable);
  $$OddsTableTableTableManager get oddsTable =>
      $$OddsTableTableTableManager(_db, _db.oddsTable);
  $$PredictionsTableTableTableManager get predictionsTable =>
      $$PredictionsTableTableTableManager(_db, _db.predictionsTable);
  $$FavoritesTableTableTableManager get favoritesTable =>
      $$FavoritesTableTableTableManager(_db, _db.favoritesTable);
  $$NotesTableTableTableManager get notesTable =>
      $$NotesTableTableTableManager(_db, _db.notesTable);
  $$AchievementsTableTableTableManager get achievementsTable =>
      $$AchievementsTableTableTableManager(_db, _db.achievementsTable);
  $$ProfileTableTableTableManager get profileTable =>
      $$ProfileTableTableTableManager(_db, _db.profileTable);
  $$JournalEntriesTableTableTableManager get journalEntriesTable =>
      $$JournalEntriesTableTableTableManager(_db, _db.journalEntriesTable);
}
