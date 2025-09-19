// path: lib/constants/app_strings.dart
// Centralized app strings (no hardcoded UI text elsewhere).
import 'package:flutter/foundation.dart';

@immutable
final class AppStrings {
  const AppStrings._();

  // Common
  static const String appTitle = 'Football Predictor';
  static const String retry = 'Retry';
  static const String loading = 'Loading...';
  static const String comingSoon = 'Coming soon';
  static const String notFoundTitle = 'Page not found';
  static const String backToMatches = 'Back to Matches';
  static const String appBarBackTooltip = 'Back';
  static const String appBarActionTooltip = 'Action';
  static const String oddsUnavailable = 'Odds unavailable';
  static const String cancel = 'Cancel';
  static const String add = 'Add';

  // Splash
  static const String splashEnter = 'Enter';
  static const String splashTagline = 'Football in your hands';
  static const String splashError = 'Unable to initialise the app.';

  // Welcome
  static const String welcomeTitle = 'WELCOME!';
  static const String welcomeSubtitle =
      'Predict football outcomes, track your results, '
      'and build your winning strategy';
  static const String welcomeGetStarted = 'Get Started';

  // Navigation tabs
  static const String matchesTodayTitle = 'Matches';
  static const String statisticsTabTitle = 'Statistics';
  static const String favoritesTabTitle = 'Favorites';
  static const String profileTabTitle = 'Profile';

  // Feature titles
  static const String myPredictionsTitle = 'My Predictions';
  static const String achievementsTitle = 'Achievements';
  static const String insightsTitle = 'Insights';
  static const String journalTitle = 'Prediction Journal';
  static const String matchDetailsTitle = 'MATCH DETAILS';

  // Match Schedule
  static const String matchScheduleTitle = 'MATCH SCHEDULE';
  static const String matchScheduleFilter = 'Filter';
  static const String matchScheduleFilterActive = 'Filter (Active)';
  static const String matchScheduleSegmentYesterday = 'Yesterday';
  static const String matchScheduleSegmentToday = 'Today';
  static const String matchScheduleSegmentTomorrow = 'Tomorrow';
  static const String matchScheduleCountersPredicted = 'Predicted';
  static const String matchScheduleCountersUpcoming = 'Upcoming';
  static const String matchScheduleCountersCompleted = 'Completed';
  static const String matchScheduleFilterSectionLeagues = 'Leagues';
  static const String matchScheduleFilterSectionCountry = 'Country';
  static const String matchScheduleFilterSectionStatus = 'Status';
  static const String matchScheduleFilterShowFavorites = 'Show only favorites';
  static const String matchScheduleFilterReset = 'Reset';
  static const String matchScheduleFilterApply = 'Apply';
  static const String leaguePremierLeague = 'Premier League';
  static const String leagueLaLiga = 'La Liga';
  static const String leagueBundesliga = 'Bundesliga';
  static const String leagueUcl = 'UCL';
  static const String leagueSerieA = 'Serie A';
  static const String leagueLigue1 = 'Ligue 1';
  static const String countryEngland = 'England';
  static const String countrySpain = 'Spain';
  static const String countryGermany = 'Germany';
  static const String countryFrance = 'France';
  static const String countryItaly = 'Italy';
  static const String countryUkraine = 'Ukraine';

  // Match Details
  static const String matchDetailsTabInfo = 'Info';
  static const String matchDetailsTabPrediction = 'Prediction';
  static const String matchDetailsTabNotes = 'My Notes';
  static const String matchDetailsInfoStadium = 'Stadium';
  static const String matchDetailsInfoCity = 'City';
  static const String matchDetailsInfoReferee = 'Referee';
  static const String matchDetailsPredictionPanelTitle = 'YOUR BET';
  static const String matchDetailsPredictionOptionHome = 'Home';
  static const String matchDetailsPredictionOptionDraw = 'Draw';
  static const String matchDetailsPredictionOptionAway = 'Away';
  static const String matchDetailsMakePrediction = 'Make a Prediction';
  static const String matchDetailsEditPrediction = 'Edit Prediction';
  static const String matchDetailsEditDisabled = 'Edit disabled';
  static const String matchDetailsPredictionDialogTitle =
      'MAKE YOUR PREDICTION';
  static const String matchDetailsNotesPlaceholder = 'Add your notes...';
  static const String matchDetailsStatusUpcoming = 'Status: Upcoming';
  static const String matchDetailsStatusCorrect = 'Status: Correct';
  static const String matchDetailsStatusMissed = 'Status: Missed';
  static const String matchDetailsStatusPending = 'Status: Pending';
  static const String matchDetailsStatusLive = 'Status: Live';
  static const String matchDetailsNotesSaving = 'Saving note...';
  static const String matchDetailsAddToFavoritesTitle = 'Add to Favorites';
  static const String matchDetailsPredictionMissing =
      'Select an outcome to continue.';
  static String matchDetailsPredicted(String pick, String odds) =>
      'You predicted: $pick ($odds)';
  static String matchDetailsFavoriteLeague(String league) => 'League: $league';
  static String matchDetailsFavoriteTeam(String team) => 'Team: $team';
  static String matchDetailsFavoriteMatch(String home, String away) =>
      'Match: $home vs $away';

  // Matches Today
  static const String matchesEmpty = 'No matches found for today.';
  static const String matchesLoadHint =
      "Tap to load today's fixtures.\n(Requires API key & codegen)";
  static const String matchesErrorTitle = "Couldn't load matches";
  static const String matchesPullToRefresh = 'Pull to refresh';
}
