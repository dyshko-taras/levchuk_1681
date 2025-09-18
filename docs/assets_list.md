# 📦 Assets List

---

## 1. Icons (SVG)

**Navigation**

* `nav_matches.svg` (tab: Matches) &#x20;
* `nav_stats.svg` (tab: Statistics) &#x20;
* `nav_favorites.svg` (tab: Favorites) &#x20;
* `nav_profile.svg` (shortcut from Profile quick links) &#x20;

**Actions**

* `action_search.svg` (search in lists)
* `action_filter.svg` (filters modal on schedule) &#x20;
* `action_calendar.svg` (date picker / journal calendar) &#x20;
* `action_refresh.svg` (pull-to-refresh/refresh) &#x20;
* `action_settings.svg` (profile header / app settings) &#x20;
* `action_edit.svg` (edit prediction/name) &#x20;
* `action_save.svg` (dialogs save) &#x20;
* `action_back.svg` (top bars) &#x20;
* `action_close.svg` (dialogs close) &#x20;

**State / Status**

* `status_success.svg` (green check) &#x20;
* `status_error.svg` (red X) &#x20;
* `status_pending.svg` (clock) &#x20;

**Favorites & domain**

* `star.svg`, `star_filled.svg` (toggle favorites) &#x20;
* `league_ball.svg` (league card leading icon) &#x20;
* `team.svg` (team card meta) &#x20;
* `match.svg` (match card meta) &#x20;

**Charts (UI helpers)**

* `chart_donut.svg`, `chart_bar.svg`, `chart_line.svg` (legends/placeholders) &#x20;

> All icons are referenced via `AppIcons.*` (no raw paths).&#x20;

---

## 2. Backgrounds

* `bg_splash.webp` (splash backdrop, optional subtle texture) — pairs with logo on Splash &#x20;

---

## 3. Images

**Brand & common**

* `logo.webp` (app logo with transparency) &#x20;
* `welcome_hero.webp` (welcome illustration) &#x20;

**Empty states / placeholders**

* `empty_matches.webp` (no matches / filters result) &#x20;
* `empty_favorites_star.webp` (favorites empty state uses star visual) &#x20;
* `empty_predictions.webp` (no predictions yet) &#x20;
* `empty_stats.webp` (no data for charts yet) &#x20;
* `empty_journal.webp` (no entries for the day) &#x20;

**Profile**

* `avatars/avatar_01.png` … `avatars/avatar_06.png` (selectable avatars) &#x20;

> All raster images are referenced via `AppImages.*` (no raw paths).&#x20;

---

## 4. Fonts

* `Inter-Regular.ttf`
* `Inter-Medium.ttf`
* `Inter-SemiBold.ttf`
* `Inter-Bold.ttf`
* `Inter-ExtraBold.ttf`
* `Inter-Black.ttf`

Import via `pubspec.yaml`. 

---

## Note

- **SVG is the preferred format for all icons, badges, and UI elements** (navigation, action buttons, progress icons, etc.) for best scalability and clarity.
- For images without background (transparent), use **.webp** if SVG is not available.
- For images with background, use **.jpeg**.
- All backgrounds should be .webp or .jpeg.
- Only use .webp for UI elements if SVG is not available and transparency is required.