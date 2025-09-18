# 📱 Football Predictor

Версія: 1.0
Мова інтерфейсу: EN/UA (UA — основна)
Таймзона бізнес‑логіки: **Europe/Kyiv**
Цільові платформи: **Android, iOS** (Flutter)

---

## 0. Огляд продукту

**Призначення:** мобільний застосунок для перегляду футбольного розкладу, створення та ведення прогнозів, трекінгу результатів, персональних інсайтів і гейміфікації через ачивки.

**Ключові блоки:**

* Розклад матчів + фільтри (ліга, країна, статус, улюблені)
* Деталі матчу (інфо, коефіцієнти, нотатки, прогноз)
* Мої прогнози + історія
* Улюблені (ліги/команди/матчі)
* Статистика, Інсайти, Журнал
* Профіль користувача, бейджі/ачивки

## 1. Аутентифікація до зовнішнього API

* Базовий URL: `https://v3.football.api-sports.io`
* Ключ у хедері: `x-apisports-key: <API_KEY>`
* Загальні параметри: `timezone=Europe/Kyiv`
* Рейт‑ліміт: обробка 429 із експоненційною затримкою; кеш‑хіти для повторних запитів

**Інтерцептори:**

* Додавання API‑ключа
* Логування (debug)
* Ретрай (до 2 разів) при 5xx / timeouts із jitter

---

## 2. Схема локальної БД (спрощена)

**tables/collections:**

1. `leagues` `{league_id, name, country, season, logo, updated_at}`
2. `teams` `{team_id, name, league_id, country, logo, updated_at}`
3. `matches` `{fixture_id, league_id, home_id, away_id, date_utc, status, score_home, score_away, minute, venue, referee, country, season, last_synced_at}`
4. `odds_snapshots` `{id, fixture_id, taken_at, home, draw, away, source}`
5. `predictions` `{id, fixture_id, pick(H/D/A), placed_at, locked_at, odds_at_pick, result(W/L/Pending), resolved_at, source(opened_details bool), league_id, home_id, away_id}`
6. `favorites` `{id, type(league/team/match), ref_id, created_at}`
7. `notes` `{id, fixture_id, text, updated_at}`
8. `achievements` `{code, name, description, earned_at}`
9. `user_profile` `{id=1, username, avatar, metrics_cache(json), reset_markers}`

**Індекси:** по `fixture_id`, `league_id`, `team_id`, `date_utc`, `result`.

---

## 3. Мережеві ендпоїнти (mapping по функціоналу)

### 3.1. Довідники

* `GET /countries`
* `GET /leagues?country={NAME}&season={YYYY}` — для фільтра за країною
* `GET /teams?league={LEAGUE_ID}&season={YYYY}` — для логотипів та довідки

### 3.2. Матчі

* За датою: `GET /fixtures?date=YYYY-MM-DD&timezone=Europe/Kyiv`
* Live: `GET /fixtures?live=all&date=YYYY-MM-DD&timezone=Europe/Kyiv` (або без `date` — усі live)
* За статусом (приклади):

  * `status=NS` (не почався), `1H`, `HT`, `2H`, `ET`, `P`, `FT`, `AET`, `PEN`, `SUSP`, `PST`…
  * `GET /fixtures?status=FT&date=YYYY-MM-DD&timezone=Europe/Kyiv`
* За лігою: `GET /fixtures?league={LEAGUE_ID}&season={YYYY}&date=YYYY-MM-DD&timezone=Europe/Kyiv`
* Пакет: `GET /fixtures?ids=ID1-ID2-ID3&timezone=Europe/Kyiv`
* Конкретний матч: `GET /fixtures?id={FIXTURE_ID}&timezone=Europe/Kyiv`

### 3.3. Коефіцієнти (odds)

* Прематч: `GET /odds?fixture={FIXTURE_ID}`
* Live (за наявності плану): `GET /odds/live?fixture={FIXTURE_ID}` або `GET /odds/live/bets?fixture=...`

### 3.4. Статистика команд (для Tips/Info)

* `GET /teams/statistics?league={LEAGUE_ID}&season={YYYY}&team={TEAM_ID}`

**Поради:**

* Усі запити доповнювати `page=` за потреби
* Кешувати довідники (країни/ліги/команди) на 24 год
* Знімки odds зберігати при відкритті Details та при створенні/редагуванні прогнозу

---

## 4. Екрани та логіка

### 4.1. Splash Screen

* **UI:** логотип, темний фон, легка анімація (спалах стадіону/м’яча), підпис *“Football in your hands”*
* **Логіка:** 1.5–2 с → навігація:

  * Перший запуск: **Welcome**
  * Інакше: **Match Schedule**
* **API:** не потрібен

### 4.2. Welcome Screen

* **UI:** заголовок, підзаголовок, ілюстрація, кнопка **\[Get Started]**
* **Логіка:** одноразово (флаг у локальному сховищі), далі: Splash → Schedule
* **API:** не потрібен

### 4.3. Match Schedule Screen

* **UI:**

  * Top bar: “MATCH SCHEDULE”
  * Дати: ◀ Yesterday | Today | Tomorrow ▶
  * Лічильники: Predicted, Upcoming, Completed
  * **Filters (modal):** By League / Country / Status (Live, Upcoming, Finished) / Favorites
  * Карти матчів: **Upcoming / Live / Finished**
  * Bottom nav: 🏠 Matches (active), 📈 Stats, ⭐ Favorites, 👤 Profile

* **API‑потоки:**

  * Список за датою: `/fixtures?date=...&timezone=...`
  * Live індикатори: або окремий запит `/fixtures?live=all` (polling 30–60s), або поєднати
  * Фільтр ліги: `/fixtures?league={id}&season={YYYY}&date=...`
  * Фільтр країни: `leagues?country=...` → зібрати `league_id[]` → кілька викликів `fixtures`
  * Odds блок: `/odds?fixture={id}` (лениво на запит або при відкритті картки)

* **Локальна логіка:**

  * ⭐ toggle → `favorites`
  * Notes preview → з `notes` за `fixture_id`
  * “Predicted/Upcoming/Completed” — підрахунок з локальної БД (синхронізуючи результати матчів)

### 4.4. Match Details Screen

* **UI:**

  * Top bar: “MATCH SCHEDULE”, Back, Favorites
  * Match card (повтор з Schedule)
  * Tabs: **Info | Prediction | My Notes**

    * **Info:** стадіон, місто, рефері, форма
    * **Prediction:** кнопки H/D/A з поточними odds, підтвердження, статус, \[Edit Prediction]
    * **My Notes:** поле вводу, список останніх змін
  * Tip block (опціонально)
  * \[Back to Schedule]
  * Favorites Modal: рівень (ліга, команда, матч)

* **API‑потоки:**

  * Деталі матчу: `/fixtures?id={fixture}&timezone=...`
  * Odds: `/odds?fixture={fixture}` (+ `/odds/live?...` за потреби)
  * Статистика команд: `/teams/statistics?...`

* **Бізнес‑правила:**

  * Edit Prediction — лише до старту
  * Після FT: позначення **Correct/Missed**
  * Notes — локально (офлайн доступ)

### 4.5. My Predictions Screen

* **UI:**

  * Top bar: “My Predictions”
  * Cards: дата/час, ліга, статус (Pending/Correct/Missed), команди, прогноз + odds, note preview
  * Дії: \[Edit], \[Open Match], ⭐ toggle
  * Empty state: “No predictions yet” + \[Go to Matches]

* **API‑потоки:**

  * Оновлення статусів пачкою: `/fixtures?ids=...&timezone=...`
  * При редагуванні до старту — оновити odds: `/odds?fixture=...`

### 4.6. User Profile Screen

* **UI:**

  * Top bar: “Profile” + Settings
  * Header: Avatar, Username, \[Edit]
  * Badges
  * Summary: Total Predictions, Accuracy, Correct, Missed, Avg Odds, Predictions/Week
  * Recent predictions (5–6)
  * Quick links: Stats, My Predictions, Favorites, Insights, Journal
  * Danger zone: \[Reset Stats]
  * **Edit Modal:** вибір аватара (6), ім’я, \[Save]
  * **Reset Modal:** “Clear statistics / Clear all data”

* **API:** не обов’язковий (все з локальної БД); за потреби — підтягти дані матчів за `fixture_id`

### 4.7. Favorites Screen

* **UI:** Tabs: **Leagues | Teams | Matches**

  * League Card: назва, country, “Matches today”, \[View Matches], ⭐
  * Team Card: назва + логотип, ліга, Next match/Playing now, \[Predict Now]/\[Open Match], ⭐
  * Match Card: дата/час, команди, ліга, статус прогнозу, \[Open Match], ⭐

* **API‑потоки:**

  * Matches today (ліга): `/fixtures?league={id}&date=...&timezone=...`
  * Next match команди: `/fixtures?team={id}&next=1`

### 4.8. Statistics Screen

* **UI:**

  * Summary metrics: 🎯 Total, ✅ Correct, ❌ Incorrect, 📈 Accuracy, 🕒 Avg/Week, ⚖️ Avg Odds
  * Charts:

    1. Pie — розподіл H/D/A
    2. Bar — прогнози по днях тижня
    3. Line — тренд точності (4–8 тижнів)
  * Achievements mini‑badges + \[View All]
  * Footer: \[Reset], \[Back to Profile]

* **API:** не потрібен (усе з локальної БД) + періодична валідація результатів через `/fixtures?ids=`

### 4.9. Achievements / Leaderboard

* **UI:**

  * Top bar: “Achievements”
  * Summary: total badges, next milestone
  * List: earned (з датами) + locked (сіро)
  * Footer: \[Back to Profile]

* **API:** не потрібен (локальна логіка), опціонально підтвердити факти `FT`

### 4.10. Insights Screen

* **UI:**

  * Your Trends (Home Wins %, Draw Accuracy %, Avg Odds, Most Active Day)
  * Focus Points: Strengths/Weaknesses
  * Advice (tips з патернів)
  * Footer: \[Back to Stats], \[Improve Strategy]

* **API:** не потрібен (щотижнева перегенерація з локальних даних)

### 4.11. Prediction Journal Screen

* **UI:**

  * Top bar: “Prediction Journal” + Calendar
  * Навігація: Yesterday | Today | Tomorrow
  * Timeline by days: cards (Result + Prediction status), Notes (Add/Edit/Delete), Daily summary
  * Calendar modal: вибір дати

* **API:** не потрібен; результати підтверджуються пакетно `/fixtures?ids=`

---

## 5. Логіка ачивок (15)

**Загальні принципи:**

* Джерело правди — локальна БД `predictions` + підтверджені `FT` з `/fixtures`
* Ідемпотентність: кожна ачивка має `code`, `earned_at`; перевидача не допускається
* Тригери: при зміні `result`, при створенні/редагуванні, щоденний/щотижневий крон

### Volume‑based

1. **First Steps** — з’явився перший `Prediction` (будь‑який)
2. **Prediction Enthusiast** — `count(all) ≥ 25`
3. **Prediction Veteran** — `count(all) ≥ 75`
4. **Century Club** — `count(all) ≥ 100`
5. **Prediction Marathoner** — `count(all) ≥ 300`

### Performance‑based

6. **10 Wins in a Row** — послідовність `W` довжиною ≥10
7. **Perfect Day** — у добі (Europe/Kyiv) з ≥3 прогнозами всі `W`
8. **Streak Master** — `W`‑серія ≥20
9. **Cold Streak Survivor** — п’ять `L` підряд і наступний `W` (тригер на цьому `W`)
10. **Accuracy King** — 4 тижні поспіль `accuracy ≥ 70%` (тиждень = ISO або локальний понеділок‑неділя; зафіксувати визначення)

### Special & Odds‑based

11. **Underdog Hero** — `count(W where odds_at_pick > 3.0) ≥ 3`
12. **Balanced Mind** — у межах одного тижня: щонайменше **2 коректні Home**, **2 Draw**, **2 Away**
13. **World Explorer** — `count(distinct league_id where result=W) ≥ 5` *(за бажанням — distinct country ≥5)*
14. **Silent Sniper** — `count(W where opened_details=false) ≥ 10`
15. **Sharp Instincts** — `W` з `kickoff_time - placed_at < 10 хв`

**Дані, потрібні для правил:** `placed_at`, `locked_at` (час блокування
перед стартом), `odds_at_pick` (знімок), `opened_details` (подія UI), `fixture kickoff` із `/fixtures`.

---

## 6. Синхронізація та офлайн

* **Офлайн‑first:** усі дії (прогнози, нотатки, фаворити) — локально; при онлайн — пуш синхронізація (якщо з’явиться бекенд) або лише pull з зовнішнього API
* **Оновлення результатів:**

  * Планувальник: раз на 30 хв до 3 год після старту матчу; після FT — рідше
  * Пакетний запит `/fixtures?ids=` для всіх `Pending`
* **Кеш‑життєвий цикл:**

  * Розклад дня: 2–5 хв (при Live — 30–60 с poll)
  * Довідники: 24 год

---

## 7. Аналітика (події)

* `app_open`, `first_run_complete`
* `schedule_date_change`, `filters_open`, `filters_apply`, `card_open`
* `prediction_create`, `prediction_edit`, `prediction_delete`
* `favorite_add`, `favorite_remove`
* `note_add`, `note_edit`, `note_delete`
* `achievement_unlocked {code}`
* `insights_view`, `stats_view`, `journal_view`

---
