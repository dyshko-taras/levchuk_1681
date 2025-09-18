```yaml
# ===============================
# 0) Project Meta (one-time)
# ===============================
app:
  name: Football Predictor
  package_id: com.footballpredictor.app
  platforms: [android, ios]

  # File paths (constants & routing)
  routes_file: lib/constants/app_routes.dart
  spacing_tokens: lib/constants/app_spacing.dart
  durations_tokens: lib/constants/app_durations.dart
  assets_constants:
    icons: lib/constants/app_icons.dart
    images: lib/constants/app_images.dart
  strings: app_strings            # English-only resources

  # Codegen & validation
  codegen:
    strict: true
    unknown_prop: error
    enum_unknown: error
    forbid_inline_numbers: true   # use tokens for sizes/durations only

  # Conventions
  grammar:
    identifiers: [ provider, item, params ]  # expression roots allowed in bindings
  theme:
    single_theme: true                       # one dark theme per design system
    typography_source: lib/ui/theme/app_fonts.dart
    colors_source: lib/ui/theme/app_colors.dart

  # Localization (fixed)
  locale:
    primary: en
    supported: [en]                          # English only
    tz: Europe/Kyiv                          # business logic timezone
```

```yaml
# ===============================
# 1) Screens Registry (from TS)
# ===============================
screens:
  # Shell & entry
  - id: main_shell_page
    route: /                                   # IndexedStack + bottom nav
    page_class: MainShellPage

  - id: splash
    route: /splash
    page_class: SplashPage                     # 1.5–2s → Welcome (first run) або Match Schedule
                                               # TS 4.1
  - id: welcome
    route: /welcome
    page_class: WelcomePage                    # One-time; then Splash → Schedule
                                               # TS 4.2

  # Bottom navigation tabs (TS 4.3)
  - id: matches                                # “Match Schedule”
    route: /matches
    page_class: MatchSchedulePage              # Tabs header, date switchers, filters, counters, cards
                                               # TS 4.3

  - id: stats
    route: /stats
    page_class: StatisticsPage                 # Summary, charts, badges preview
                                               # TS 4.8

  - id: favorites
    route: /favorites
    page_class: FavoritesPage                  # Tabs: Leagues | Teams | Matches
                                               # TS 4.7

  - id: profile
    route: /profile
    page_class: UserProfilePage                # Avatar/Username/Edit, badges, quick links, reset
                                               # TS 4.6

  # Non-tab details & flows
  - id: match_details
    route: /match/:id
    page_class: MatchDetailsPage               # Info, odds, notes, prediction
                                               # TS 4.4

  - id: my_predictions
    route: /predictions
    page_class: MyPredictionsPage              # List + edit/open; empty state
                                               # TS 4.5

  - id: achievements
    route: /achievements
    page_class: AchievementsPage               # Achievements / Leaderboard
                                               # TS 4.9

  - id: insights
    route: /insights
    page_class: InsightsPage                   # Trends, strengths/weaknesses, advice
                                               # TS 4.10

  - id: prediction_journal
    route: /journal
    page_class: PredictionJournalPage          # Calendar + daily timeline
                                               # TS 4.11
```

```yaml
# ===============================
# 2) Component Catalog (reusable)
# ===============================
component:
  - id: PrimaryCtaButton
    type: molecule
    class: PrimaryCtaButton
    props:
      label: String
      onPressed: VoidCallback
      isLoading: bool=false
      isEnabled: bool=true
    style:
      height: Sizes.buttonLg?            # if defined; otherwise Theme elevatedButton minSize
      radius: AppRadius.pill             # or AppRadius.lg per DS (6px)
      padding: Insets.hLg
      width: matchParent
      colors:
        bg: AppColors.successGreen       # #00DD70
        fg: AppColors.textOnPrimary      # black per DS
      states:
        default: { opacity: 1.0 }
        pressed: { opacity: 0.8, scale: 0.95 }
        disabled: { opacity: 0.5 }
    accessibility:
      minTouchTarget: Sizes.touchMin44   # 44px target per DS
    usage:
      - welcome
  - id: bottom_nav_bar
    type: organism
    class: BottomNavBar
    mechanism: IndexedStack
    props:
      currentIndex: int
      onTap: Function(int)
    style:
      background: AppColors.primaryBlack          # dark surface
      elevation: Sizes.navBarElevation?           # via tokens if defined
      labelStyle:
        active: { color: AppColors.textWhite, role: caption }     # DS text sizes
        inactive: { color: AppColors.textGray, role: caption }
      iconSize: Sizes.navIcon?                     # tokenized if present
      height: Sizes.navBarHeight?                  # min 44px touch target
    tabs:
      - id: matches
        label: "Matches"
        icon_active: AppIcons.navMatchesFilled
        icon_inactive: AppIcons.navMatches
        route: /matches
      - id: statistics
        label: "Statistics"
        icon_active: AppIcons.navStatsFilled
        icon_inactive: AppIcons.navStats
        route: /stats
      - id: favorites
        label: "Favorites"
        icon_active: AppIcons.navFavoritesFilled
        icon_inactive: AppIcons.navFavorites
        route: /favorites
      - id: profile
        label: "Profile"
        icon_active: AppIcons.navProfileFilled
        icon_inactive: AppIcons.navProfile
        route: /profile
    interactions:
      onTap(index):
        - action: provider.setIndex
          args: { index: "{index}" }
    accessibility:
      minTouchTarget: Sizes.touchMin44
    usage:
      - main_shell_page


  # =========================
  # ORGANISM
  # =========================
  - id: MatchCard
    type: organism
    file: lib/ui/widgets/match/match_card.dart
    description: "Composable card for a football match; layout via slots/sections controlled by config and rules."
    props:
      config: MatchCardConfig
      onOpenMatch: VoidCallback
      onMakePrediction: VoidCallback?
      onToggleFavorite: VoidCallback?
      onExpandToggle: VoidCallback?
    sections:
      - LeagueHeader       # 🌍 league + country (optional)
      - TeamsRow           # home/away badges + name pills
      - CenterBlock        # kickoff (upcoming) OR score (live/finished)
      - SubInfo            # odds / 'Finished' / prediction summary
      - StatusChip         # Upcoming/Predicted/Completed(Correct|Missed)
      - Actions            # primary CTA(s): Make Prediction / Open Match / Edit disabled
      - FavoriteStar       # star toggle (top-right)
      - ExpandToggle       # caret to expand (optional)
      - ExpandedArea       # note line + secondary CTA line
    states:
      - default
      - expanded           # reveals ExpandedArea
      - disabled_edit      # prediction editing is locked (by kickoff)
    style:
      padding: Sizes.cardPadding.regular
      radius: AppRadius.cardLg
      background: AppColors.surfaceDark
      overlay: AppGradients.cardGlow?        # optional token
      divider: AppColors.dividerDark?        # thin separator above status/actions
    density:
      compact:
        padding: Sizes.cardPadding.compact
        text_roles: { title: labelLarge, body: bodySmall }
      regular:
        padding: Sizes.cardPadding.regular
        text_roles: { title: titleMedium, body: bodyMedium }
      expanded:
        padding: Sizes.cardPadding.expanded
        text_roles: { title: titleLarge, body: bodyMedium }
    analytics:
      events:
        - name: matchcard_open_match
          params: { fixture_id: int, context: string }
        - name: matchcard_make_prediction
          params: { fixture_id: int, context: string }
        - name: matchcard_toggle_favorite
          params: { fixture_id: int, is_favorite: bool }

  # =========================
  # CONFIG
  # =========================
  - id: MatchCardConfig
    type: value_object
    file: lib/ui/widgets/match/match_card_config.dart
    fields:
      - { name: match,           type: Match,           required: true }
      - { name: userPick,        type: UserPickState,   required: true }      # none|made|correct|missed
      - { name: context,         type: MatchCardContext, required: true }     # schedule|favorites|profile|stats
      - { name: density,         type: Density,         required: true }      # compact|regular|expanded
      - { name: isFavorite,      type: bool,            required: true }
      - { name: isExpanded,      type: bool,            required: true }
      - { name: odds,            type: OddsSnapshot?,   required: false }
      - { name: prediction,      type: Prediction?,     required: false }
      - { name: userNote,        type: String?,         required: false }

  # =========================
  # MOLECULES / ATOMS
  # =========================
  - id: LeagueHeader
    type: molecule
    file: lib/ui/widgets/match/parts/league_header.dart
    props: { leagueName: String, countryName: String? }
    style: { icon: AppIcons.globe, role: labelSmall, color: AppColors.textMuted }

  - id: TeamsRow
    type: molecule
    file: lib/ui/widgets/match/parts/teams_row.dart
    props:
      home: TeamRef
      away: TeamRef
    children:
      - TeamBadge
      - TeamPill
    style:
      pill: { bg: AppColors.pillBg, radius: AppRadius.pill, padding: Insets.hSm }

  - id: CenterBlock
    type: molecule
    file: lib/ui/widgets/match/parts/center_block.dart
    variants:
      - kickoff: { time: DateTime }                         # upcoming
      - score:   { home: int, away: int, date: DateTime? }  # live/finished
    style:
      kickoff: { role_time: titleLarge, role_date: labelSmall }
      score:   { role_score: titleLarge, spacing: Insets.hMd }

  - id: SubInfo
    type: molecule
    file: lib/ui/widgets/match/parts/sub_info.dart
    variants:
      - odds: { home: double, draw: double, away: double }
      - prediction_summary: { pick: String, odds: double? }
      - finished: { text: "Finished" }
    style: { role: labelMedium, color: AppColors.textMuted }

  - id: StatusChip
    type: molecule
    file: lib/ui/widgets/match/parts/status_chip.dart
    variants:
      - upcoming:   { icon: AppIcons.mutedBell,   color: AppColors.neutral }
      - predicted:  { icon: AppIcons.statsBars,   color: AppColors.neutral }
      - completed_correct: { icon: AppIcons.check, color: AppColors.success }
      - completed_missed:  { icon: AppIcons.close, color: AppColors.error }
    style:
      height: Sizes.chipHeight
      radius: AppRadius.chip
      padding: Insets.hMd
      text_role: labelMedium
      fg: AppColors.textOnChip

  - id: Actions
    type: molecule
    file: lib/ui/widgets/match/parts/actions_row.dart
    buttons:
      - CardCTA(primary)       # Make Prediction / Open Match
      - CardCTA(secondary)     # Edit disabled or extra
    layout: { spacing: Insets.hSm }

  - id: CardCTA
    type: atom
    file: lib/ui/widgets/common/card_cta.dart
    props: { label: String, onPressed: VoidCallback?, variant: "primary|secondary", leadingIcon: IconData? }
    style:
      height: Sizes.ctaHeight
      radius: AppRadius.btnLg
      primary:
        bg: AppColors.successGreen
        fg: AppColors.textOnPrimary
      secondary:
        bg: AppColors.surfaceRaised
        fg: AppColors.textWhite
      disabled: { opacity: 0.5 }

  - id: FavoriteStar
    type: atom
    file: lib/ui/widgets/match/parts/favorite_star.dart
    props: { isFavorite: bool, onToggle: VoidCallback? }
    placement: topRight
    style:
      active:   { icon: AppIcons.starFilled, color: AppColors.warningYellow }
      inactive: { icon: AppIcons.star,       color: AppColors.textMuted }

  - id: ExpandToggle
    type: atom
    file: lib/ui/widgets/common/expand_toggle.dart
    props: { expanded: bool, onToggle: VoidCallback? }

  - id: UserNote
    type: molecule
    file: lib/ui/widgets/match/parts/user_note.dart
    props: { text: String? }
    style:
      bg: AppColors.surfaceTint
      radius: AppRadius.note
      padding: Insets.allMd
      text_role: bodySmall
      placeholder: "-"

  - id: OddsRow
    type: molecule
    file: lib/ui/widgets/match/parts/odds_row.dart
    props: { home: double, draw: double, away: double }
    style: { role: labelMedium, spacing: Insets.hMd }

  - id: ScoreBlock
    type: atom
    file: lib/ui/widgets/match/parts/score_block.dart
    props: { home: int, away: int }
    style: { role: titleLarge }

  - id: TeamBadge
    type: atom
    file: lib/ui/widgets/common/team_badge.dart
    props: { logoUrl: String?, size: Sizes.teamBadge }
    behavior: { cache: true, placeholder: AppImages.badgePlaceholder }

  - id: TeamPill
    type: atom
    file: lib/ui/widgets/common/team_pill.dart
    props: { name: String }
    style: { bg: AppColors.pillBg, fg: AppColors.textWhite, radius: AppRadius.pill, padding: Insets.hSm }

  # =========================
  # RULES (render mapping)
  # =========================
  - id: MatchCardRules
    type: config
    file: lib/ui/widgets/match/match_card_rules.yaml
    schema_version: 1
    inputs:
      matchState:  [upcoming, live, finished]      # derived from Match.status
      userPick:    [none, made, correct, missed]
      context:     [schedule, favorites, profile, stats]
      density:     [compact, regular, expanded]
    table:
      # UPCOMING — no pick
      - when: { matchState: upcoming, userPick: none, context: schedule }
        density: regular
        show:
          LeagueHeader: true
          TeamsRow: true
          CenterBlock: { type: kickoff }
          SubInfo: { type: odds, fallback: none }
          StatusChip: { type: upcoming, text: "Upcoming" }
          Actions: [ { type: primary, label: "Make Prediction", action: makePrediction } ]
          FavoriteStar: toggle
          ExpandToggle: false
          ExpandedArea: false
      # UPCOMING — predicted
      - when: { matchState: upcoming, userPick: made, context: schedule }
        density: regular
        show:
          LeagueHeader: true
          TeamsRow: true
          CenterBlock: { type: kickoff }
          SubInfo: { type: prediction_summary }     # "Prediction: Home Win • Odds 2.15"
          StatusChip: { type: predicted, text: "Predicted" }
          Actions: [ { type: primary, label: "Open Match", action: openMatch } ]
          FavoriteStar: toggle
          ExpandToggle: false
          ExpandedArea: false
      # UPCOMING — favorites (expanded variant)
      - when: { matchState: upcoming, userPick: made, context: favorites }
        density: expanded
        show:
          LeagueHeader: true
          TeamsRow: true
          CenterBlock: { type: kickoff }
          SubInfo: { type: prediction_summary }
          StatusChip: { type: predicted, text: "Predicted" }
          Actions:
            - { type: primary,   label: "Open Match", action: openMatch }
            - { type: secondary, label: "Edit disabled", action: null, disabled: true }  # lock near kickoff
          FavoriteStar: toggle
          ExpandToggle: true
          ExpandedArea:
            - UserNote
      # FINISHED — correct
      - when: { matchState: finished, userPick: correct, context: schedule }
        density: regular
        show:
          LeagueHeader: true
          TeamsRow: true
          CenterBlock: { type: score }
          SubInfo: { type: prediction_summary }     # "Home Win • Odds 2.15"
          StatusChip: { type: completed_correct, text: "Completed (Correct)" }
          Actions: [ { type: primary, label: "Open Match", action: openMatch } ]
          FavoriteStar: toggle
          ExpandToggle: false
          ExpandedArea: false
      # FINISHED — missed
      - when: { matchState: finished, userPick: missed, context: schedule }
        density: regular
        show:
          LeagueHeader: true
          TeamsRow: true
          CenterBlock: { type: score }
          SubInfo: { type: prediction_summary }     # "Away Win • Odds 2.85"
          StatusChip: { type: completed_missed, text: "Completed (Missed)" }
          Actions: [ { type: primary, label: "Open Match", action: openMatch } ]
          FavoriteStar: toggle
          ExpandToggle: false
          ExpandedArea: false
      # PROFILE — compact history
      - when: { matchState: finished, context: profile }
        density: compact
        show:
          LeagueHeader: false
          TeamsRow: true
          CenterBlock: { type: score }
          SubInfo: { type: finished }
          StatusChip: { type: completed_${userPick == 'correct' ? 'correct' : 'missed'}, text: "Completed" }
          Actions: [ { type: primary, label: "Open Match", action: openMatch } ]
          FavoriteStar: toggle
          ExpandToggle: false
          ExpandedArea: false
    rules:
      edit_lock:
        token: AppDurations.predictionLock             # duration before kickoff when editing is disabled
        applies_when: [ matchState: upcoming ]
      timezone: Europe/Kyiv                            # display; store UTC in data layer
  - id: app_bar_actions
    type: molecule
    file: lib/ui/widgets/navigation/app_bar_actions.dart
    description: "Reusable top bar with optional left and right icon buttons."
    props:
      title: String
      leftIcon: IconData?
      rightIcon: IconData?
      showLeft: bool=true
      showRight: bool=true
      onLeft: VoidCallback?
      onRight: VoidCallback?
    style:
      height: Sizes.appBarHeight?
      background: AppColors.primaryBlack
      title_role: titleLarge
      icon_size: Sizes.appBarIcon?
      icon_color: AppColors.textWhite
      padding: Insets.hMd
    behavior:
      hideLeftOnRootTabs: true
    usage:
      - matches
      - (any screen needing a simple app bar)
    notes:
      - Use `flutter_svg` for icons via AppIcons.*, no raw asset paths. :contentReference[oaicite:3]{index=3}

  - id: counters_triple
    type: organism
    file: lib/ui/widgets/schedule/counters_triple.dart
    description: "Three side-by-side counters for Predicted / Upcoming / Completed."
    props:
      predicted: int
      upcoming: int
      completed: int
      onTapPredicted: VoidCallback?     # optional quick-filter
      onTapUpcoming: VoidCallback?
      onTapCompleted: VoidCallback?
    layout:
      type: Row
      spacing: Gaps.wMd
      item:
        type: CounterCard
    usage:
      - matches
      - (reusable in profile/stats summaries)
    accessibility:
      semantics: ["Predicted", "Upcoming", "Completed"]
    notes:
      - Values come from local DB aggregation of `predictions` + match statuses. :contentReference[oaicite:4]{index=4}

  - id: CounterCard
    type: molecule
    file: lib/ui/widgets/common/counter_card.dart
    props:
      label: String              # "Predicted" | "Upcoming" | "Completed"
      value: int
      accent: "neutral|success|warning|error"   # controls number color
    style:
      background: AppColors.cardDark
      radius: AppRadius.cardLg
      padding: Insets.allMd
      label_role: caption
      value_role: displayHero
      value_color_by_accent:
        neutral: AppColors.textWhite
        success: AppColors.successGreen
        warning: AppColors.warningYellow
        error: AppColors.errorRed
    examples:
      - { label: "Predicted", value: 3, accent: neutral }
      - { label: "Upcoming", value: 5, accent: neutral }
      - { label: "Completed", value: 2, accent: success }
  id: schedule_filters_sheet
  type: organism
  file: lib/ui/widgets/schedule/filters_sheet.dart
  props:
    value:
      leagues: List<int>
      countries: List<String>
      status: List<String>        # ["NS","1H","FT",...]
      favoritesOnly: bool
    onApply: Function(FilterValue)
    onReset: VoidCallback
  layout:
    sections:
      - title: "Leagues"          # chips with +/check style per DS
      - title: "Country"
      - toggle: { icon: AppIcons.starFilled, label: "Show only favorites" }
      - actions: [ Reset (secondary), Apply (primary) ]
  data:
    api:
      leaguesByCountry: GET /leagues?country={NAME}&season={YYYY}
      fixturesByLeague: GET /fixtures?league={id}&season={YYYY}&date=YYYY-MM-DD&timezone=Europe/Kyiv
  acceptance:
    - Apply closes sheet and updates list with new filters.
    - Reset clears all selections to defaults.
        
- id: segmented_tabs
    type: molecule
    file: lib/ui/widgets/common/segmented_tabs.dart
    description: "Reusable pill-style segmented control with badges. Controlled (stateless)."
    props:
      items: List<TabItem>              # [{ id: 'today', label: 'Today', badge: 5? }, ...]
      selectedId: String
      onChange: Function(String id)
      scrollable: bool=false            # if more than 3–4 items
      equalWidth: bool=true             # spread evenly when not scrollable
      size: "sm|md|lg"="lg"            # controls height/font/padding via tokens
      emphasis: "primary|neutral"="primary"  # color scheme (e.g., yellow vs gray)
      hideBadgesWhenZero: bool=true
    types:
      - name: TabItem
        fields:
          - { name: id,    type: String }
          - { name: label, type: String }
          - { name: badge, type: int?, default: null }
          - { name: icon,  type: IconData?, default: null }
    style:
      container:
        bg: AppColors.surfaceDark
        padding: Insets.allSm
        radius: AppRadius.segmented
      segment:
        radius: AppRadius.segment
        padding: Insets.hMd
        height_by_size:
          sm: Sizes.segTabSm
          md: Sizes.segTabMd
          lg: Sizes.segTabLg
        typography_by_size:
          sm: { role: labelSmall }
          md: { role: labelMedium }
          lg: { role: titleSmall }
      colors_by_emphasis:
        primary:
          bg_unselected: AppColors.warningYellow      # pill background (as on Schedule)
          fg_unselected: AppColors.textBlack
          bg_selected: AppColors.textBlack
          fg_selected: AppColors.textWhite
        neutral:
          bg_unselected: AppColors.chipBg
          fg_unselected: AppColors.textWhite
          bg_selected: AppColors.surfaceRaised
          fg_selected: AppColors.textWhite
      badge:
        role: labelSmall
        fg: AppColors.textWhite
        bg: AppColors.badgeOverlay
      states:
        pressed: { opacity: 0.9 }
        disabled: { opacity: 0.5 }
    accessibility:
      semantics_label: "Tabs"
      announce_selection: true
      minTouchTarget: Sizes.touchMin44
    analytics:
      events:
        - name: segmented_tab_change
          params: { id: string, label: string, context: string? }
    usage:
      - matches (Yesterday/Today/Tomorrow)
      - (any screen requiring segmented tabs with different labels)

  # Normal green button (primary, smaller than hero CTA)
  - id: primary_button
    type: atom
    file: lib/ui/widgets/buttons/primary_button.dart
    props: { label: String, onPressed: VoidCallback? }
    style:
      height: Sizes.buttonMd                 # tokens, ~45px per DS
      radius: AppRadius.btnLg
      bg: AppColors.successGreen
      fg: AppColors.textBlack
      states: { pressed_opacity: 0.8, disabled_opacity: 0.5 }
    notes: "Use for standard CTAs inside screens."
    # DS: primary green button specs. :contentReference[oaicite:3]{index=3}

  # Light green (secondary positive) button
  - id: secondary_green_button_light
    type: atom
    file: lib/ui/widgets/buttons/secondary_green_button_light.dart
    props: { label: String, onPressed: VoidCallback? }
    style:
      height: Sizes.buttonMd
      radius: AppRadius.btnLg
      bg: AppColors.surfaceRaised
      fg: AppColors.successGreen
      border: { color: AppColors.successGreen }
      states: { pressed_opacity: 0.9, disabled_opacity: 0.5 }
    notes: "Use when action is informational/disabled-looking but positive."

  # Prediction dialog (modal sheet)
  - id: prediction_dialog
    type: dialog
    file: lib/ui/widgets/dialogs/prediction_dialog.dart
    props:
      title: String="MAKE YOUR PREDICTION"
      odds: OddsSnapshot
      selected: "home|draw|away"?
      onSelect: Function(String)
      onCancel: VoidCallback
      onConfirm: Function(String pick)        # returns selected pick
    layout:
      header_role: titleLarge
      body:
        component_ref: PredictionPanel
      footer:
        actions:
          - component_ref: secondary_green_button_light
            bindings: { label: "Cancel", onPressed: onCancel }
          - component_ref: primary_button
            bindings: { label: "Make a Prediction", onPressed: { action: onConfirm, args: "{selected}" } }
    behavior:
      modal: true
      dismissible: true
    # Spec refs: confirmation panel with H/D/A odds, Cancel/Confirm. :contentReference[oaicite:4]{index=4}

  # Add to Favorites dialog
  - id: add_to_favorites_dialog
    type: dialog
    file: lib/ui/widgets/dialogs/add_to_favorites_dialog.dart
    props:
      league: String
      homeTeam: String
      awayTeam: String
      defaults:
        league: true
        homeTeam: true
        awayTeam: true
        match: true
      onCancel: VoidCallback
      onAdd: Function({league:bool, homeTeam:bool, awayTeam:bool, match:bool})
    layout:
      title: "Add to Favorites"
      list:
        - { label: "League", value_bind: props.league,   toggle: true, default: true }
        - { label: "Team: {props.homeTeam}", toggle: true, default: true }
        - { label: "Team: {props.awayTeam}", toggle: true, default: true }
        - { label: "Match: {props.homeTeam} vs {props.awayTeam}", toggle: true, default: true }
      actions:
        - component_ref: secondary_green_button_light
          bindings: { label: "Cancel", onPressed: onCancel }
        - component_ref: primary_button
          bindings: { label: "Add", onPressed: { action: onAdd } }
    # Spec refs: modal with checkable levels League/Team/Match. :contentReference[oaicite:5]{index=5}

  # Notes text field
  - id: notes_text_field
    type: molecule
    file: lib/ui/widgets/fields/notes_text_field.dart
    props:
      value: String?
      hintText: String="Add your notes..."
      onChanged: Function(String)?
      onSubmit: VoidCallback?
      maxLines: int=8
    style:
      bg: AppColors.cardDark
      radius: AppRadius.note
      padding: Insets.allMd
      text_role: bodyMedium
      hint_color: AppColors.textGray
    behavior:
      autogrow: true
      debounceSaveMs: AppDurations.debounceShort?
    # Notes: local/offline store per spec. :contentReference[oaicite:6]{index=6}

  # Prediction panel (H/D/A options with odds)
  - id: PredictionPanel
    type: molecule
    file: lib/ui/widgets/match/parts/prediction_panel.dart
    props:
      odds: OddsSnapshot
      selected: "home|draw|away"?
      onSelect: Function(String)
    layout:
      options:
        - id: home
          label: "Home"
          value_bind: odds.home
        - id: draw
          label: "Draw"
          value_bind: odds.draw
        - id: away
          label: "Away"
          value_bind: odds.away
    style:
      item:
        radius: AppRadius.btnLg
        padding: Insets.hMd
        selected_border: AppColors.warningYellow       # visual highlight as on designs
        fg_value: AppColors.successGreen
      group:
        title_role: titleMedium
        bg: AppColors.cardDark
        radius: AppRadius.cardLg
        padding: Insets.allMd
component_catalog:

  # --- Red destructive button ---
  - id: danger_red_button
    type: atom
    file: lib/ui/widgets/buttons/danger_red_button.dart
    props: { label: String, onPressed: VoidCallback? }
    style:
      height: Sizes.buttonMd
      radius: AppRadius.btnLg
      bg: AppColors.errorRed
      fg: AppColors.textWhite
      states: { pressed_opacity: 0.8, disabled_opacity: 0.5 }
    notes: "Use for destructive actions like Reset Stats."  # DS destructive spec. :contentReference[oaicite:9]{index=9}

  # --- Translucent tinted button with border ---
  - id: translucent_tinted_button
    type: atom
    file: lib/ui/widgets/buttons/translucent_tinted_button.dart
    props:
      label: String
      onPressed: VoidCallback?
      color: Color            # opaque brand color (e.g., AppColors.accentOrange)
    style:
      height: Sizes.buttonMd
      radius: AppRadius.btnLg
      bg: "{color.withOpacity(0.12)}"
      border: { color: "{color}", width: 1 }
      fg: "{color}"
      states: { pressed_opacity: 0.9, disabled_opacity: 0.5 }
    examples:
      - { label: "View All Achievements", color: AppColors.accentOrange }
    notes: "Generic semi-transparent CTA with colored border/text as on the Statistics mock."

  # --- Metric card (value + label) ---
  - id: metric_card
    type: molecule
    file: lib/ui/widgets/stats/metric_card.dart
    props: { label: String, value: String }
    style:
      background: AppColors.cardDark
      radius: AppRadius.cardLg
      padding: Insets.allMd
      label_role: bodySmall
      value_role: displayHero
    accessibility:
      semantics: ["metric", "{label}", "{value}"]
    # Card styling per DS. :contentReference[oaicite:10]{index=10}

  # --- Donut (pie) chart ---
  - id: donut_chart
    type: organism
    file: lib/ui/widgets/stats/donut_chart.dart
    props:
      data: { home: int, draw: int, away: int }
      legend: List<{label:String}>
    notes: "Use fl_chart under the hood per packages list."
    # Charts requirement from TS; lib choice allowed by guidelines. :contentReference[oaicite:11]{index=11} :contentReference[oaicite:12]{index=12}

  # --- Bar chart ---
  - id: bar_chart
    type: organism
    file: lib/ui/widgets/stats/bar_chart.dart
    props:
      data: Map<String, int>   # weekday -> count
      xLabels: List<String>

  # --- Line chart (trend) ---
  - id: line_chart
    type: organism
    file: lib/ui/widgets/stats/line_chart.dart
    props:
      data: List<num>          # percentages
      xLabels: List<String>

  # --- Achievement preview chip ---
  - id: achievement_chip
    type: molecule
    file: lib/ui/widgets/achievements/achievement_chip.dart
    props: { value: int, label: String }
    style:
      bg: AppColors.accentOrange.withOpacity(0.12)
      border: { color: AppColors.accentOrange }
      radius: AppRadius.sm
      padding: Insets.allSm
      value_role: titleLarge
      label_role: bodySmall
    # Matches DS badges guidance. :contentReference[oaicite:13]{index=13}

  - id: LeagueCard
    type: molecule
    file: lib/ui/widgets/favorites/league_card.dart
    description: "Favorite league summary with quick entry to today’s fixtures."
    props:
      leagueId: int
      name: String
      country: String
      matchesToday: int
      isFavorite: bool
      onViewMatches: VoidCallback
      onToggleFavorite: VoidCallback
    layout:
      leading: { type: Icon, asset_const: AppIcons.leagueBall }   # DS icon
      title_role: titleMedium
      subtitle:
        - { label: "Country:", value_bind: country }
        - { label: "Matches today:", value_bind: matchesToday.toString() }
      actions:
        - component_ref: primary_button
          bindings: { label: "View Matches", onPressed: onViewMatches }
        - { type: IconButton, icon_const_bind: "isFavorite ? AppIcons.starFilled : AppIcons.star", onPressed: onToggleFavorite }
    style:
      card_bg: AppColors.cardDark
      radius: AppRadius.cardLg
      padding: Insets.allMd

  - id: TeamCard
    type: molecule
    file: lib/ui/widgets/favorites/team_card.dart
    description: "Favorite team summary with next/now/last match context and quick CTA."
    props:
      teamId: int
      name: String
      league: String
      subtitle: String                 # e.g., 'Next match: vs Barcelona — Aug 3, 20:00'
      logoAssetConst: String?          # optional, from cached team logo constants
      isFavorite: bool
      action:
        label: String                  # 'Predict Now' | 'Open Match'
        onPressed: VoidCallback
      onToggleFavorite: VoidCallback
    layout:
      leading:
        when: logoAssetConst != null
        child: { type: Image, asset_const_bind: logoAssetConst }
        else:  { type: Icon, asset_const: AppIcons.shield }
      title_role: titleMedium
      subtitle_role: bodySmall
      meta_rows:
        - { label: "League:", value_bind: league }
        - { text_bind: subtitle }
      actions:
        - component_ref: primary_button
          bindings: { label: action.label, onPressed: action.onPressed }
        - { type: IconButton, icon_const_bind: "isFavorite ? AppIcons.starFilled : AppIcons.star", onPressed: onToggleFavorite }
    style:
      card_bg: AppColors.cardDark
      radius: AppRadius.cardLg
      padding: Insets.allMd

  - id: reset_stats_dialog
    type: dialog
    file: lib/ui/widgets/dialogs/reset_stats_dialog.dart
    description: "Asks whether to clear only computed statistics or the entire local data."
    props:
      onClearOnlyStats: VoidCallback
      onClearAllData:   VoidCallback
      onClose:          VoidCallback
    layout:
      title: "This will clear statistics but keep your predictions history?"
      actions:
        - component_ref: translucent_tinted_button
          bindings: { label: "Clear only stats", color: AppColors.errorRed, onPressed: onClearOnlyStats }
        - component_ref: danger_red_button
          bindings: { label: "Clear all data", onPressed: onClearAllData }
      closeIcon: AppIcons.close
    notes:
      - Текст і дві опції ідентичні вимогам ТЗ. :contentReference[oaicite:11]{index=11}

  - id: edit_avatar_dialog
    type: dialog
    file: lib/ui/widgets/dialogs/edit_avatar_dialog.dart
    description: "Pick one of 6 avatars and update display name."
    props:
      selectedAvatarId: int
      name: String
      onSave: Function(int avatarId, String name)
      onCancel: VoidCallback
    layout:
      title: "Avatar"
      body:
        - type: Grid
          columns: 3
          spacing: Gaps.wSm
          children:
            - type: SelectableAvatar
              repeat: AppImages.profileAvatars6   # helper list from assets constants
              bindings:
                asset_const: item
                isSelected: item.index == params.selectedAvatarId
                onTap: () => provider.selectAvatar(item.index)
        - component_ref: notes_text_field
          bindings:
            label: "Name"
            hint: "Enter your name"
            controller_bind: provider.nameController
      actions:
        - component_ref: secondary_green_button_light
          bindings: { label: "Cancel", onPressed: onCancel }
        - component_ref: primary_button
          bindings: { label: "Save", onPressed: () => onSave(provider.selectedAvatarId, provider.nameController.text) }
    notes:
      - Діалог «Avatar + Name + Save» прямо вказаний у ТЗ. :contentReference[oaicite:12]{index=12}

```


```yaml
# ===============================
# Screen PRD — SplashPage
# ===============================
screen:
  id: splash
  route: /splash
  page_class: SplashPage
  purpose: "Show brand moment and bootstrap app; route to Welcome on first run, otherwise to Match Schedule (English-only UI)."

  # ---------- State & Data ----------
  state:
    provider_class: AppBootstrapProvider   # lightweight, domain-scoped (bootstrap)
    init:
      calls:
        - method: ensureInitialized        # theme/fonts/tokens pre-warm if needed
          args: {}
        - method: readFirstRunFlag         # from prefs_store
          args: {}

  data:
    sources:
      - type: local
        name: PrefsStore                   # reads: first_run:boolean
      - type: local
        name: MemoryCache                  # optional warm-up (no API here)
    sample:
      prefs: { first_run: true }

  # ---------- Layout ----------
  layout:
    type: Fullscreen
    body:
      type: Center
      padding: Insets.allLg
      children:
        - key: logo
          type: Image
          bindings: { asset_const: AppImages.logo }     # no raw paths
        - key: tagline
          type: Text
          props: { text: "Football in your hands" }     # EN only (from TS)
          style: { text_role: titleMedium }
        - key: stadium_glow
          type: AnimatedGlow
          props: { duration: AppDurations.splashMin }   # 1.5–2s via token

  # ---------- Interactions ----------
  interactions:
    afterDelay:
      duration: AppDurations.splashMin
      action: navigate
      when:
        - cond: prefs.first_run == true
          to: /welcome
        - cond: else
          to: /matches

  # ---------- Conditional UI ----------
  conditions:
    loading: { widget: None }  # splash itself is the loading state

  # ---------- Navigation ----------
  navigation:
    exits:
      - to: /welcome
        when: "first_run == true"
      - to: /matches
        when: "first_run == false"

  # ---------- Assets ----------
  assets:
    images: [ AppImages.logo ]
    icons: []

  # ---------- Analytics ----------
  analytics:
    events:
      - name: splash_shown
        params: { }
      - name: splash_routed
        params: { dest: "{first_run ? 'welcome' : 'matches'}" }

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Given the app launches, When Splash shows, Then it displays logo and the tagline "Football in your hands".
    - Given first_run == true, When AppDurations.splashMin elapses, Then navigate to /welcome.
    - Given first_run == false, When AppDurations.splashMin elapses, Then navigate to /matches.
    - No API calls are performed on Splash.
    - All timings/spacings use tokens (no inline numbers); strings come from app_strings (EN).
    - Timezone-sensitive logic remains Europe/Kyiv, but Splash performs no time math.
```

```yaml
# ===============================
# Screen PRD — WelcomePage
# ===============================
screen:
  id: welcome
  route: /welcome
  page_class: WelcomePage
  purpose: "Introduce the app value and move first-time users to the main flow (English-only UI)."

  # ---------- State & Data ----------
  state:
    provider_class: WelcomeProvider
    init:
      calls:
        - method: readFirstRunFlag
          args: {}
  data:
    sources:
      - type: local
        name: PrefsStore               # first_run:boolean
      - type: local
        name: AppImages                # hero background (welcomeHero)

  # ---------- Layout ----------
  layout:
    type: Fullscreen
    body:
      type: Stack
      children:
        - key: bg
          type: Image
          bindings: { asset_const: AppImages.welcomeHero }
          fit: cover
        - key: gradient
          type: DecoratedBox
          props: { decoration: AppDecorations.heroDimOverlay }   # shared dim overlay if defined
        - key: content
          type: Column
          padding: Insets.allXl
          mainAxisAlignment: end
          children:
            - key: title
              type: Text
              props: { text: "WELCOME!" }
              style: { text_role: displayHero }                  # bound to Inter Black(900) per theme
            - key: subtitle
              type: Text
              props:
                text: "Predict football outcomes, track your results, and build your winning strategy"
              style: { text_role: bodyLarge, textAlign: center }
              padding: Insets.vMd
            - key: cta
              type: PrimaryCtaButton
              bindings:
                label: "Get Started"
                onPressed: provider.onGetStarted

  # ---------- Interactions ----------
  interactions:
    onPressed(GetStarted):
      action: sequence
      steps:
        - action: local.write
          store: PrefsStore
          data: { first_run: false }
        - action: navigate
          to: /matches

  # ---------- Conditions ----------
  conditions:
    loading: { widget: None }
    error: { widget: None }

  # ---------- Assets ----------
  assets:
    images: [ AppImages.welcomeHero ]
    icons: []

  # ---------- Analytics ----------
  analytics:
    events:
      - name: welcome_shown
        params: {}
      - name: click_get_started
        params: {}

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Title reads "WELCOME!" per design.
    - Subtitle exactly matches: "Predict football outcomes, track your results, and build your winning strategy".
    - Tapping "Get Started" sets first_run=false and navigates to /matches.
    - No API requests; only local storage touched.
    - All paddings/sizes/radii/durations use tokens; assets loaded via AppImages.


```



```yaml
# ===============================
# Screen PRD — MainShellPage
# ===============================
screen:
  id: main_shell_page
  route: /
  page_class: MainShellPage
  purpose: "Provide the root shell with bottom navigation across Matches, Statistics, Favorites, and Profile."

  # ---------- State & Data ----------
  state:
    provider_class: BottomNavProvider
    init:
      calls:
        - method: initTabs
          args: { initialIndex: 0 }     # default to Matches per TS

  data:
    sources:
      - type: local
        name: BottomNavState            # currentIndex:int, history:stack

  # ---------- Layout ----------
  layout:
    type: Scaffold
    body:
      type: IndexedStack
      index_bind: provider.currentIndex
      children:
        - component_ref: matches_tab_root      # MatchSchedulePage root
        - component_ref: statistics_tab_root   # StatisticsPage root
        - component_ref: favorites_tab_root    # FavoritesPage root
        - component_ref: profile_tab_root      # UserProfilePage root
    bottomNavigationBar:
      component_ref: bottom_nav_bar
      bindings:
        currentIndex: provider.currentIndex
        onTap: provider.setIndex

  # ---------- Interactions ----------
  interactions:
    onSystemBack:
      action: provider.onBackFromTab         # optional: pop to tab root, then exit
    onDeepLink:
      routes:
        - pattern: app://matches
          action: provider.openTab
          args: { index: 0 }
        - pattern: app://stats
          action: provider.openTab
          args: { index: 1 }
        - pattern: app://favorites
          action: provider.openTab
          args: { index: 2 }
        - pattern: app://profile
          action: provider.openTab
          args: { index: 3 }

  # ---------- Conditions ----------
  conditions:
    loading: { widget: None }
    error: { widget: None }

  # ---------- Navigation ----------
  navigation:
    entry_points:
      - from: /welcome
      - from: /splash (non-first run)
    exits: []   # all detail pages push above this shell

  # ---------- Assets ----------
  assets:
    icons: [ AppIcons.navMatches, AppIcons.navStats, AppIcons.navFavorites, AppIcons.navProfile ]
    images: []

  # ---------- Analytics ----------
  analytics:
    events:
      - name: shell_opened
        params: {}
      - name: tab_switch
        params: { index: "{provider.currentIndex}", name: "{['matches','statistics','favorites','profile'][provider.currentIndex]}" }

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Bottom nav shows 4 tabs in order: Matches, Statistics, Favorites, Profile (labels in English).
    - Tapping a tab replaces only the active pane via IndexedStack (state preserved between tabs).
    - Active tab icon/label appear highlighted; inactive appear muted per design system.
    - Tab routes (deep links) open the shell with the correct index; tab pages themselves are not registered as top-level routes.

```

```yaml
# ===============================
# Screen PRD — MatchSchedulePage
# ===============================
screen:
  id: matches
  route: /matches
  page_class: MatchSchedulePage
  purpose: "Daily list of fixtures with quick status, prediction context, and filtering."

  # ---------- State & Data ----------
  state:
    provider_class: MatchesProvider           # feature-scoped (domain “matches”)
    init:
      calls:
        - method: loadForDate                 # loads fixtures + local user context
          args: { date: provider.selectedDate }  # Yesterday|Today|Tomorrow
        - method: loadCounters                # Predicted/Upcoming/Completed (local DB)
          args: {}

  data:
    sources:
      - type: repository
        name: MatchesRepository               # /fixtures by date/status/league/country
      - type: repository
        name: OddsRepository                  # /odds?fixture=... (lazy per card open)
      - type: local
        name: Database.matches                # fixtures cache by date (UTC) + status
      - type: local
        name: Database.predictions            # to compute counters and card “userPick”
      - type: local
        name: Database.favorites              # star state
      - type: local
        name: Database.notes                  # note preview by fixture_id
    sample:
      filters: { leagues: [140], countries: ["Spain"], status: ["NS","FT"], favoritesOnly: false }
      counters: { predicted: 3, upcoming: 5, completed: 2 }

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "MATCH SCHEDULE"
        leftIcon: AppIcons.chevronLeft
        rightIcon: AppIcons.filter
        onLeft: provider.onBack
        onRight: provider.openFilters
        showLeft: false                       # root tab → немає “Back”
        showRight: true
    body:
      type: CustomScrollView
      slivers:
    - key: day_tabs
      type: PinnedHeader
      child:
        component_ref: segmented_tabs
        bindings:
          items:
            - { id: "yesterday", label: "Yesterday" }
            - { id: "today",     label: "Today" }
            - { id: "tomorrow",  label: "Tomorrow" }
          selectedId: provider.selectedDayId        # "yesterday" | "today" | "tomorrow"
          onChange: provider.onSelectDayId
          scrollable: false
          equalWidth: true
          size: lg
          emphasis: primary
        - key: counters
          type: SliverToBoxAdapter
          child:
            component_ref: counters_triple
            bindings:
              predicted: provider.counters.predicted
              upcoming: provider.counters.upcoming
              completed: provider.counters.completed
        - key: filter_button
          type: SliverToBoxAdapter
          child:
            component_ref: primary_button
            bindings:
              label: "Filter"
              icon: AppIcons.filter
              onPressed: provider.openFilters
        - key: list
          type: SliverList
          item_builder:
            type: MatchCard
            bindings:
              config: provider.cardConfigFor(item)    # uses Match + Prediction + context
              onOpenMatch: () => provider.openMatch(item.fixtureId)
              onMakePrediction: () => provider.startPrediction(item.fixtureId)
              onToggleFavorite: () => provider.toggleFavorite(item.fixtureId)

  # ---------- Interactions ----------
  interactions:
    pullToRefresh: { action: provider.reload }
    loadMore: { trigger: scrollEnd, action: provider.loadNextPage }
    daySelector:
      yesterday: { action: provider.setRelativeDate, args: { offsetDays: -1 } }
      today:     { action: provider.setRelativeDate, args: { offsetDays: 0 } }
      tomorrow:  { action: provider.setRelativeDate, args: { offsetDays: 1 } }
    filterModal:
      open: provider.openFilters
      apply: provider.applyFilters             # leagues/countries/status/favorites
      reset: provider.resetFilters
    starToggle: provider.toggleFavorite
    cardOpen: provider.openMatch

  # ---------- Conditional UI ----------
  conditions:
    loading: { widget: Loader }
    empty:
      when: provider.items.isEmpty
      widget: { type: EmptyView, props: { title: "No matches for this date" } }
    error:
      widget: { type: ErrorView, bindings: { message: provider.errorMessage } }

  # ---------- Navigation ----------
  navigation:
    entry_points:
      - from: / (tab)
      - from: /welcome
    exits:
      - to: /match/:id
        when: "tap(MatchCard.Actions.primary == Open Match || tap(MatchCard anywhere))"
        params: { id: "{item.fixtureId}" }

  # ---------- Assets ----------
  assets:
    icons: [ AppIcons.chevronLeft, AppIcons.filter ]
    images: []

  # ---------- Analytics ----------
  analytics:
    events:
      - name: schedule_opened
        params: { date: "{provider.selectedDate}" }
      - name: schedule_filter_open
        trigger: tap(Filter)
        params: { current_filters: "{provider.filters.debug}" }
      - name: schedule_filter_apply
        params: { leagues: "{filters.leagues.length}", countries: "{filters.countries.length}", status: "{filters.status}", favOnly: "{filters.favoritesOnly}" }
      - name: schedule_card_open
        params: { fixture_id: "{item.fixtureId}" }
      - name: schedule_star_toggle
        params: { fixture_id: "{item.fixtureId}", is_favorite: "{provider.isFavorite(item.fixtureId)}" }

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Title shows "MATCH SCHEDULE"; right action opens Filters; no Back on root tab.
    - Day selector switches dataset between Yesterday/Today/Tomorrow.
    - Counters display numbers computed from local DB (Predicted/Upcoming/Completed).
    - List renders MatchCard variants per rules (Upcoming/Predicted/Completed).
    - Pull-to-refresh reloads current date; infinite scroll loads next page if available.
    - Filters modal: selects by League/Country/Status/Favorites; Apply updates list; Reset clears.
    - Star toggling persists to `favorites`; note previews are loaded when present.
    - All spacing/colors/typography use tokens (no magic numbers); all icons via `AppIcons.*`.

```

```yaml
# ===============================
# Screen PRD — MatchDetailsPage
# ===============================
screen:
  id: match_details
  route: /match/:id
  page_class: MatchDetailsPage
  purpose: "Show full fixture info, manage prediction, and take personal notes."

  # ---------- State & Data ----------
  state:
    provider_class: MatchDetailsProvider
    init:
      calls:
        - method: load
          args: { fixtureId: params.id }            # fixture + odds + local user state
  data:
    sources:
      - type: repository
        name: MatchesRepository                      # /fixtures?id=...
      - type: repository
        name: OddsRepository                         # /odds?fixture=...
      - type: local
        name: Database.predictions
      - type: local
        name: Database.notes
      - type: local
        name: Database.favorites
    sample:
      tabs: [info, prediction, notes]
      match: { fixtureId: 123, league: "Premier League (England)" }
  # Spec refs: tabs Info|Prediction|My Notes; details/odds endpoints; edit-rule until kickoff. :contentReference[oaicite:0]{index=0}

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "MATCH DETAILS"
        leftIcon: AppIcons.chevronLeft
        rightIcon: provider.isFavorite ? AppIcons.starFilled : AppIcons.star
        showLeft: true
        showRight: true
        onLeft: provider.onBack
        onRight: provider.toggleFavorite
    body:
      type: CustomScrollView
      slivers:
        - key: header_card
          type: SliverToBoxAdapter
          child:
            type: MatchCard
            bindings:
              config: provider.headerCardConfig     # uses Match + odds + userPick
              onOpenMatch: () => {}                 # noop (already here)
        - key: tabs
          type: SliverToBoxAdapter
          child:
            component_ref: segmented_tabs
            bindings:
              items:
                - { id: "info",       label: "Info" }
                - { id: "prediction", label: "Prediction" }
                - { id: "notes",      label: "My Notes" }
              selectedId: provider.tabId
              onChange: provider.onTabChange
              emphasis: primary
        - key: tab_content
          type: SliverToBoxAdapter
          child:
            type: TabSwitcher
            index_bind: provider.tabIndex
            children:

              # --- Info tab ---
              - key: info_tab
                type: Column
                padding: Insets.allMd
                children:
                  - { type: InfoRow, bindings: { label: "Stadium",  value: provider.match.venue } }
                  - { type: InfoRow, bindings: { label: "City",     value: provider.match.city } }
                  - { type: InfoRow, bindings: { label: "Referee",  value: provider.match.referee } }

              # --- Prediction tab ---
              - key: prediction_tab
                type: Column
                padding: Insets.allMd
                children:
                  - type: PredictionPanel
                    bindings:
                      odds: provider.odds
                      selected: provider.userPickSelection
                      onSelect: provider.onSelectPick
                  - key: cta_box
                    type: Column
                    padding: Insets.vMd
                    children:
                      - when: provider.canEditPrediction
                        child:
                          component_ref: primary_button   # NORMAL green button
                          bindings:
                            label: provider.hasPick ? "Edit Prediction" : "Make a Prediction"
                            onPressed: provider.onCtaPrediction
                      - when: !provider.canEditPrediction
                        child:
                          component_ref: secondary_green_button_light # LIGHT green button
                          bindings:
                            label: "Edit disabled"
                            onPressed: null
                  - key: status_text
                    type: Text
                    bindings:
                      text: provider.predictionStatusText  # “Status: Upcoming/✅ Correct/❌ Missed”
                    style: { text_role: titleSmall }
              # Spec refs: odds H/D/A, confirm/edit rule until kickoff, result status. :contentReference[oaicite:1]{index=1} :contentReference[oaicite:2]{index=2}

              # --- My Notes tab ---
              - key: notes_tab
                type: Padding
                padding: Insets.allMd
                child:
                  component_ref: notes_text_field
                  bindings:
                    value: provider.noteDraft
                    hintText: "Add your notes..."
                    onChanged: provider.onNoteChanged
                    onSubmit: provider.onNoteSave
  # ---------- Interactions ----------
  interactions:
    openPredictionDialog: provider.openPredictionDialog
    openFavoritesDialog: provider.openAddToFavorites
    saveNote: provider.onNoteSave

  # ---------- Conditional UI ----------
  conditions:
    loading: { widget: Loader }
    error: { widget: ErrorView, bindings: { message: provider.errorMessage } }

  # ---------- Navigation ----------
  navigation:
    entry_points:
      - from: /matches
        via: tap(MatchCard)
    exits: []

  # ---------- Analytics ----------
  analytics:
    events:
      - name: match_details_opened
        params: { fixture_id: "{params.id}" }
      - name: prediction_submit
        params: { fixture_id: "{params.id}", pick: "{provider.userPickSelection}", odds: "{provider.selectedOdds}" }
      - name: note_saved
        params: { fixture_id: "{params.id}", length: "{provider.noteDraft.length}" }
      - name: favorite_toggled
        params: { fixture_id: "{params.id}", is_favorite: "{provider.isFavorite}" }

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Tabs switch between Info/Prediction/My Notes per spec.
    - Prediction tab shows odds H/D/A; CTA text changes (Make vs Edit); editing is locked at/after kickoff.
    - Status text reflects Correct/Missed after FT.
    - Favorite star toggles and persists; Add to Favorites modal supports League/Team/Match levels.
    - Notes tab saves to local DB and restores on reopen; offline friendly.

```

```yaml
# ===============================
# Screen PRD — StatisticsPage
# ===============================
screen:
  id: statistics
  route: /statistics
  page_class: StatisticsPage
  purpose: "Personal performance dashboard based on local predictions history."

  # ---------- State & Data ----------
  state:
    provider_class: StatisticsProvider
    init:
      calls:
        - method: load
          args: {}         # reads from local DB, validates FT in background if needed
  data:
    sources:
      - type: local
        name: Database.predictions             # source of truth for stats/achievements
      - type: repository
        name: MatchesRepository (optional)     # batch verify FT via /fixtures?ids=...
    sample:
      summary: { total: 124, accuracyPct: 63, correct: 78, missed: 46, avgOdds: 2.35, avgPerWeek: 15.5 }
      outcomesPie: { home: 65, draw: 15, away: 20 }
      weekdayBars: { Mon: 8, Tue: 10, Wed: 9, Thu: 12, Fri: 20, Sat: 13, Sun: 18 }
      accuracyTrend: [55, 58, 60, 63]
    notes:
      - All metrics are computed locally; optional periodic validation of FT results per TS. :contentReference[oaicite:2]{index=2}

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "STATISTICS"
        showLeft: false
        showRight: false
    body:
      type: SingleChildScrollView
      padding: Insets.allMd
      children:

        - key: h1
          type: Text
          props: { text: "Summary metrics" }
          style: { text_role: titleLarge }

        - key: metrics_grid
          type: Grid
          columns: 3
          spacing: Gaps.wMd
          children:
            - component_ref: metric_card ; bindings: { label: "Total Preds", value: provider.summary.total.toString() }
            - component_ref: metric_card ; bindings: { label: "Accuracy", value: provider.summary.accuracyPct.toString()+"%" }
            - component_ref: metric_card ; bindings: { label: "Correct", value: provider.summary.correct.toString() }
            - component_ref: metric_card ; bindings: { label: "Missed", value: provider.summary.missed.toString() }
            - component_ref: metric_card ; bindings: { label: "Average Odds Picked", value: provider.summary.avgOdds.toStringAsFixed(2) }
            - component_ref: metric_card ; bindings: { label: "Avg Predictions/Week", value: provider.summary.avgPerWeek.toStringAsFixed(1) }

        - key: h2
          type: Text
          props: { text: "Outcomes Predicted" }
          style: { text_role: titleLarge }

        - key: pie
          component_ref: donut_chart
          bindings:
            data: provider.outcomesPie            # {home,draw,away}
            legend: [{label:"Home Win"},{label:"Draw"},{label:"Away Win"}]

        - key: h3
          type: Column
          children:
            - type: Text
              props: { text: "Predictions by Weekday" }
              style: { text_role: titleLarge }
            - type: Text
              props: { text: provider.weekdayInsight } # e.g., “You predict more often on Fri & Sun”
              style: { text_role: bodySmall, color: AppColors.warningYellow }

        - key: bars
          component_ref: bar_chart
          bindings:
            data: provider.weekdayBars
            xLabels: ["Mon","Tue","Wed","Thu","Fri","Sat","Sun"]

        - key: h4
          type: Text
          props: { text: "Accuracy Trend (last 4 weeks)" }
          style: { text_role: titleLarge }

        - key: trend
          component_ref: line_chart
          bindings:
            data: provider.accuracyTrend      # [w1..w4] in percentages
            xLabels: ["Week 1","Week 2","Week 3","Week 4"]

        - key: h5
          type: Text
          props: { text: "Achievements block" }
          style: { text_role: titleLarge }

        - key: achievements_row
          type: Row
          spacing: Gaps.wMd
          children:
            - component_ref: achievement_chip ; bindings: { value: provider.achievements.wins10, label: "Wins" }
            - component_ref: achievement_chip ; bindings: { value: provider.achievements.perfectDay, label: "Perfect Day" }
            - component_ref: achievement_chip ; bindings: { value: provider.summary.total, label: "Predictions" }

        - key: view_all
          component_ref: translucent_tinted_button
          bindings:
            label: "View All Achievements"
            color: AppColors.accentOrange

        - key: spacer ; type: SizedBox ; height: Gaps.hMd

        - key: reset
          component_ref: danger_red_button
          bindings:
            label: "Reset Stats"
            onPressed: provider.onResetStats

  # ---------- Interactions ----------
  interactions:
    onOpenAchievements: { action: navigate, to: /achievements }
    onResetStats: provider.onResetStatsConfirm

  # ---------- Conditional UI ----------
  conditions:
    loading: { widget: Loader }
    error: { widget: ErrorView, bindings: { message: provider.errorMessage } }

  # ---------- Analytics ----------
  analytics:
    events:
      - name: stats_opened
      - name: achievements_open
        trigger: tap(view_all)
      - name: stats_reset
        trigger: tap(reset)

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Shows 6 summary cards (Total, Accuracy, Correct, Missed, Avg Odds, Avg/Week). :contentReference[oaicite:3]{index=3}
    - Displays 3 charts: Pie H/D/A, Bar by weekday, Line accuracy trend (4–8 weeks allowed). :contentReference[oaicite:4]{index=4}
    - Achievements preview with “View All” route. :contentReference[oaicite:5]{index=5}
    - Reset Stats performs local clear and recompute; optional FT re-validation runs in background. :contentReference[oaicite:6]{index=6}
```

```yaml
# ===============================
# Screen PRD — FavoritesPage
# ===============================
screen:
  id: favorites
  route: /favorites
  page_class: FavoritesPage
  purpose: "Browse and open your favorite leagues, teams, and matches."

  # ---------- State & Data ----------
  state:
    provider_class: FavoritesProvider
    init:
      calls:
        - method: load
          args: {}     # read favorites from local DB, then hydrate lists with API
  data:
    sources:
      - type: local
        name: Database.favorites             # {id, type: league|team|match, ref_id}  :contentReference[oaicite:2]{index=2}
      - type: repository
        name: LeaguesRepository              # /leagues, /countries (logos/meta)
      - type: repository
        name: TeamsRepository
      - type: repository
        name: MatchesRepository              # /fixtures?... for today/next/open  :contentReference[oaicite:3]{index=3}
    sample:
      tabs: [leagues, teams, matches]
      leagues:
        - { id: 140, name: "LA LIGA", country: "Spain", todayCount: 4 }
      teams:
        - { id: 541, name: "REAL MADRID", league: "La Liga", next: "vs Barcelona — Aug 3, 20:00" }
      matches:
        - { fixtureId: 123, league: "Premier League (England)", status: "Predicted" }

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "FAVORITES"
        showLeft: false
        showRight: false
    body:
      type: CustomScrollView
      slivers:
        - key: tabs
          type: SliverToBoxAdapter
          child:
            component_ref: segmented_tabs
            bindings:
              items:
                - { id: "leagues", label: "Leagues" }
                - { id: "teams",   label: "Teams" }
                - { id: "matches", label: "Matches" }
              selectedId: provider.tabId
              onChange: provider.onTabChange
              emphasis: primary
        - key: empty_state
          type: Conditional
          when: provider.isCurrentTabEmpty
          child:
            type: Column
            padding: Insets.allLg
            children:
              - { type: Image, props: { asset_const: AppImages.starLarge } }
              - { type: Text, props: { text: "No favorites yet. Add teams, leagues or matches from anywhere" }, style: { text_role: bodyLarge, align: center } }
              - component_ref: primary_button
                bindings:
                  label: "Go to Matches"
                  onPressed: provider.goToMatches
        - key: list
          type: SliverList
          item_builder:
            switch_on: provider.tabId
            cases:

              # -------- Leagues tab --------
              leagues:
                type: LeagueCard
                bindings:
                  leagueId: item.id
                  name: item.name
                  country: item.country
                  matchesToday: item.todayCount
                  isFavorite: true
                  onViewMatches: () => provider.openLeagueMatches(item.id)
                  onToggleFavorite: () => provider.toggleFavorite('league', item.id)

              # -------- Teams tab --------
              teams:
                type: TeamCard
                bindings:
                  teamId: item.id
                  name: item.name
                  league: item.league
                  subtitle: item.subtitle        # "Next match …" | "Playing now …" | "Last match …"
                  isFavorite: true
                  action:
                    label: item.hasUpcoming ? "Predict Now" : "Open Match"
                    onPressed: () => provider.openTeamPrimaryAction(item)
                  onToggleFavorite: () => provider.toggleFavorite('team', item.id)

              # -------- Matches tab --------
              matches:
                type: MatchCard
                bindings:
                  config: provider.cardConfigFor(item.fixtureId)
                  onOpenMatch: () => provider.openMatch(item.fixtureId)
                  onToggleFavorite: () => provider.toggleFavorite('match', item.fixtureId)

  # ---------- Interactions ----------
  interactions:
    pullToRefresh: { action: provider.reload }
    loadMore: { trigger: scrollEnd, action: provider.loadNextPage }
    starToggle: provider.toggleFavorite

  # ---------- Conditional UI ----------
  conditions:
    loading: { widget: Loader }
    error: { widget: ErrorView, bindings: { message: provider.errorMessage } }

  # ---------- Analytics ----------
  analytics:
    events:
      - name: favorites_opened
      - name: favorites_tab_change
        params: { tab: "{provider.tabId}" }
      - name: favorites_open_league
        params: { league_id: "{item.id}" }
      - name: favorites_open_team
        params: { team_id: "{item.id}" }
      - name: favorites_open_match
        params: { fixture_id: "{item.fixtureId}" }
      - name: favorites_toggle
        params: { type: "{type}", ref_id: "{refId}", is_favorite: "{provider.isFavorite(type,refId)}" }

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Tabs: **Leagues | Teams | Matches**. Empty state shows star illustration + “Go to Matches”. :contentReference[oaicite:4]{index=4}
    - LeagueCard: name, country, “Matches today: N”, ⭐, CTA “View Matches” opens filtered schedule for that league. :contentReference[oaicite:5]{index=5}
    - TeamCard: name + logo, league, “Next match / Playing now / Last match”, ⭐, CTA “Predict Now” or “Open Match”. :contentReference[oaicite:6]{index=6}
    - Matches tab uses existing **MatchCard** with ⭐ toggle. Status text per card rules.

```

```yaml
# ===============================
# Screen PRD — UserProfilePage
# ===============================
screen:
  id: user_profile
  route: /profile
  page_class: UserProfilePage
  purpose: "User identity, summary metrics, quick actions, and maintenance."

  # ---------- State & Data ----------
  state:
    provider_class: UserProfileProvider
    init:
      calls:
        - method: load
          args: {}   # loads avatar, name, badges, summary, recent predictions
  data:
    sources:
      - type: local
        name: Database.profile              # avatarId, displayName, settings
      - type: local
        name: Database.predictions          # for summary + recent predictions
      - type: repository
        name: MatchesRepository (optional)  # hydrate recent by fixture_id
    sample:
      user: { avatarId: 1, name: "FootballMaster92" }
      badges: { wins: 10, perfectDay: 1, total: 50 }
      summary: { total:124, accuracyPct:63, correct:78, missed:46, avgOdds:2.35, avgPerWeek:15.5 }
      recent: [{fixtureId:1,status:"Upcoming"},{fixtureId:2,status:"Missed"}]
    notes:
      - Обов’язкові елементи екрана та модалок зафіксовані в ТЗ. :contentReference[oaicite:2]{index=2}

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "PROFILE"
        showLeft: false
        showRight: true
        rightIcon: AppIcons.settings
        onRightPressed: provider.openSettings
    body:
      type: SingleChildScrollView
      padding: Insets.allMd
      children:

        # Avatar + name
        - key: header
          type: Column
          align: center
          children:
            - type: AvatarHero
              size: Sizes.avatarLg
              bindings:
                avatarId: provider.user.avatarId
                onEdit: provider.openEditAvatarDialog
            - type: Text
              props: { text_bind: provider.user.name }
              style: { text_role: titleLarge }

        # Badges row
        - key: badges
          type: Row
          spacing: Gaps.wMd
          children:
            - component_ref: achievement_chip ; bindings: { value: provider.badges.wins,       label: "Wins" }
            - component_ref: achievement_chip ; bindings: { value: provider.badges.perfectDay, label: "Perfect Day" }
            - component_ref: achievement_chip ; bindings: { value: provider.badges.total,      label: "Predictions" }

        # Summary metrics (6)
        - key: summary
          type: Grid
          columns: 3
          spacing: Gaps.wMd
          children:
            - component_ref: metric_card ; bindings: { label: "Total Preds",        value: provider.summary.total.toString() }
            - component_ref: metric_card ; bindings: { label: "Accuracy",           value: provider.summary.accuracyPct.toString()+"%" }
            - component_ref: metric_card ; bindings: { label: "Correct",            value: provider.summary.correct.toString() }
            - component_ref: metric_card ; bindings: { label: "Missed",             value: provider.summary.missed.toString() }
            - component_ref: metric_card ; bindings: { label: "Avg Odds Picked",    value: provider.summary.avgOdds.toStringAsFixed(2) }
            - component_ref: metric_card ; bindings: { label: "Predictions/Week",   value: provider.summary.avgPerWeek.toStringAsFixed(1) }
          style:
            card_bg: AppColors.cardDark   # per DS for cards. :contentReference[oaicite:3]{index=3}

        # Recent predictions list (2–6)
        - key: recent_title
          type: Text
          props: { text: "Recent predictions" }
          style: { text_role: titleLarge }
        - key: recent_list
          type: Column
          children:
            - type: MatchCard
              repeat: provider.recent
              bindings:
                config: provider.cardConfigFor(item.fixtureId) # compact mode
                onOpenMatch: () => provider.openMatch(item.fixtureId)

        # Quick links
        - key: actions
          type: Column
          spacing: Gaps.hSm
          children:
            - component_ref: translucent_tinted_button ; bindings: { label: "View Statistics",     color: AppColors.accentBlue,    onPressed: provider.goStats }
            - component_ref: translucent_tinted_button ; bindings: { label: "View My Predictions", color: AppColors.accentBlue,    onPressed: provider.goMyPredictions }
            - component_ref: translucent_tinted_button ; bindings: { label: "View Favorites",      color: AppColors.warningYellow, onPressed: provider.goFavorites }
            - component_ref: translucent_tinted_button ; bindings: { label: "Open Journal",        color: AppColors.errorRed,      onPressed: provider.goJournal }
            - component_ref: translucent_tinted_button ; bindings: { label: "Open Insights",       color: AppColors.accentBlue,    onPressed: provider.goInsights }

        # Danger Zone
        - key: reset_stats
          component_ref: danger_red_button
          bindings:
            label: "Reset Stats"
            onPressed: provider.openResetConfirmDialog

  # ---------- Interactions ----------
  interactions:
    editAvatar: provider.openEditAvatarDialog
    confirmReset: provider.openResetConfirmDialog
    nav:
      - to: /stats          # “View Statistics”
      - to: /predictions    # “View My Predictions”
      - to: /favorites
      - to: /journal
      - to: /insights
    # переліки швидких лінків відповідають ТЗ. :contentReference[oaicite:4]{index=4}

  # ---------- Conditional UI ----------
  conditions:
    loading: { widget: Loader }
    error:   { widget: ErrorView, bindings: { message: provider.errorMessage } }

  # ---------- Analytics ----------
  analytics:
    events:
      - name: profile_opened
      - name: profile_reset_open
        trigger: tap(reset_stats)
      - name: profile_avatar_edit_open
        trigger: tap(header.AvatarHero)

  # ---------- Acceptance Criteria ----------
  acceptance:
    - Відображаються аватар, ім’я, 3 бейджі та 6 метрик. :contentReference[oaicite:5]{index=5}
    - Список останніх 5–6 прогнозів у компактних MatchCard. :contentReference[oaicite:6]{index=6}
    - Кнопки-лінки: Stats, My Predictions, Favorites, Insights, Journal. :contentReference[oaicite:7]{index=7}
    - Кнопка **Reset Stats** відкриває модалку з двома опціями (only stats / all data). :contentReference[oaicite:8]{index=8}

```

```yaml
# ===============================
# Screen PRD — MyPredictionsPage
# ===============================
screen:
  id: my_predictions
  route: /predictions
  page_class: MyPredictionsPage
  purpose: "List of all user predictions with outcomes and quick access to matches."

  # ---------- State & Data ----------
  state:
    provider_class: MyPredictionsProvider
    init:
      calls:
        - method: load
          args: {}   # reads predictions from local DB, hydrates Match info as needed
  data:
    sources:
      - type: local
        name: Database.predictions        # prediction + odds + note + createdAt
      - type: repository
        name: MatchesRepository           # hydrate fixtures by ids for cards
      - type: local
        name: Database.favorites          # ⭐ state in cards
    sample:
      items:
        - { fixtureId: 1001, pick: "HOME", odds: 2.15, note: "Vinícius back...", status: "upcoming" }
        - { fixtureId: 1002, pick: "HOME", odds: 2.15, note: "—", status: "finished_correct" }
        - { fixtureId: 1003, pick: "AWAY", odds: 2.85, note: "", status: "finished_missed" }

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "MY PREDICTIONS"
        showLeft: true
        leftIcon: AppIcons.chevronLeft
        onLeft: provider.onBack
        showRight: false
    body:
      type: CustomScrollView
      slivers:
        # Empty state
        - key: empty_state
          type: Conditional
          when: provider.items.isEmpty
          child:
            type: Column
            align: center
            padding: Insets.allLg
            children:
              - { type: Image, props: { asset_const: AppImages.ballLarge } }
              - { type: Text,  props: { text: "No predictions yet" }, style: { text_role: titleMedium } }
              - component_ref: primary_button
                bindings:
                  label: "Go to Matches"
                  onPressed: provider.goToMatches

        # List of prediction cards
        - key: list
          type: SliverList
          item_builder:
            type: MatchCard
            repeat: provider.items
            bindings:
              config: provider.cardConfigFor(item.fixtureId)   # uses Match + Prediction + context=profile
              onOpenMatch: () => provider.openMatch(item.fixtureId)
              onToggleFavorite: () => provider.toggleFavorite(item.fixtureId)

  # ---------- Interactions ----------
  interactions:
    pullToRefresh: { action: provider.reload }
    cardOpen: provider.openMatch

  # ---------- Conditional UI ----------
  conditions:
    loading: { widget: Loader }
    error:   { widget: ErrorView, bindings: { message: provider.errorMessage } }

  # ---------- Analytics ----------
  analytics:
    events:
      - name: mypredictions_opened
      - name: mypredictions_open_match
        params: { fixture_id: "{item.fixtureId}" }

  # ---------- Acceptance Criteria ----------
  acceptance:
    - App bar shows title and Back.
    - Empty state matches mock: big ball illustration + “No predictions yet” + **Go to Matches**.
    - Non-empty: renders a vertical list of **MatchCard** using the “favorites/profile” density with:
        - Upcoming + Predicted
        - Completed (Correct/Missed)
        - Optional “Pending” chip if result not graded yet.
    - Each item supports: Open Match tap; star toggle persists to favorites.
    - Pull-to-refresh reloads predictions and re-hydrates matches.

```


```yaml
# ===============================
# Screen PRD — AchievementsPage
# ===============================
screen:
  id: achievements
  route: /achievements
  page_class: AchievementsPage
  purpose: "Show earned/locked achievements with progress summary."

  # ---------- State & Data ----------
  state:
    provider_class: AchievementsProvider
    init:
      calls:
        - method: load
          args: {}   # reads from local DB and computes next milestone

  data:
    sources:
      - type: local
        name: Database.achievements       # {code, name, description, earned_at}
      - type: local
        name: Database.predictions        # for progress & milestones
    sample:
      summary: { totalEarned: 12, nextMilestone: "100 Predictions Total" }
      items:
        - { code: "wins_10_row", name: "10 Wins in a Row",       desc: "", earned_at: "2025-08-14" }
        - { code: "pred_75",     name: "75 Predictions Total",   desc: "", earned_at: "2025-08-18" }
        - { code: "perfect_3",   name: "3 Perfect Days",         desc: "", earned_at: "2025-08-20" }
        - { code: "accuracy_gold", name: "Gold Accuracy",        desc: "65%+ for 4 weeks", earned_at: null }
        - { code: "underdog_hero", name: "Underdog Hero",        desc: "3 correct odds > 3.0", earned_at: null }
        - { code: "balanced_mind", name: "Balanced Mind",        desc: "", earned_at: "2025-07-25" }
    notes:
      - Джерело правди — локальна БД `predictions` + підтверджені FT; ідемпотентність і тригери описані в ТЗ (розділ 5). :contentReference[oaicite:1]{index=1}

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "ACHIEVEMENTS"
        showLeft: true
        leftIcon: AppIcons.chevronLeft
        onLeft: provider.onBack
        showRight: false
    body:
      type: SingleChildScrollView
      padding: Insets.allMd
      children:
        - key: section_title
          type: Text
          props: { text: "Summary section" }
          style: { text_role: titleLarge }

        # Summary cards
        - key: summary_row
          type: Column
          spacing: Gaps.hSm
          children:
            - type: Card
              style: { bg: AppColors.cardDark, radius: AppRadius.lg }
              child:
                type: Row
                align: center
                justify: spaceBetween
                children:
                  - { type: Image, props: { asset_const: AppIcons.badgeGold } }
                  - { type: Text,  props: { text_bind: provider.summary.totalEarned.toString() }, style: { text_role: hero } }
                  - { type: Text,  props: { text: "Total badges earned" }, style: { text_role: bodyMedium } }
            - type: Card
              style: { bg: AppColors.cardDark, radius: AppRadius.lg }
              child:
                type: Row
                align: center
                justify: spaceBetween
                children:
                  - { type: Image, props: { asset_const: AppIcons.milestoneTarget } }
                  - { type: Text,  props: { text_bind: provider.summary.nextMilestoneNumber }, style: { text_role: hero } }
                  - { type: Text,  props: { text_bind: provider.summary.nextMilestoneLabel }, style: { text_role: titleMedium } }
                  - { type: Text,  props: { text: "Next milestone" }, style: { text_role: bodyMedium } }
          notes:
            - Стилі карт/типографіки згідно дизайн-системи (радіуси 15/6, кольори). :contentReference[oaicite:2]{index=2} :contentReference[oaicite:3]{index=3}

        - key: list_title
          type: Text
          props: { text: "Achievements list" }
          style: { text_role: titleLarge }

        # 2-column grid of achievements (earned + locked)
        - key: grid
          type: Grid
          columns: 2
          spacing: Gaps.wMd
          children:
            - type: AchievementTile
              repeat: provider.items
              bindings:
                title: item.name
                subtitle: item.earned_at != null
                  ? "Earned " + provider.formatDate(item.earned_at)
                  : item.desc
                icon: provider.iconFor(item.code, earned: item.earned_at != null)
                earned: item.earned_at != null
          notes:
            - Locked елементи відображаються сірим (muted text) як у ТЗ п.4.9. :contentReference[oaicite:4]{index=4}

  # ---------- Interactions ----------
  interactions:
    tileTap: provider.onTileTap  # optionally open details dialog (future)

  # ---------- Conditions ----------
  conditions:
    loading: { widget: Loader }
    error:   { widget: ErrorView, bindings: { message: provider.errorMessage } }

  # ---------- Analytics ----------
  analytics:
    events:
      - name: achievements_opened

```

```yaml
# ===============================
# Screen PRD — InsightsPage
# ===============================
# ===============================
# InsightsPage
# ===============================
screen:
  id: insights_page
  route: /insights
  page_class: InsightsPage
  purpose: "Show personal trends, strengths/weaknesses, and actionable advice computed from local predictions."

  # ---------- State & Data ----------
  state:
    provider_class: InsightsProvider
    init:
      calls:
        - method: loadAndComputeInsights
          args: {}

  data:
    sources:
      - type: local
        name: PredictionsRepository              # reads local DB tables
      - type: local
        name: AchievementsRepository?            # optional for cross-signals
    sample:
      trends:
        home_accuracy_pct: 0.72
        draw_accuracy_pct: 0.25
        avg_odds: 2.10
        most_active_dow: "Saturday"
      strengths:
        - { label: "Away wins", value: "70% correct" }
        - { label: "Home wins", value: "accuracy +8% vs last week" }
      weaknesses:
        - { label: "Draws", value: "lowest accuracy (25%)" }
        - { label: "High odds >3.0", value: "only 10% success" }
      advice:
        - "Try reducing the number of draw predictions this week"
        - "You’re strong with away wins — use that to your advantage"
        - "Explore more leagues to balance your picks"

  # ---------- Domain / Computation ----------
  logic:
    timezone: Europe/Kyiv
    data_sources: "Local DB only; recompute weekly or on demand."   # no network here
    metrics:
      # base set shown in “Your Trends”
      - id: home_accuracy_pct
        def: "Wins where pick==Home ÷ Predictions where pick==Home (lifetime unless filtered)"
      - id: draw_accuracy_pct
        def: "Wins where pick==Draw ÷ Predictions where pick==Draw"
      - id: avg_odds
        def: "Average of odds_at_pick across all predictions"
      - id: most_active_dow
        def: "Weekday with the highest count of predictions (Mon–Sun)"
    focus_points:
      strengths_rules:
        - "Per-pick accuracy (Home/Draw/Away) that is ≥ global_accuracy + 8pp OR ≥ 70% in the last 4 weeks"
        - "Positive WoW trend for the same pick type: Δaccuracy ≥ +5pp"
      weaknesses_rules:
        - "Per-pick accuracy ≤ global_accuracy − 8pp OR ≤ 35% in the last 4 weeks"
        - "High-odds bucket (odds_at_pick > 3.0) success rate < 20%"
    advice_generation:
      - "Map each weakness to one concrete tip (limit 2)"
      - "Add up to 1 tip from strengths (how to leverage it)"
      - "Max 3 tips; most recent signals win"

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: appbar                                  # from catalog
      bindings:
        title: "INSIGHTS"
        leadingIcon: AppIcons.back                           # back to previous
        trailingIcon: null
        onLeadingTap: { action: navigate, to: /stats }       # Back to Stats (per TS)
    body:
      type: Scroll
      padding: Insets.allMd
      children:

        # Section: Your Trends (4 tiles in a two-by-two grid on phones)
        - key: trends_title
          type: Text
          props: { text: "Your Trends" }
          style: { text_role: titleLarge }
        - key: trends_grid
          type: Grid
          columns: 2
          spacing: AppSpacing.md
          items:
            - type: MetricTile
              bindings: { title: "Home Wins", value: "{provider.trends.home_accuracy_pct | pct0}" }
            - type: MetricTile
              bindings: { title: "Draw accuracy", value: "{provider.trends.draw_accuracy_pct | pct0}" }
            - type: MetricTile
              bindings: { title: "Avg odds", value: "{provider.trends.avg_odds | num2}" }
            - type: MetricTile
              bindings: { title: "Most active", value: "{provider.trends.most_active_dow}" }

        # Section: Focus Points (Strengths / Weaknesses blocks)
        - key: focus_title
          type: Text
          props: { text: "Focus Points" }
          style: { text_role: titleLarge }

        - key: strengths_card
          type: Card
          style: { tint: AppColors.success }                 # green header strip
          children:
            - type: SectionHeader
              props: { text: "Strengths" }
            - type: LabeledRows
              bindings: { items: "{provider.strengths}" }    # label + value rows

        - key: weaknesses_card
          type: Card
          style: { tint: AppColors.error }                   # red header strip
          children:
            - type: SectionHeader
              props: { text: "Weaknesses" }
            - type: LabeledRows
              bindings: { items: "{provider.weaknesses}" }

        # Section: Advice (bulleted suggestion chips/rows)
        - key: advice_title
          type: Text
          props: { text: "Advice" }
          style: { text_role: titleLarge }

        - key: advice_list
          type: List
          item:
            type: AdviceRow
            leadingIcon_const: AppIcons.bulb
            bindings: { text: item }
          bindings:
            items: "{provider.advice}"

        # Footer CTA
        - key: improve_btn
          component_ref: translucent_tinted_button           # from catalog
          props:
            label: "Improve Strategy"
            color: AppColors.success                         # tinted outline/overlay
          interactions:
            onTap: { action: navigate, to: /stats }          # deep-link to Statistics
  # ---------- Interactions ----------
  interactions:
    pullToRefresh: { action: provider.call, method: loadAndComputeInsights }

  # ---------- Analytics ----------
  analytics:
    events:
      - name: insights_opened
      - name: insights_improve_strategy_tap

  # ---------- Assets ----------
  assets:
    icons: [ AppIcons.back, AppIcons.bulb ]
    images: []

  # ---------- Acceptance Criteria ----------
  acceptance:
    - App bar shows “INSIGHTS” with a back action to Statistics. :contentReference[oaicite:0]{index=0}
    - “Your Trends” displays four tiles: Home Wins %, Draw Accuracy %, Avg Odds, Most Active Day. Values are computed from local predictions. :contentReference[oaicite:1]{index=1}
    - “Focus Points” renders two cards: **Strengths** (green tint) and **Weaknesses** (red tint) with 1–3 rows each. :contentReference[oaicite:2]{index=2}
    - “Advice” lists up to three actionable tips derived from the focus rules. :contentReference[oaicite:3]{index=3}
    - Primary footer CTA uses the **translucent_tinted_button** style with success color and navigates to **Statistics**. :contentReference[oaicite:4]{index=4}
    - Page performs no network requests; insights are recomputed from local data on open/refresh and weekly. :contentReference[oaicite:5]{index=5}

```

```yaml
# ===============================
# Screen PRD — PredictionJournalPage
# ===============================
screen:
  id: prediction_journal
  route: /journal
  page_class: PredictionJournalPage
  purpose: "Daily journal of predictions with a free-form note and daily summary."

  # ---------- State & Data ----------
  state:
    provider_class: PredictionJournalProvider
    init:
      calls:
        - method: loadForDate
          args: { date: "today" }     # local device time (Europe/Kyiv per app)

  data:
    sources:
      - type: local
        name: Database.predictions      # predictions with result, odds_at_pick
      - type: local
        name: Database.journal_notes    # {date_ymd, text, updated_at}
    sample:
      date_ymd: "2025-08-28"
      matches: [ { fixtureId: 1 }, { fixtureId: 2 } ]
      note: "Madrid played aggressively, good counterattack strategy"
      summary: { total: 3, correct: 2, missed: 1, avg_odds: 2.40 }

  # ---------- Layout ----------
  layout:
    type: Scaffold
    appBar:
      component_ref: app_bar_actions
      bindings:
        title: "PREDICTION JOURNAL"
        showLeft: true
        leftIcon: AppIcons.chevronLeft
        onLeft: provider.onBack
        showRight: true
        rightIcon: AppIcons.calendar
        onRightPressed: provider.openDatePicker    # native date picker dialog
    body:
      type: CustomScrollView
      slivers:

        # Day selector (Yesterday | Today | Tomorrow)
        - key: day_switcher
          type: SliverToBoxAdapter
          child:
            component_ref: segmented_tabs
            bindings:
              items:
                - { id: "yesterday", label: "Yesterday" }
                - { id: "today",     label: "Today" }
                - { id: "tomorrow",  label: "Tomorrow" }
              selectedId: provider.selectedTabId
              onChange: provider.onDayTabChange

        # Predictions list for the selected day
        - key: predictions
          type: SliverList
          item_builder:
            type: MatchCard
            repeat: provider.matchesForDay
            bindings:
              config: provider.cardConfigFor(item.fixtureId)  # compact card variant
              onOpenMatch: () => provider.openMatch(item.fixtureId)

        # Notes area
        - key: note_area
          type: SliverToBoxAdapter
          child:
            type: Column
            padding: Insets.allMd
            children:

              # When no note saved yet -> editable field + Add button
              - type: Conditional
                when: !provider.hasNote
                child:
                  type: Row
                  children:
                    - component_ref: notes_text_field
                      flex: 1
                      bindings:
                        hint: "Add your notes for this day..."
                        controller_bind: provider.noteController
                        maxLines: 4
                    - component_ref: primary_button
                      bindings:
                        label: "Add Note"
                        onPressed: provider.addNote

              # When note exists -> read-only block + Delete/Edit buttons
              - type: Conditional
                when: provider.hasNote
                child:
                  type: Column
                  children:
                    - component_ref: notes_text_field
                      bindings:
                        readOnly: true
                        controller_bind: provider.readonlyNoteController
                        maxLines: 6
                    - type: Row
                      spacing: Gaps.wSm
                      children:
                        - component_ref: danger_red_button
                          bindings: { label: "Delete Note", onPressed: provider.deleteNote }
                        - component_ref: secondary_green_button_light
                          bindings: { label: "Edit Note", onPressed: provider.enterEditMode }

        # Daily Summary grid
        - key: summary_title
          type: SliverToBoxAdapter
          child:
            type: Text
            props: { text: "Daily summary" }
            style: { text_role: titleLarge }
        - key: summary_grid
          type: SliverToBoxAdapter
          child:
            type: Grid
            columns: 2
            spacing: Gaps.wMd
            children:
              - component_ref: metric_card ; bindings: { label: "Total",    value: provider.summary.total.toString() }
              - component_ref: metric_card ; bindings: { label: "Correct",  value: provider.summary.correct.toString() }
              - component_ref: metric_card ; bindings: { label: "Missed",   value: provider.summary.missed.toString() }
              - component_ref: metric_card ; bindings: { label: "Avg odds", value: provider.summary.avg_odds.toStringAsFixed(2) }

  # ---------- Interactions ----------
  interactions:
    onDayTabChange: provider.onDayTabChange               # shifts date -1/0/+1
    openDatePicker: provider.openDatePicker               # native date picker modal
    onDatePicked: provider.setDate                        # reloads content for picked date
    addNote: provider.addNote
    deleteNote: provider.deleteNote
    enterEditMode: provider.enterEditMode                 # toggles field to editable + Save via primary_button
    pullToRefresh: { action: provider.reload }

  # ---------- Domain / Computation ----------
  logic:
    timezone: Europe/Kyiv
    date_key: "YYYY-MM-DD (local)"
    matchesForDay_query: "predictions where kickoff_time (local) is on date_key"
    summary:
      total:   "count(predictions on date_key)"
      correct: "count(result == W)"
      missed:  "count(result == L)"
      avg_odds:"average(odds_at_pick) over all predictions on date_key"
    notes:
      create: "insert into journal_notes {date_ymd, text, updated_at=now}"
      update: "update journal_notes set text=?, updated_at=now where date_ymd=?"
      delete: "delete from journal_notes where date_ymd=?"

  # ---------- Analytics ----------
  analytics:
    events:
      - name: journal_opened
        params: { date_ymd: "{provider.dateKey}" }
      - name: journal_note_added
      - name: journal_note_edited
      - name: journal_note_deleted
      - name: journal_date_selected
        params: { date_ymd: "{provider.dateKey}" }

  # ---------- Acceptance Criteria ----------
  acceptance:
    - App bar shows “PREDICTION JOURNAL” with **Back** and a **Calendar** icon.
    - Segmented tabs **Yesterday | Today | Tomorrow** switch the visible date.
    - The list shows **MatchCard** items for the selected day (compact layout).
    - If no note exists, user sees an editable field and **Add Note** (primary).  
      If a note exists, show read-only text + **Delete Note** (danger) and **Edit Note** (light green).
    - “Daily summary” shows four tiles: **Total, Correct, Missed, Avg odds** computed from that day’s predictions.
    - Tapping the calendar opens a native date picker; selecting a date reloads the page for that day.
    - All data is read/written locally (`predictions`, `journal_notes`). No network calls on this page.

```

## 4) API (only if used)
```yaml
api:
  base_url: https://v3.football.api-sports.io
  headers:
    x-apisports-key: ${API_KEY}         # from config.dart
    accept: application/json
  default_params:
    timezone: Europe/Kyiv
  rate_limit:
    note: "API-Sports has rate limits; caching and local DB are required"
    strategy:
      - in_memory_cache_ttl_s: 30
      - sqlite_cache_ttl_s: 300
      - retry_backoff_ms: [500, 1500, 3000]
      - jitter: true
  errors:
    - { code: 400, meaning: "Bad Request" }
    - { code: 401, meaning: "Unauthorized" }
    - { code: 403, meaning: "Forbidden / quota" }
    - { code: 404, meaning: "Not Found" }
    - { code: 429, meaning: "Rate limited" }
    - { code: 5xx, meaning: "Server error" }

  endpoints:
    # -------- Fixtures (matches)
    - name: getFixturesByDate
      method: GET
      path: /fixtures
      query: [date, timezone]
      response_model: List<Fixture>

    - name: getFixturesByLeague
      method: GET
      path: /fixtures
      query: [league, season, date?, status?, timezone]
      response_model: List<Fixture>

    - name: getFixturesByIds
      method: GET
      path: /fixtures
      query: [ids, timezone]             # ids=123-456-789
      response_model: List<Fixture>

    - name: getLiveFixtures
      method: GET
      path: /fixtures
      query: [live, timezone]            # live=all or live=123-456
      response_model: List<Fixture>

    - name: getFixtureById
      method: GET
      path: /fixtures
      query: [id, timezone]
      response_model: List<Fixture>      # API returns a List with 1 item

    # -------- Odds
    - name: getOddsByFixture
      method: GET
      path: /odds
      query: [fixture]
      response_model: OddsSnapshot

    # -------- Leagues/Teams/Stats (for favorites/insights)
    - name: getLeagues
      method: GET
      path: /leagues
      query: [country?, type?, season?]
      response_model: List<League>

    - name: getTeamsByLeague
      method: GET
      path: /teams
      query: [league, season]
      response_model: List<TeamRef>

    - name: getTeamStatistics
      method: GET
      path: /teams/statistics
      query: [league, season, team]
      response_model: TeamStats

    - name: getStandings
      method: GET
      path: /standings
      query: [league, season]
      response_model: List<StandingRow>

  notes:
    - "For MatchSchedule live tabs, use 30–60s polling (stop in background)."
    - "Normalize all responses to data/models/* before persisting to DB."
    - "Prefer batch requests (ids) for card hydration and journal."

```


## 5) Models (only those not in repo)
```yaml
models:
  # ---------- CORE (from API)
  - name: Fixture
    file: data/models/fixture.dart
    fields:
      - { name: fixtureId,    type: int,      nullable: false }
      - { name: leagueId,     type: int,      nullable: false }
      - { name: leagueName,   type: String,   nullable: false }
      - { name: country,      type: String?,  nullable: true }
      - { name: dateUtc,      type: DateTime, nullable: false }
      - { name: status,       type: String,   nullable: false }     # NS/1H/HT/2H/FT/ET/PST...
      - { name: minute,       type: int?,     nullable: true }      # live minute
      - { name: homeTeam,     type: TeamRef,  nullable: false }
      - { name: awayTeam,     type: TeamRef,  nullable: false }
      - { name: goalsHome,    type: int?,     nullable: true }
      - { name: goalsAway,    type: int?,     nullable: true }
    json: { fromJson: true, toJson: true, equatable: true }

  - name: TeamRef
    file: data/models/team_ref.dart
    fields:
      - { name: id,    type: int,     nullable: false }
      - { name: name,  type: String,  nullable: false }
      - { name: logo,  type: String?, nullable: true }
    json: { fromJson: true, toJson: true, equatable: true }

  - name: League
    file: data/models/league.dart
    fields:
      - { name: id,        type: int,     nullable: false }
      - { name: name,      type: String,  nullable: false }
      - { name: country,   type: String?, nullable: true }
      - { name: season,    type: int?,    nullable: true }
      - { name: type,      type: String?, nullable: true }  # League/Cup
      - { name: logo,      type: String?, nullable: true }
    json: { fromJson: true, toJson: true, equatable: true }

  - name: OddsSnapshot
    file: data/models/odds_snapshot.dart
    fields:
      - { name: fixtureId, type: int,      nullable: false }
      - { name: home,     type: double,   nullable: false }
      - { name: draw,     type: double,   nullable: false }
      - { name: away,     type: double,   nullable: false }
      - { name: ts,       type: DateTime, nullable: false }  # timestamp when odds were captured
    json: { fromJson: true, toJson: true, equatable: true }

  - name: TeamStats
    file: data/models/team_stats.dart
    fields:
      - { name: teamId,         type: int,     nullable: false }
      - { name: leagueId,       type: int,     nullable: false }
      - { name: season,         type: int,     nullable: false }
      - { name: form,           type: String?, nullable: true }     # WWDLD…
      - { name: goalsForAvg,    type: double?, nullable: true }
      - { name: goalsAgainstAvg,type: double?, nullable: true }
      - { name: cleanSheets,    type: int?,    nullable: true }
      - { name: failedToScore,  type: int?,    nullable: true }
    json: { fromJson: true, toJson: true, equatable: true }

  - name: StandingRow
    file: data/models/standing_row.dart
    fields:
      - { name: team,    type: TeamRef,  nullable: false }
      - { name: rank,    type: int,      nullable: false }
      - { name: played,  type: int,      nullable: false }
      - { name: win,     type: int,      nullable: false }
      - { name: draw,    type: int,      nullable: false }
      - { name: lose,    type: int,      nullable: false }
      - { name: points,  type: int,      nullable: false }
      - { name: form,    type: String?,  nullable: true }
    json: { fromJson: true, toJson: true, equatable: true }

  # ---------- LOCAL (offline/analytics/journal)
  - name: Prediction
    file: data/models/prediction.dart
    fields:
      - { name: fixtureId, type: int,       nullable: false }
      - { name: pick,      type: String,    nullable: false }  # home|draw|away
      - { name: odds,      type: double?,   nullable: true }
      - { name: madeAt,    type: DateTime,  nullable: false }
      - { name: lockedAt,  type: DateTime?, nullable: true }   # when edits are locked
      - { name: result,    type: String?,   nullable: true }   # correct|missed|null
    json: { fromJson: true, toJson: true, equatable: true }

  - name: Achievement
    file: data/models/achievement.dart
    fields:
      - { name: id,        type: String,   nullable: false }   # slug
      - { name: title,     type: String,   nullable: false }
      - { name: description,type: String,  nullable: false }
      - { name: earnedAt,  type: DateTime?,nullable: true }
    json: { fromJson: true, toJson: true, equatable: true }

  - name: Insight
    file: data/models/insight.dart
    fields:
      - { name: id,        type: String,   nullable: false }
      - { name: title,     type: String,   nullable: false }
      - { name: value,     type: String,   nullable: false }   # text or formatted %
      - { name: computedAt,type: DateTime, nullable: false }
    json: { fromJson: true, toJson: true, equatable: true }

  - name: JournalEntry
    file: data/models/journal_entry.dart
    fields:
      - { name: date,      type: DateTime,      nullable: false }
      - { name: events,    type: List<String>,  nullable: false }  # short notes/events of the day
    json: { fromJson: true, toJson: true, equatable: true }

```
