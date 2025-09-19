import 'package:FlutterApp/data/models/fixture.dart';
import 'package:FlutterApp/data/models/odds_snapshot.dart';
import 'package:FlutterApp/data/models/prediction.dart';

enum MatchCardContext { schedule, favorites, profile, stats }

enum MatchCardDensity { compact, regular, expanded }

enum MatchCardState { upcoming, live, finished }

enum MatchCardUserPick { none, made, correct, missed }

typedef MatchCardNote = String?;

typedef MatchCardOdds = OddsSnapshot?;

typedef MatchCardPrediction = Prediction?;

class MatchCardConfig {
  const MatchCardConfig({
    required this.match,
    required this.context,
    required this.density,
    required this.state,
    required this.userPick,
    required this.isFavorite,
    required this.isExpanded,
    this.odds,
    this.prediction,
    this.userNote,
  });

  final Fixture match;
  final MatchCardContext context;
  final MatchCardDensity density;
  final MatchCardState state;
  final MatchCardUserPick userPick;
  final bool isFavorite;
  final bool isExpanded;
  final MatchCardOdds odds;
  final MatchCardPrediction prediction;
  final MatchCardNote userNote;

  MatchCardConfig copyWith({
    MatchCardContext? context,
    MatchCardDensity? density,
    MatchCardState? state,
    MatchCardUserPick? userPick,
    bool? isFavorite,
    bool? isExpanded,
    MatchCardOdds? odds,
    MatchCardPrediction? prediction,
    MatchCardNote? userNote,
  }) {
    return MatchCardConfig(
      match: match,
      context: context ?? this.context,
      density: density ?? this.density,
      state: state ?? this.state,
      userPick: userPick ?? this.userPick,
      isFavorite: isFavorite ?? this.isFavorite,
      isExpanded: isExpanded ?? this.isExpanded,
      odds: odds ?? this.odds,
      prediction: prediction ?? this.prediction,
      userNote: userNote ?? this.userNote,
    );
  }
}
