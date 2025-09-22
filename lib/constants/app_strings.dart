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
  static const String matchScheduleEmptyTitle = 'No matches found';
  static const String matchScheduleEmpty =
      'No matches found for the selected filters.';

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

  // Favorites
  static const String favoritesTitle = 'FAVORITES';
  static const String favoritesTabLeagues = 'Leagues';
  static const String favoritesTabTeams = 'Teams';
  static const String favoritesTabMatches = 'Matches';
  static const String favoritesEmptyTitle =
      'No favorites yet. Add teams, leagues or matches from anywhere';
  static const String favoritesGoToMatches = 'Go to Matches';
  static const String favoritesViewMatches = 'View Matches';
  static const String favoritesPredictNow = 'Predict Now';
  static const String favoritesOpenMatch = 'Open Match';
  static const String favoritesMatchesToday = 'Matches today:';
  static const String favoritesCountry = 'Country:';
  static const String favoritesLeague = 'League:';
  static const String favoritesNextMatch = 'Next match:';
  static const String favoritesPlayingNow = 'Playing now:';
  static const String favoritesLastMatch = 'Last match:';

  // Statistics
  static const String statisticsTitle = 'STATISTICS';
  static const String statisticsSummaryMetrics = 'Summary metrics';
  static const String statisticsTotalPreds = 'Total Preds';
  static const String statisticsAccuracy = 'Accuracy';
  static const String statisticsCorrect = 'Correct';
  static const String statisticsMissed = 'Missed';
  static const String statisticsAverageOddsPicked = 'Average Odds Picked';
  static const String statisticsAvgPredictionsWeek = 'Avg Predictions/Week';
  static const String statisticsOutcomesPredicted = 'Outcomes Predicted';
  static const String statisticsPredictionsByWeekday = 'Predictions by Weekday';
  static const String statisticsAccuracyTrend = 'Accuracy Trend';
  static const String statisticsAchievementsBlock = 'Achievements block';
  static const String statisticsViewAllAchievements = 'View All Achievements';
  static const String statisticsResetStats = 'Reset Stats';
  static const String statisticsHomeWin = 'Home Win';
  static const String statisticsDraw = 'Draw';
  static const String statisticsAwayWin = 'Away Win';
  static const String statisticsWins = 'Wins';
  static const String statisticsPerfectDay = 'Perfect Day';
  static const String statisticsPredictions = 'Predictions';

  // Profile
  static const String profileTitle = 'PROFILE';
  static const String profileWins = 'Wins';
  static const String profilePerfectDay = 'Perfect Day';
  static const String profilePredictions = 'Predictions';
  static const String profileTotalPreds = 'Total Preds';
  static const String profileAccuracy = 'Accuracy';
  static const String profileCorrect = 'Correct';
  static const String profileMissed = 'Missed';
  static const String profileAvgOddsPicked = 'Avg Odds Picked';
  static const String profilePredictionsWeek = 'Predictions/Week';
  static const String profileRecentPredictions = 'Recent predictions';
  static const String profileUpcoming = 'Upcoming';
  static const String profileCompleted = 'Completed';
  static const String profileCompletedMissed = 'Completed (Missed)';
  static const String profileViewStatistics = 'View Statistics';
  static const String profileViewMyPredictions = 'View My Predictions';
  static const String profileViewFavorites = 'View Favorites';
  static const String profileOpenJournal = 'Open Journal';
  static const String profileOpenInsights = 'Open Insights';
  static const String profileResetStats = 'Reset Stats';
  static const String profileAvatar = 'Avatar';
  static const String profileName = 'Name';
  static const String profileEnterName = 'Enter your name';
  static const String profileCancel = 'Cancel';
  static const String profileSave = 'Save';
  static const String profileResetConfirmTitle = 'Reset Statistics';
  static const String profileResetConfirmMessage =
      'This will clear statistics but\nkeep your predictions\nhistory?';
  static const String profileResetStatsOnly = 'Clear only stats';
  static const String profileResetAllData = 'Clear all data';
  static const String profileResetCancel = 'Cancel';

  // My Predictions
  static const String myPredictionsEmptyTitle = 'No predictions yet';
  static const String myPredictionsGoToMatches = 'Go to Matches';
  static const String myPredictionsLeague = 'League';
  static const String myPredictionsPrediction = 'Prediction';
  static const String myPredictionsOdds = 'Odds';
  static const String myPredictionsUpcoming = 'Upcoming';
  static const String myPredictionsPending = 'Pending';
  static const String myPredictionsCompleted = 'Completed';
  static const String myPredictionsCompletedCorrect = 'Completed (Correct)';
  static const String myPredictionsCompletedMissed = 'Completed (Missed)';
  static const String myPredictionsOpenMatch = 'Open Match';
  static const String myPredictionsEditDisabled = 'Edit disabled';
  static const String myPredictionsHomeWin = 'Home Win';
  static const String myPredictionsDraw = 'Draw';
  static const String myPredictionsAwayWin = 'Away Win';
}
