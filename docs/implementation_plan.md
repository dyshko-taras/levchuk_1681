# Implementation Plan — Football Predictor (Flutter)

> **Precedence:** PRD → Visual Style → Global Guidelines → Assets. All decisions below follow that order and are annotated with citations.

---

## 1) Architecture & Setup

### Project structure & tech

* Follow **Global Guidelines** structure under `lib/` with clear separation of `core/`, `constants/`, `data/ (api/local/repositories)`, `providers/`, `ui/ (theme/pages/widgets)`.&#x20;
* **State mgmt:** `provider` + `ChangeNotifier` per feature/domain. Widgets are passive.&#x20;
* **Networking:** `Dio` + `Retrofit` + `json_serializable`. All HTTP via Retrofit services; generate code with `build_runner`.&#x20;
* **Routing:** Centralize in `lib/constants/app_routes.dart`. Root shell uses **IndexedStack** with bottom nav; tab deep-links route back to the shell with selected index. Non-tab details (e.g., `/match/:id`) are standalone routes.&#x20;
* **Theme:** Material 3, single **dark** system per PRD meta; fonts/colors in `ui/theme/`.
* **Timezone:** Business logic defaults to **Europe/Kyiv**.&#x20;

### Environments & flavors

* `core/env.dart` exposes `isProd`, `apiBaseUrl`, feature flags.
* `core/endpoints.dart` hosts base URL and path constants (see Network Layer).

### Allowed packages (baseline)

* `provider`, `dio`, `retrofit`, `json_annotation`, `build_runner`, `json_serializable`, `drift`, `sqlite3_flutter_libs`, `path_provider`, `shared_preferences`, `flutter_svg`, `fl_chart`, `table_calendar`, `percent_indicator`, `flutter_datetime_picker_plus`, `flutter_colorpicker`.&#x20;

### Constants folder inventory & usage contract

Create and enforce access **only via constants** (no raw literals/paths):

* `lib/constants/app_icons.dart` (SVG map)
* `lib/constants/app_images.dart` (raster & helpers)
* `lib/constants/app_routes.dart` (all route names & route table)
* `lib/constants/app_strings.dart` (EN-only strings per PRD meta)
* `lib/constants/app_config.dart` (optional: feature flags, API keys)
* Tokens: `app_spacing.dart`, `app_radius.dart`, `app_sizes.dart`, `app_durations.dart`
  Usage examples (Svg/Image/spacing/duration) per **contract**.&#x20;

**Registration strategy**

* Expose constants as static members, e.g., `AppIcons.navMatches`, `AppImages.welcomeHero`, `AppRoutes.matches`.
* For tokens, provide types **AppSpacing/Gaps/Insets/NumSpaceExtension**, `AppRadius`, `Sizes`, `AppDurations`.&#x20;
* Prohibit raw `'assets/...` strings and inline spacing/duration numbers through CI lint.&#x20;

**Acceptance criteria**

* Project compiles with above structure; no UI/widget references raw asset paths or inline spacing/radius/duration literals.
* `AppRoutes.routes` instantiates shell per tab deep-links; detail routes are registered outside the shell.&#x20;

---

## 2) Design Tokens & Theming

### Token extraction (from Visual Style → code)

* **Colors (`app_colors.dart`):**
  `primaryBlack #000000`, `successGreen #00DD70`, `warningYellow #FAD749`, `errorRed #FF5555`, `cardDark #161616`, `borderGray #323232`, `textWhite #FFFFFF`, `textGray #727272`, `accentBlue #38B6FF`, `accentOrange #FF8438`.&#x20;
* **Typography (`app_fonts.dart`):**
  Family `Inter` with weights 400…900; roles mapped to M3 text styles (e.g., `displayHero`→Black 900, `titleLarge`→700/600). Sizes: Hero 27, Title 18, Heading 16.5, Subheading 15, Body 13.5, Caption 12, Small 10.5, Micro 9.0.&#x20;
* **Spacing (`app_spacing.dart`):**
  XS 6, SM 9, MD 15, LG 24, XL 36 → expose via `AppSpacing`, `Gaps`, `Insets`, `NumSpaceExtension`.
* **Radius (`app_radius.dart`):**
  Map buttons≈6px, cards≈15px as tokens: `btnLg`, `cardLg`, plus `sm/md/lg/xl/pill`.&#x20;
* **Sizes (`app_sizes.dart`):**
  Component-specific sizes: `buttonMd`, `buttonLg?`, `navBarHeight`, `chipHeight`, `teamBadge`, `appBarHeight`, chart sizes, etc. (derive from PRD component catalog; missing exact px → **tokens with semantic names**).&#x20;
* **Durations (`app_durations.dart`):**
  `splashMin` (1.5–2s window), `debounceShort`, `predictionLock` (lead time before kickoff) per rules; exact numeric values **only inside tokens**, never inline.&#x20;

### Material 3 theme wiring (`app_theme.dart`)

* `useMaterial3: true`; build dark `ColorScheme` from tokens; set `TextTheme` using Inter roles. Component themes: `AppBarTheme`, `CardTheme`, `BottomNavigationBarTheme`, `ChipTheme`, `ButtonTheme`/`FilledButtonTheme` to bind colors/sizes/radii **via tokens only**.&#x20;

**Acceptance criteria**

* All colors/typography/spacing/radii/sizes/durations referenced **only via token files**.
* Theme reproduces dark DS; no light theme.&#x20;

---

## 3) Assets Integration

### Folder layout & registration

* `assets/icons/` (SVG), `assets/images/` (raster/webp/jpeg), `assets/fonts/` (Inter TTF). Register folders in `pubspec.yaml` and add Inter font family.&#x20;
* **Icons (SVG):** from Assets List (navigation, actions, status, favorites/domain, charts helpers). Prefer SVG for UI elements.&#x20;
* **Images:** backgrounds, brand, empty states, profile avatars (6). Use WebP (transparent) or JPEG per rule.&#x20;
* **Fonts:** Inter Regular→Black TTF set.&#x20;

### Access pattern

* Icons via `flutter_svg` + `AppIcons.*`, images via `AppImages.*` helpers. **No raw paths**.&#x20;

**Performance notes**

* Cache team badges; provide placeholders. Prefer WebP for transparent UI art; JPEG for photos/backgrounds. Avoid raster icons.&#x20;

**Acceptance criteria**

* All listed assets are declared in `pubspec.yaml` and resolved via `AppIcons/AppImages`.
* App boots without missing-asset errors; SVGs render via `flutter_svg`.&#x20;

---

## 4) Data & Models

### Domain overview (from PRD)

* **Matches/Fixtures**, **Odds**, **Predictions**, **Favorites** (league/team/match), **Notes** (per fixture), **Achievements**, **Profile** (avatar/name), **Counters & Stats** computed locally.

### JSON models (`json_serializable`)

* `Match`, `OddsSnapshot`, `Prediction`, `Favorite`, `Note`, `Achievement`, `UserProfile`, data wrappers (lists/paging).
* Use `@JsonKey` for server field mapping; equality via `equatable` or manual `==` (if allowed).

### Local DB (Drift) schema

* Tables:

  * `matches` (fixtureId PK, leagueId, homeId, awayId, kickoffUtc, status, scoreHome, scoreAway, country, leagueName, cachedLogoUrls…).
  * `odds` (fixtureId PK, home, draw, away, provider, ts).
  * `predictions` (id PK, fixtureId FK, pick enum, odds, createdAt, gradedAt?, result enum\[correct|missed|pending]).
  * `favorites` (type enum\[league|team|match], refId, addedAt).
  * `notes` (fixtureId PK, text, updatedAt).
  * `achievements` (code PK, name, description, earnedAt?).
  * `profile` (singleton row: avatarId, displayName).
  * Indices on `fixtureId`, `status`, `createdAt`; FKs to ensure integrity.
* **Caching policy:** fixtures by date/status are cached; odds lazy-fetch per card open; predictions/notes/favorites local-first; stats derived on demand with memoization. PRD requires counters from local DB.&#x20;

**Acceptance criteria**

* JSON models compile with generated code; DB migrations create all tables and indices; repositories fetch/cache data; counters and stats read from local DB as specified.&#x20;

---

## 5) Network Layer

### Base & endpoints

* `Endpoints.baseUrl` (// TODO(doc): confirm).
* REST paths (from PRD samples):

  * `GET /leagues?country={NAME}&season={YYYY}`
  * `GET /fixtures?league={id}&season={YYYY}&date=YYYY-MM-DD&timezone=Europe/Kyiv`
  * `GET /odds?fixture={id}`
  * Optional batch verify FT: `GET /fixtures?ids=...` for stats validation.

### Client settings

* Timeouts: connect/receive in `ApiClient`. Interceptors: logging in dev, retry/backoff (exponential, jitter) on idempotent GETs. Headers: JSON.&#x20;

### Error handling

* Map HTTP/network errors to domain failures; providers expose `errorMessage`. Offline: serve from cache, enqueue validations.

**Acceptance criteria**

* All API calls go through Retrofit services; retries on safe GETs; timezone parameter **Europe/Kyiv** appended where relevant.&#x20;

---

## 6) Repositories

* `MatchesRepository`: fetch by date/filters; hydrate cards; cache to `matches`.
* `OddsRepository`: `getOdds(fixtureId)`; memoize in `odds`.
* `PredictionsRepository`: CRUD predictions; grading logic on FT.
* `FavoritesRepository`: toggle/list by type; persist.
* `NotesRepository`: set/get per fixture.
* `AchievementsRepository`: compute from `predictions` & update `achievements`.
* `ProfileRepository`: read/write avatar/name.

**Acceptance criteria**

* Providers depend only on repositories; repositories abstract API/DB/cache and contain no UI logic.&#x20;

---

## 7) Providers (ChangeNotifiers)

Define one per **domain** with clear IO and lifecycles:

* `AppBootstrapProvider` (Splash): `ensureInitialized()`, `readFirstRunFlag()`. Outputs: `isFirstRun`. Navigates after `AppDurations.splashMin`.&#x20;
* `WelcomeProvider`: reads/writes first run; `onGetStarted()` sets flag and routes.&#x20;
* `BottomNavProvider`: `currentIndex`, history stack, deep-link handling.&#x20;
* `MatchesProvider`: `selectedDate/DayId`, `filters`, `counters`, list paging, pull-to-refresh; deps: Matches/Predictions/Favorites/Notes/Odds repos.&#x20;
* `MatchDetailsProvider`: load fixture+odds, hold pick state, lock editing near kickoff (reads `AppDurations.predictionLock`), notes CRUD, toggle favorite. **Events** per PRD acceptance.&#x20;
* `StatisticsProvider`: compute summary, outcomes pie, weekday bars, trend; optional FT validation burst.&#x20;
* `FavoritesProvider`: tabs (Leagues|Teams|Matches), lists, toggle favorite, quick open. (Specs inferred from registry; // TODO(doc): confirm tab content details).&#x20;
* `UserProfileProvider`: avatar/name, quick links, recent predictions compact list, reset dialogs actions.&#x20;
* `MyPredictionsProvider`: load list, hydrate missing matches, pull-to-refresh, open match.&#x20;
* `AchievementsProvider`: load earned/locked, compute progress/next milestone.&#x20;
* `InsightsProvider`: trends/advice based on stats (derived from local DB; // TODO(doc): confirm exact panels).&#x20;
* `PredictionJournalProvider`: calendar source of truth (TableCalendar), daily timeline from predictions/notes (// TODO(doc): confirm exact events layout).&#x20;

**Test seams**

* Repositories injected via constructors; use interfaces to mock. Providers expose pure methods for state transitions.

**Acceptance criteria**

* Providers are domain-scoped; no Dio access in providers; all actions exposed as methods used by UI.&#x20;

---

## 8) Navigation & App Flow

* **Entry:** `/splash` → `/welcome` (first run) or `/matches`. Splash is a timed brand moment (1.5–2s via token).&#x20;
* **Shell:** `/` hosts bottom nav with 4 tabs (Matches, Statistics, Favorites, Profile) via IndexedStack (state preserved). Tab deep-links `app://matches|stats|favorites|profile`.&#x20;
* **Details & flows:** `/match/:id`, `/predictions`, `/achievements`, `/insights`, `/journal`.&#x20;

**Acceptance criteria**

* Tab switch preserves state; deep-links select tabs; detail routes push above shell as separate pages.&#x20;

---

## 9) Per-screen Implementation (Phased)

> Each screen starts with **Component Catalog** (build once, reused), then the screen, with states, interactions, data deps, analytics, and AC.

### Phase A — Shared Component Catalog (reusable)

Implement the catalog items from PRD **before** screens that use them:

* **BottomNavBar** (organism), **MatchCard** (organism) with parts: LeagueHeader, TeamsRow (TeamBadge, TeamPill), CenterBlock (kickoff/score), SubInfo (odds/prediction/finished), StatusChip, Actions (CardCTA), FavoriteStar, ExpandToggle, UserNote, OddsRow, ScoreBlock, PredictionPanel; **MatchCardConfig** value object; **MatchCardRules** mapping YAML. Include `counters_triple`, `app_bar_actions`, `segmented_tabs`, button atoms (primary, secondary\_green\_button\_light, danger\_red\_button, translucent\_tinted\_button), dialogs (`prediction_dialog`, `add_to_favorites_dialog`, `reset_stats_dialog`, `edit_avatar_dialog`), fields (`notes_text_field`), charts (`donut_chart`, `bar_chart`, `line_chart`), cards (`metric_card`), favorites cards (`LeagueCard`, `TeamCard`). **All styles via tokens**.&#x20;

**AC (catalog)**

* All components compile and expose props as specified; visual roles/spacing/radius strictly via tokens; icons/images referenced via constants.&#x20;

---

### Phase B — SplashPage (`/splash`)

**Purpose:** Brand + bootstrap, route by first-run.&#x20;

* **States:** loading-only visual; provider does `ensureInitialized`, `readFirstRunFlag`.&#x20;
* **Interactions:** after `AppDurations.splashMin` → navigate `/welcome` if first run else `/matches`.&#x20;
* **Data deps:** `PrefsStore`, `MemoryCache`.&#x20;
* **Analytics:** `splash_shown`, `splash_routed(dest)`.&#x20;
* **Accessibility:** Focus order: logo → tagline (static). Hit targets N/A.
* **AC:** As listed in PRD acceptance for Splash.&#x20;

---

### Phase C — WelcomePage (`/welcome`)

**Purpose:** Intro + “Get Started”.&#x20;

* **States:** content; no loading/error.
* **Interactions:** `Get Started` → set `first_run=false` in `PrefsStore` → navigate `/matches`.&#x20;
* **Data deps:** `PrefsStore`, `AppImages.welcomeHero`.&#x20;
* **Analytics:** `welcome_shown`, `click_get_started`.&#x20;
* **AC:** Exact title/subtitle strings; token paddings; EN only.&#x20;

---

### Phase D — MainShellPage (`/`)

**Purpose:** Root shell with bottom navigation (4 tabs).&#x20;

* **States:** `BottomNavProvider` with `currentIndex`.
* **Interactions:** tab tap sets index; back behavior pops tab stack then exit; deep-links select tabs.&#x20;
* **Data deps:** local `BottomNavState`.
* **Analytics:** `shell_opened`, `tab_switch`.&#x20;
* **AC:** Order/labels of tabs; IndexedStack preserves state; deep-links work.&#x20;

---

### Phase E — MatchSchedulePage (`/matches`)

**Purpose:** Daily fixtures with counters and filters.&#x20;

* **States:** `loading` (skeleton), `empty` (No matches), `error`, `content`.
* **Interactions:** pull-to-refresh, infinite scroll, segmented tabs Yesterday/Today/Tomorrow, Filters modal open/apply/reset, star toggle, open match, prediction start.&#x20;
* **Data deps:** `MatchesRepository`, `OddsRepository`(lazy), local `matches`, `predictions`, `favorites`, `notes`.&#x20;
* **Analytics:** `schedule_opened(date)`, `schedule_filter_open`, `schedule_filter_apply`, `schedule_card_open`, `schedule_star_toggle`.&#x20;
* **Accessibility:** Focus: day tabs → counters → filter → list; touch targets ≥ 44.
* **AC:** Title “MATCH SCHEDULE”; day selector switches dataset; counters from local DB; cards render per **MatchCardRules**; filters update list; infinite scroll works.&#x20;

---

### Phase F — MatchDetailsPage (`/match/:id`)

**Purpose:** Info + odds + make/edit prediction + notes. (Spec items/AC provided)&#x20;

* **States:** `loading`, `error`, `content`. Tabs: **Info | Prediction | My Notes**.
* **Interactions:** Make/Edit prediction; lock editing at/after kickoff using `AppDurations.predictionLock`; toggle favorite; notes save offline, restore on reopen.&#x20;
* **Data deps:** fixture (repo/local), odds (repo/local), prediction (local), notes (local), favorites (local).
* **Analytics:** tab switches, prediction confirm, favorite toggle, notes save (names per domain convention).
* **AC:** Tabs switch; H/D/A odds visible; CTA text adjusts; lock at kickoff; status after FT; favorites dialog supports League/Team/Match.&#x20;

---

### Phase G — MyPredictionsPage (`/predictions`)

**Purpose:** All predictions list; open match; empty state CTA to Matches.&#x20;

* **States:** `loading`, `empty` (ball illustration + text), `error`, `content`.
* **Interactions:** pull-to-refresh; open match; star toggle in cards (persist).&#x20;
* **Data deps:** local `predictions`, `favorites`; hydrate fixtures via `MatchesRepository`.&#x20;
* **Analytics:** `mypredictions_opened`, `mypredictions_open_match(fixture_id)`.&#x20;
* **AC:** App bar with Back; empty state assets/text; non-empty uses **MatchCard** “favorites/profile” density; pull-to-refresh re-hydrates.&#x20;

---

### Phase H — StatisticsPage (`/stats`)

**Purpose:** Personal performance dashboard (local-first).&#x20;

* **States:** `loading`, `error`, `content`.
* **Interactions:** none critical; navigations to achievements/insights from quick-links (optional).
* **Data deps:** local `predictions`; optional FT verification batch via repo. Charts: donut/bar/line via `fl_chart`.&#x20;
* **Analytics:** `statistics_opened` (derive as you wire).
* **AC:** App bar title; metrics grid (3 columns); donut “Outcomes Predicted”; weekday bars; trend line.&#x20;

---

### Phase I — FavoritesPage (`/favorites`)

**Purpose:** Manage favorites across **Leagues | Teams | Matches** tabs. (Registry defines tabs; implement with segmented control and cards.)&#x20;

* **States:** `loading`, `empty` visuals from assets, `error`, `content`.
* **Interactions:** toggle favorites; open league/team/match; quick “View Matches” CTA.
* **Data deps:** local `favorites`, `matches` (today count), `MatchesRepository` for today’s fixtures.
* **Analytics:** `favorites_opened`, `favorites_toggle`(type, id).
* **AC:** Three tabs functionally switch lists; star toggles persist; “View Matches” navigates to schedule with relevant filter. // TODO(doc): confirm exact empty state copy.

---

### Phase J — UserProfilePage (`/profile`)

**Purpose:** Avatar/Name edit, badges snapshot, quick links, reset.

* **States:** `content`; error only on saves.
* **Interactions:** open **Edit Avatar** dialog (grid of 6 avatars + name), open **Reset Stats** dialog (two options). Quick links: Stats, My Predictions, Favorites, Insights, Journal.&#x20;
* **Data deps:** local `profile`, `predictions` for compact recent list & metrics, `achievements` for 3 chips.
* **Analytics:** `profile_opened`, `profile_reset_open`, `profile_avatar_edit_open`.&#x20;
* **AC:** Shows avatar, name, 3 badges, 6 metrics, compact recent predictions as **MatchCard**, quick links set, Reset dialog with two actions.&#x20;

---

### Phase K — AchievementsPage (`/achievements`)

**Purpose:** Earned/locked achievements with progress/next milestone.&#x20;

* **States:** `loading`, `content`, `empty` (if none).
* **Interactions:** none critical; optional CTA “View All Achievements” (tinted button).
* **Data deps:** local `achievements` + derived from `predictions`.
* **Analytics:** `achievements_opened`.
* **AC:** Summary card shows total earned + next milestone; list renders earned (with date) and locked items.&#x20;

---

### Phase L — InsightsPage (`/insights`)

**Purpose:** Trends, strengths/weaknesses, advice (built atop statistics). (Registry says trends/advice.)&#x20;

* **States:** `loading`, `content`.
* **Interactions:** filter timeframe; deep-link to relevant matches.
* **Data deps:** local `predictions` aggregates.
* **Analytics:** `insights_opened`, filters changes.
* **AC:** Renders at least 3 panels (trend line, strongest league/team, advice snippet). // TODO(doc): confirm exact panels/strings.

---

### Phase M — PredictionJournalPage (`/journal`)

**Purpose:** Calendar + daily timeline of predictions/notes. (Registry defines calendar + timeline.)&#x20;

* **States:** `loading`, `content`, `empty_journal` image for days without entries.
* **Interactions:** month/day navigation (TableCalendar), tap entry → open MatchDetails; add/edit note.
* **Data deps:** local `predictions`, `notes`.
* **Analytics:** `journal_opened`, `journal_day_select`.
* **AC:** Calendar header; selected day timeline; empty state visual per assets. // TODO(doc): confirm timeline row composition.

---

## 10) Cross-Cutting Concerns

* **Error/Empty patterns:** Use shared `ErrorView`/`EmptyView` with images from assets list (`empty_*`), strings from `app_strings.dart` (EN only).&#x20;
* **Offline & Sync:** Read from SQLite first; schedule background validation of FT results for stats.&#x20;
* **Loading/Skeletons:** Prefer shimmer/fade placeholders on lists and charts (sizes via `Sizes.*`).
* **Feature flags:** In `app_config.dart` (e.g., enableInsights, enableAchievementsDetail).
* **Analytics:** Event names/payloads as in PRD (MatchCard events, schedule actions, profile events). Wire via simple `Analytics.log(event, params)` façade.&#x20;

**Acceptance criteria**

* All repeated empty/error states use the same components & assets; offline reads function; analytics fire with payload keys defined in PRD components (e.g., `matchcard_*`, `schedule_*`).&#x20;

---

## 11) Constants: Concrete Files & Registration

Create/populate:

* `app_icons.dart`: map all SVGs: `nav_matches`, `nav_stats`, `nav_favorites`, `nav_profile`, actions (`search`, `filter`, `calendar`, `refresh`, `settings`, `edit`, `save`, `back`, `close`), status (`success`, `error`, `pending`), domain (`star`, `star_filled`, `league_ball`, `team`, `match`), charts (`chart_donut`, `chart_bar`, `chart_line`). Provide filled/active variants where used by BottomNav.&#x20;
* `app_images.dart`: `bg_splash`, `logo`, `welcome_hero`, empties (`empty_matches`, `empty_favorites_star`, `empty_predictions`, `empty_stats`, `empty_journal`), avatars list helper `profileAvatars6`.&#x20;
* `app_routes.dart`: names + table for `/splash`, `/welcome`, `/` (shell), `/matches`, `/stats`, `/favorites`, `/profile`, `/match/:id`, `/predictions`, `/achievements`, `/insights`, `/journal` (detail routes return pages; tab routes return the shell with index).
* `app_strings.dart`: EN-only literals from PRD (e.g., “MATCH SCHEDULE”, “WELCOME!”, “No matches for this date”, “No predictions yet”, etc.).
* Tokens: `app_spacing.dart`, `app_radius.dart`, `app_sizes.dart`, `app_durations.dart` per Section 2.

**Acceptance criteria**

* A code search confirms **zero** raw `'assets/...` literals and **zero** inline spacing/radius/duration numbers in `ui/`.&#x20;

---

## 12) Analytics Events (by feature)

* **MatchCard**: `matchcard_open_match`, `matchcard_make_prediction`, `matchcard_toggle_favorite(fixture_id, is_favorite, context)`.&#x20;
* **Schedule**: `schedule_opened(date)`, `schedule_filter_open(current_filters)`, `schedule_filter_apply(leagues,countries,status,favOnly)`, `schedule_card_open(fixture_id)`, `schedule_star_toggle(...)`.&#x20;
* **Welcome**: `welcome_shown`, `click_get_started`.&#x20;
* **Shell**: `shell_opened`, `tab_switch(index,name)`.&#x20;
* **Profile**: `profile_opened`, `profile_reset_open`, `profile_avatar_edit_open`.&#x20;
* **My Predictions**: `mypredictions_opened`, `mypredictions_open_match(fixture_id)`.&#x20;

---

## 13) Acceptance Criteria — Global

* App adheres to **Material 3** dark theme.&#x20;
* **All** screens/flows from PRD are implemented with tokens-only styling and constants-only asset access.
* State mgmt uses Providers per domain; repositories abstract data; Retrofit-only network.
* Assets list fully registered and accessible via `AppIcons`/`AppImages`.&#x20;

---

## Traceability Appendix

### 1) PRD → Plan

| PRD Screen/Flow       | Plan Section                     |
| --------------------- | -------------------------------- |
| SplashPage            | Phase B — SplashPage             |
| WelcomePage           | Phase C — WelcomePage            |
| MainShellPage         | Phase D — MainShellPage          |
| MatchSchedulePage     | Phase E — MatchSchedulePage      |
| MatchDetailsPage      | Phase F — MatchDetailsPage       |
| MyPredictionsPage     | Phase G — MyPredictionsPage      |
| StatisticsPage        | Phase H — StatisticsPage         |
| FavoritesPage         | Phase I — FavoritesPage          |
| UserProfilePage       | Phase J — UserProfilePage        |
| AchievementsPage      | Phase K — AchievementsPage       |
| InsightsPage          | Phase L — InsightsPage           |
| PredictionJournalPage | Phase M — PredictionJournalPage  |

### 2) Visual tokens → Code

| Token Category | File(s) & Usage                                                                         |
| -------------- | --------------------------------------------------------------------------------------- |
| Colors         | `ui/theme/app_colors.dart` → `app_theme.dart` (ColorScheme, component themes).          |
| Typography     | `ui/theme/app_fonts.dart` (Inter 400–900, sizes) → `app_theme.dart` TextTheme roles.    |
| Spacing        | `constants/app_spacing.dart` (AppSpacing/Gaps/Insets/NumSpaceExtension).                |
| Radii          | `constants/app_radius.dart` (btn/card/pill).                                            |
| Sizes          | `constants/app_sizes.dart` (buttons, chips, nav, charts). Derived from PRD components.  |
| Durations      | `constants/app_durations.dart` (`splashMin`, `predictionLock`, `debounceShort`).        |

### 3) Guidelines → Compliance

| Rule                             | Where Applied                                    |
| -------------------------------- | ------------------------------------------------ |
| Provider + ChangeNotifier        | Section 7 Providers; phases per screen.          |
| Retrofit/Dio/json\_serializable  | Sections 5 & 6; `data/api` + codegen.            |
| IndexedStack shell + routes      | Sections 8 & 11, Phase D.                        |
| No magic numbers / no raw assets | Sections 2 & 11; enforced via tokens/constants.  |
| Packages list                    | Section 1 Allowed packages.                      |

### 4) Assets → Registration/Constants

| Asset Group               | `pubspec.yaml` + Accessor                                                                             |
| ------------------------- | ----------------------------------------------------------------------------------------------------- |
| Icons (SVG)               | `assets/icons/` → `AppIcons.*` (e.g., `nav_matches`, `action_filter`, `status_success`).              |
| Images (raster/WebP/JPEG) | `assets/images/` → `AppImages.*` (`logo`, `welcome_hero`, `empty_*`, `avatars/*`).                    |
| Backgrounds               | `assets/images/bg_splash.webp` → `AppImages.bgSplash`.                                                |
| Fonts                     | `assets/fonts/Inter-*.ttf` (family `Inter`). Registered in `pubspec.yaml`, used in `app_fonts.dart`.  |

---

## Blocking gaps (1 clarifying question)

**The PRD references an API but does not specify the actual `baseUrl`/auth scheme or the exact value for `AppDurations.predictionLock` (lead time). Could you confirm the API base URL/auth and the intended lock duration (e.g., 60 minutes before kickoff)?**
